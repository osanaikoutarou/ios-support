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
 * プロパティのキー名に基づいてNSDictionaryを作成します。
 * ただし、@synthesizeでKVCに準拠しないインスタンス変数を用意した場合には、
 * そのプロパティは無視されます。
 *
 * @return NSDictionary
 */
- (NSDictionary *)contentsDictionary;

/*
 * NSDictionaryのデータをもとに、プロパティにデータを割り当てます。
 * プロパティが宣言されていないデータについては捨てられます。
 *
 * @param dataset NSJSONSerialization等で取得したNSDictionary
 */
- (void)assignValuesByContentsDictionary:(NSDictionary *)dataset;

/*
 * このメソッドをオーバライドしてYESを返すようにすると、
 * BOOL型のプロパティを@"true"または@"false"で扱うようになります。
 * NOの場合は1または0として扱います
 */
- (BOOL)convertBoolToString;

@end
