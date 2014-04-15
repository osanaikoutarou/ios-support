//
//  TLBPulldownViewController.m
//  Picmina
//
//  Created by 田中 浩樹 on 2013/08/07.
//  Copyright (c) 2013年 teamLab Inc. All rights reserved.
//

#import "TLBPulldownViewController.h"

#import "TLBPulldown.h"
#import "TLBPulldownSegmentedControl.h"

#import "TLBKeyboardToolbarHelper.h"
#import "TLBKeyboardToolbarSegmentedControl.h"

@interface TLBPulldownViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic) TLBPulldown *manager;

@property(nonatomic) NSArray *dataSource;

@property(weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property(weak, nonatomic) IBOutlet UIPickerView *picker;

@property(nonatomic) NSUInteger selectedRow;

@end

@implementation TLBPulldownViewController

+ (instancetype)pulldownViewControllerWithManager:(TLBPulldown *)manager {
    id obj = [TLBPulldownViewController alloc];
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
    [self.picker setBackgroundColor:[UIColor whiteColor]];
    
    // データソースを読み込む
    self.dataSource = @[];
    if (self.manager.dataSource) {
        self.dataSource = self.manager.dataSource();
    }
    
    // 検索
    [self.picker selectRow:0 inComponent:0 animated:NO];
    if (self.dataSource.count == 1) {
        // 1つしかないときはそれを選択状態にする
        [self.manager valueChangedForPickerView:[[self.dataSource objectAtIndex:0] objectAtIndex:0]];
    } else if ([self.dataSource containsObject:self.manager.text]) {
        self.selectedRow = [self.dataSource indexOfObject:self.manager.text];
        [self.picker selectRow:self.selectedRow inComponent:0 animated:NO];
    }
}

// 空の領域にある透明なボタンがタップされたときに呼び出されるメソッド
- (IBAction)closePickerView:(id)sender {
    // PickerViewを閉じるための処理を呼び出す
    [self.manager doneForPickerView:[self.dataSource objectAtIndex:self.selectedRow]];
}

- (NSString *)selectedText {
    return [self.dataSource objectAtIndex:self.selectedRow];
}

#pragma mark picker view data source

// PickerViewの列数を指定するメソッド
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// PickerViewに表示する行数を指定するメソッド
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

// PickerViewの各行に表示する文字列を指定するメソッド
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@", [self.dataSource objectAtIndex:row]];
}

#pragma mark picker view delegate

// PickerViewで要素が選択されたときに呼び出されるメソッド
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // デリゲート先の処理を呼び出し、選択された文字列を親Viewに表示させる
    self.selectedRow = row;
    [self.manager valueChangedForPickerView:[self.dataSource objectAtIndex:self.selectedRow]];
}

#pragma mark dealloc

- (void)dealloc {
    self.manager = nil;
    self.dataSource = nil;
}

@end
