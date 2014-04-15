//
//  TLBPulldownSegmentedControl.h
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/14.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBPulldown.h"

@interface TLBPulldownSegmentedControl : TLBPulldown

/*
 * segmentedControl利用時に、左側に設定するラベル
 */
@property(nonatomic) NSString *segmentedControlLabel;

/*
 * segmentedControl利用時に、設定する項目の配列（NSString）
 */
@property(nonatomic) NSArray *segmentedControlItems;

/*
 * segmentedControl利用時に、初期設定するindex
 */
@property(nonatomic) NSUInteger segmentedControlDefaultIndex;

/*
 * segmentedControl利用時に、選択値が変化した時に実行するブロック
 */
@property(nonatomic, copy) void(^segmentedControlChangedBlock)(NSUInteger index);

@end
