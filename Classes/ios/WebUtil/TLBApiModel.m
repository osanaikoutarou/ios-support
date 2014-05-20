//
//  TLBApiModel.m
//  ios-support
//
//  Created by Tanaka Hiroki on 2014/05/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBApiModel.h"
#import <objc/runtime.h>

#define PROPERTY_TYPE_BOOL @"c"
#define PROPERTY_TYPE_INT @"i"
#define PROPERTY_TYPE_UINT @"I"

@implementation TLBApiModel

- (instancetype)initWithContentsDictionary:(NSDictionary *)dataset {
    self = [super init];
    if (self) {
        [self assignValuesByContentsDictionary:dataset];
    }
    return self;
}

- (NSDictionary *)contentsDictionary {
    NSMutableDictionary *dataset = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [self valueForKey:propertyName];
        
//        NSLog(@"%@", [self propertyType:property]);
        
        // auto-synthesizeされていないプロパティは除く
        char *ivar = property_copyAttributeValue(property, "V");
        if (ivar) {
            // Check if ivar has KVC-compliant name
            NSString *ivarName = @(ivar);
            
            if (![ivarName isEqualToString:propertyName] &&
                ![ivarName isEqualToString:[@"_" stringByAppendingString:propertyName]]) {
                free(ivar);
                continue;
            } else {
                free(ivar);
            }
        }
        
        // 値のnullチェック（ここではnilチェックのみ行う）
        if (propertyValue) {
            propertyValue = [self contentsInValue:propertyValue property:property];
            
            if (!propertyValue) {
                if (![[self allowsNilValues] containsObject:propertyName]) {
                    continue;
                }
                
                // 強制的にオブジェクトを作る対象
                NSString *propType = [self propertyType:property];
                NSString *className = propType;
                NSString *protocolName = nil;
                [self getProperty:propType className:&className propertyProtocolName:&protocolName];
                Class propClass = NSClassFromString(className);
                propertyValue = [[propClass alloc] init];
            }
            
            [dataset setObject:propertyValue forKey:propertyName];
        } else if ([[self allowsNilValues] containsObject:propertyName]) {
            // 強制的にオブジェクトを作る対象
            NSString *propType = [self propertyType:property];
            NSString *className = propType;
            NSString *protocolName = nil;
            [self getProperty:propType className:&className propertyProtocolName:&protocolName];
            Class propClass = NSClassFromString(className);
            propertyValue = [[propClass alloc] init];
            [dataset setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    
    return dataset;
}

#pragma mark - internal

- (id)contentsInValue:(id)propertyValue property:(objc_property_t)property {
    // NSStringは文字数0もnullとみなす
    if ([propertyValue isKindOfClass:[NSString class]] && [propertyValue length] == 0) {
        return nil;
    }
    
    // （NSNumberはnilのみ）
    else if ([propertyValue isKindOfClass:[NSNumber class]]) {
        if ([self convertBoolToString]) {
            // タイプが'c'で、且つ0か1なら、BOOLとみなして、true/falseに書き換える
            NSString *type = [self propertyType:property];
            if ([type isEqualToString:PROPERTY_TYPE_BOOL]) {
                if ([propertyValue isEqualToNumber:@0]) {
                    propertyValue = @"false";
                } else if ([propertyValue isEqualToNumber:@1]) {
                    propertyValue = @"true";
                }
            }
        }
        
        // no-op
    }
    
    // NSArrayは空もnullとみなす
    else if ([propertyValue isKindOfClass:[NSArray class]]) {
        if ([propertyValue count] == 0) {
            return nil;
        }
        
        NSMutableArray *data = [NSMutableArray array];
        for (id child in propertyValue) {
            id childValue = [self contentsInValue:child property:property];
            
            if (childValue) {
                [data addObject:childValue];
            }
        }
        
        return ([data count] == 0) ? nil : data;
    }
    
    // NSDictionaryは空もnullとみなす
    else if ([propertyValue isKindOfClass:[NSDictionary class]]) {
        if ([propertyValue count] == 0) {
            return nil;
        }
        
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        NSArray *allKeys = [propertyValue allKeys];
        for (NSString *child in allKeys) {
            id childValue = [self contentsInValue:propertyValue[child] property:property];
            
            if (childValue) {
                [data setObject:childValue forKey:child];
            }
        }
        
        return ([data count] == 0) ? nil : data;
    }
    
    // TLBApiModelの場合はNSDictionaryに変換する
    else if ([propertyValue isKindOfClass:[TLBApiModel class]]) {
        NSDictionary *dict = [propertyValue contentsDictionary];
        
        if (!dict || [dict count] == 0) {
        return nil;
        }
        
        propertyValue = dict;
    }
    
    // その他はdescriptionに一旦変換する
    else {
        NSString *desc = [propertyValue description];
        
        if (!desc || [desc length] == 0) {
        return nil;
        }
        
        propertyValue = desc;
    }
    
    return propertyValue;
}

- (void)assignValuesByContentsDictionary:(NSDictionary *)dataset {
    for (NSString *key in [dataset allKeys]) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            // 基本的な情報の取得
            objc_property_t prop = class_getProperty([self class], [key UTF8String]);
            NSString *propType = [self propertyType:prop];
            NSString *className = propType;
            NSString *protocolName = nil;
            
            // クラス名とプロトコル名に分離
            [self getProperty:propType className:&className propertyProtocolName:&protocolName];
            
            // クラスオブジェクト
            Class modelClass = NSClassFromString(className);
            
            // TLBApiModelの場合は更にアサインする
            if ([modelClass isSubclassOfClass:[TLBApiModel class]]) {
                id model = [[modelClass alloc] init];
                [model assignValuesByContentsDictionary:dataset[key]];
                [self setValue:model forKey:key];
                continue;
            }
            
            // NSArrayはプロトコルチェックをする
            if ([modelClass isSubclassOfClass:[NSArray class]]) {
                // プロトコルは1種のみ指定可能
                if (protocolName) {
                    Class subModelClass = NSClassFromString(protocolName); // プロトコル名からクラスオブジェクトの生成を試みる
                    if (subModelClass && [subModelClass isSubclassOfClass:[TLBApiModel class]]) {
                        NSMutableArray *datasetInner = [NSMutableArray array];
                        
                        // NSArrayの各要素について評価する
                        for (id value in dataset[key]) {
                            id model = [[subModelClass alloc] init];
                            [model assignValuesByContentsDictionary:value];
                            [datasetInner addObject:model];
                        }
                        
                        [self setValue:datasetInner forKey:key];
                        
                        continue;
                    } else {
                        NSLog(@"Warning: protocol '%@' of property '%@' is not found.", protocolName, key);
                    }
                } else {
                    // プロトコルがない場合はそのままにする
                    [self setValue:dataset[key] forKey:key];
                }
            }
            
            if ([self convertBoolToString]) {
                if ([propType isEqualToString:PROPERTY_TYPE_BOOL]) {
                    NSString *value = dataset[key];
                    if ([value isEqualToString:@"true"]) {
                        [self setValue:@YES forKey:key];
                    } else {
                        [self setValue:@NO forKey:key];
                    }
                } else {
                    [self setValue:dataset[key] forKey:key];
                }
            } else {
                [self setValue:dataset[key] forKey:key];
            }
            
        } else {
            NSLog(@"Warning: property '%@' is not found.", key);
        }
    }
}

- (NSString *)propertyType:(objc_property_t)property {
    const char *attributes = property_getAttributes(property);
//    NSLog(@"attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            return [[NSString alloc] initWithData:[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] encoding:NSUTF8StringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return @"id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            return [[NSString alloc] initWithData:[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] encoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

- (void)getProperty:(NSString *)propType className:(NSString **)className propertyProtocolName:(NSString **)protocolName {
    NSError *error;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"^(.+)<(.+)>$"
                                                                            options:0
                                                                              error:&error];
    NSTextCheckingResult *match = [regexp firstMatchInString:propType options:0 range:NSMakeRange(0, propType.length)];
    if (match.numberOfRanges == 3) {
        *className = [propType substringWithRange:[match rangeAtIndex:1]];
        *protocolName = [propType substringWithRange:[match rangeAtIndex:2]];
    }
}

#pragma mark - overridden

- (BOOL)convertBoolToString {
    return YES;
}

- (NSArray *)allowsNilValues {
    return @[];
}

@end
