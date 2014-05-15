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
            // NSStringは文字数0もnullとみなす
            if ([propertyValue isKindOfClass:[NSString class]] && [propertyValue length] == 0) {
                continue;
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
            
            // NSSArrayは空もnullとみなす
            else if ([propertyValue isKindOfClass:[NSArray class]] && [propertyValue count] == 0) {
                continue;
            }
            
            // NSDictionaryは空もnullとみなす
            else if ([propertyValue isKindOfClass:[NSDictionary class]] && [propertyValue count] == 0) {
                continue;
            }
            
            // TLBApiModelの場合はNSDictionaryに変換する
            else if ([propertyValue isKindOfClass:[TLBApiModel class]]) {
                NSDictionary *dict = [propertyValue contentsDictionary];
                
                if (!dict || [dict count] == 0) {
                    continue;
                }
                
                propertyValue = dict;
            }
            
            // その他はdescriptionに一旦変換する
            else {
                NSString *desc = [propertyValue description];
                
                if (!desc || [desc length] == 0) {
                    continue;
                }
                
                propertyValue = desc;
            }
            
            [dataset setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    
    return dataset;
}

- (void)assignValuesByContentsDictionary:(NSDictionary *)dataset {
    for (NSString *key in [dataset allKeys]) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            // 型判定をする
            objc_property_t prop = class_getProperty([self class], [key UTF8String]);
            NSString *propType = [self propertyType:prop];
            
            // TLBApiModelの場合は更にアサインする
            Class modelClass = NSClassFromString(propType);
            if ([modelClass isSubclassOfClass:[TLBApiModel class]]) {
                id model = [[modelClass alloc] init];
                [model assignValuesByContentsDictionary:dataset[key]];
                [self setValue:model forKey:key];
                continue;
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

#pragma mark - internal

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

#pragma mark - overridden

- (BOOL)convertBoolToString {
    return YES;
}

@end
