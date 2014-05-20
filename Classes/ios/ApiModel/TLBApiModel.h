//
//  TLBApiModel.h
//  ios-support
//
//  Created by Tanaka Hiroki on 2014/05/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * （！）このクラスを継承して使ってください。
 */

@interface TLBApiModel : NSObject

/*
 * NSDictionaryのデータをもとに、プロパティにデータを割り当てたオブジェクトを返します。
 *
 * ルール
 *     1. NSDictionaryのキー名と対応するプロパティ名がなければ無視します。
 *     2. プロパティのクラスとしてTLBApiModelのサブクラスを指定した場合は、
 *        そのサブクラスをインスタンス化したオブジェクトが格納されます。
 *        このときも、ルール1は適用されます。
 *     3. NSArrayについては、プロトコル名としてTLBApiModelのサブクラスのクラス名を指定すると、
 *        そのプロトコル名のクラスをインスタンス化したオブジェクトが格納されます。
 *        このときも、ルール1は適用されます。
 *
 * @param dataset NSJSONSerialization等で取得したNSDictionary
 * @return self
 */
- (instancetype)initWithContentsDictionary:(NSDictionary *)dataset;

/*
 * プロパティのキー名に基づいてNSDictionaryを作成します。
 *
 * ルール
 * 　　1. @synthesizeでKVCに準拠しないインスタンス変数を用意した場合にはそのプロパティのキーと値は無視されます。
 *
 * @return インスタンス
 */
- (NSDictionary *)contentsDictionary;

/*
 * このメソッドをオーバライドしてYESを返すようにすると、
 * BOOL型のプロパティを@"true"または@"false"として扱います。
 *
 * このメソッドをオーバライドしてNOを返すようにすると、
 * BOOL型のプロパティを1または0として扱います。
 *
 * デフォルト YES
 */
- (BOOL)convertBoolToString;

/*
 * このメソッドで指定したプロパティについてはnil値の場合でもオブジェクトを用意します。
 *
 * デフォルト @[]
 */
- (NSArray *)allowsNilValues;

@end
