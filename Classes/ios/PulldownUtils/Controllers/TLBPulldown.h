//
//  TLBPulldown.h
//  Picmina
//
//  Created by 田中 浩樹 on 2013/08/07.
//  Copyright (c) 2013年 teamLab Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLBPulldown : UILabel


/*
 * 何もない領域をタップで閉じるようにするか（default = YES）
 */
@property(nonatomic) BOOL closeActionEnabled;

/*
 * 日時指定モード
 */
@property(nonatomic) BOOL datetimeMode;

/*
 * データソースを読み込むためのブロック
 * 日時指定モードではこのブロックは無効
 *
 * @return データソースをNSStringで返却すること
 */
@property(nonatomic, copy) NSArray *(^dataSource)();

/*
 * 日時指定のフォーマット
 * 非日時指定モードではこのプロパティは無効
 */
@property(nonatomic) NSString *datetimeFormat;

/*
 * selfがタップされたときに実行されるブロック
 *
 * @param myself 自分自身
 * @param continuous このポインタの実体にYESを代入すると、pulldownを表示しない
 */
@property(nonatomic, copy) void(^tappedBlock)(TLBPulldown *myself, BOOL *continuous);

/*
 * selfの選択項目が変化したときに実行されるブロック
 *
 * @param myself 自分自身
 * @param result 変化後の値
 */
@property(nonatomic, copy) void(^valueChangedBlock)(TLBPulldown *myself, NSString *result);

/*
 * selfの編集が終了されたときに実行するブロック
 *
 * @param myself 自分自身
 * @param result 最終的な値
 */
@property(nonatomic, copy) void(^doneBlock)(TLBPulldown *myself, NSString *result);

#pragma mark - internal

- (UIView *)customAccessoryView;

- (void)valueChangedForPickerView:(NSString *)selectedString;
- (void)valueChangedForDatetimePickerView:(NSDate *)selectedDate;

- (void)doneForPickerView:(NSString *)selectedString;
- (void)doneForDatetimePickerView:(NSDate *)selectedDate;

- (void)closePickerView;

- (NSString *)selectedText;
- (NSDate *)selectedDate;

@end
