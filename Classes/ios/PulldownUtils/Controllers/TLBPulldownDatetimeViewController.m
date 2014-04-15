//
//  TLBPulldownViewController.m
//  Picmina
//
//  Created by 田中 浩樹 on 2013/08/07.
//  Copyright (c) 2013年 teamLab Inc. All rights reserved.
//

#import "TLBPulldownDatetimeViewController.h"

#import "TLBPulldown.h"
#import "TLBPulldownSegmentedControl.h"

#import "TLBKeyboardToolbarHelper.h"
#import "TLBKeyboardToolbarSegmentedControl.h"

@interface TLBPulldownDatetimeViewController ()

@property(nonatomic) TLBPulldown *manager;

@property(weak, nonatomic) IBOutlet UIButton *closeButton;
@property(weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property(weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation TLBPulldownDatetimeViewController

+ (instancetype)pulldownDateTimeViewControllerWithManager:(TLBPulldown *)manager {
    id obj = [TLBPulldownDatetimeViewController alloc];
    [obj setManager:manager];
    NSString *suffix = (UIScreen.mainScreen.bounds.size.height > 480) ? @"iPhone5" : @"iPhone";
    NSString *nibName = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([obj class]), suffix];
    return [obj initWithNibName:nibName bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // アクセサリービューの追加
    UIView *customAccessoryView = [self.manager customAccessoryView];
    [customAccessoryView setFrame:self.toolbar.frame];
    [self.toolbar.superview addSubview:customAccessoryView];
    [self.toolbar removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    // 背景を白にする
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
    
    // 日付をセット
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = self.manager.datetimeFormat;

    id date = [formatter dateFromString:self.manager.text];
    if ([date isKindOfClass:[NSDate class]]) {
        self.datePicker.date = (NSDate *) date;
    }
    
    if (!self.manager.closeActionEnabled) {
        [self.closeButton removeFromSuperview];
    }
}

// 空の領域にある透明なボタンがタップされたときに呼び出されるメソッド
- (IBAction)closePickerView:(id)sender {
    // PickerViewを閉じるための処理を呼び出す
    [self.manager doneForDatetimePickerView:self.datePicker.date];
}

- (NSDate *)selectedDate {
    return self.datePicker.date;
}

#pragma mark - date time picker method

- (IBAction)datePickerDidChangeValue:(UIDatePicker *)picker {
    // 日付の表示形式を設定
    [self.manager valueChangedForDatetimePickerView:self.datePicker.date];
}

#pragma mark dealloc

- (void)dealloc {
    self.manager = nil;
}

@end
