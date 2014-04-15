//
//  TLBPulldownViewController.h
//  Picmina
//
//  Created by 田中 浩樹 on 2013/08/07.
//  Copyright (c) 2013年 teamLab Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLBPulldown;

@interface TLBPulldownDatetimeViewController : UIViewController

/*
 * ファクトリメソッド
 */
+ (instancetype)pulldownDateTimeViewControllerWithManager:(TLBPulldown *)pulldown;

- (NSDate *)selectedDate;

@end
