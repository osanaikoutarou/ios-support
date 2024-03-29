//
//  TLBPulldown.m
//  Picmina
//
//  Created by 田中 浩樹 on 2013/08/07.
//  Copyright (c) 2013年 teamLab Inc. All rights reserved.
//

#import "TLBPulldown.h"

#import "TLBKeyboardToolbarHelper.h"
#import "TLBKeyboardToolbarStandard.h"

#import "TLBPulldownViewController.h"
#import "TLBPulldownDatetimeViewController.h"

@interface TLBPulldown ()

// 自身がViewControllerの所有者になるため、strongとする
@property(nonatomic) TLBPulldownViewController *pulldownVC;
@property(nonatomic) TLBPulldownDatetimeViewController *pulldownDatetimeVC;

// 現在の選択位置を保持
@property(nonatomic) NSIndexPath *indexPath;

// 連打による多重表示を防ぐためのセマフォ
@property(nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation TLBPulldown

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // pulldownを表示させるためのジェスチャをはりつける
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replaceToPulldown:)];
        gesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:gesture];
        
        self.closeActionEnabled = YES;
        self.semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)replaceToPulldown:(UITapGestureRecognizer *)gesture {
    // ルートビューを探して、ファーストレスポンダを放棄させる
    UIView *parentView = self;
    while (parentView.superview) {
        parentView = parentView.superview;
    }
    [parentView endEditing:YES];
    
    // 排他処理開始
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    // 既に用意されている場合は処理しない
    if (self.pulldownVC || self.pulldownDatetimeVC) {
        dispatch_semaphore_signal(self.semaphore);
        return;
    }
    
    // タップ時のブロックを実行
    if (self.tappedBlock) {
        BOOL continuous = YES;
        self.tappedBlock(self, &continuous);
        if (!continuous) {
            dispatch_semaphore_signal(self.semaphore);
            return;
        }
    }
    
    if (self.datetimeMode) {
        self.pulldownDatetimeVC = [TLBPulldownDatetimeViewController pulldownDateTimeViewControllerWithManager:self];
        
        // ピッカービューを表示
        [self openPickerView:self.pulldownDatetimeVC];
    } else {
        // ピッカービューを設定
        if (!self.dataSource) {
            [NSException raise:@"NSRuntimeException" format:@"Data source not found."];
        }
        
        // PickerViewControllerのインスタンスをStoryboardから取得
        self.pulldownVC = [TLBPulldownViewController pulldownViewControllerWithManager:self];
        
        // 型チェック
        NSMutableArray *dataSourceOrigin = [self.dataSource() mutableCopy];
        if (![dataSourceOrigin isKindOfClass:[NSArray class]] || dataSourceOrigin.count < 1) {
            NSLog(@"WARNING: TLBPulldown: data source must be an array.");
        }
        
        // ピッカービューを表示
        [self openPickerView:self.pulldownVC];
    }
    
    // 排他処理終わり
    dispatch_semaphore_signal(self.semaphore);
}

- (void)openPickerView:(UIViewController *)viewController {
    // PickerViewControllerのインスタンスをStoryboardから取得し
    
    // PickerViewをサブビューとして表示する
    // 表示するときはアニメーションをつけて下から上にゆっくり表示させる
    
    // アニメーション完了時のPickerViewの位置を計算
    UIView *pickerView = viewController.view;
    CGPoint middleCenter = pickerView.center;
    
    // アニメーション開始時のPickerViewの位置を計算
    UIWindow *mainWindow = UIApplication.sharedApplication.delegate.window;
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    pickerView.center = offScreenCenter;
    
    [mainWindow addSubview:pickerView];
    
    // アニメーションを使ってPickerViewをアニメーション完了時の位置に表示されるようにする
    [UIView animateWithDuration:0.3 animations:^{
        pickerView.center = middleCenter;
    }];
}

- (void)closePickerView {
    UIView __weak *wPickerView = nil;
    if (self.pulldownVC) {
        wPickerView = self.pulldownVC.view;
    } else if (self.pulldownDatetimeVC) {
        wPickerView = self.pulldownDatetimeVC.view;
    }
    
    // PickerViewをアニメーションを使ってゆっくり非表示にする
    TLBPulldown __weak *wSelf = self;
    
    // アニメーション完了時のPickerViewの位置を計算
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView animateWithDuration:0.3 animations:^{
        wPickerView.center = offScreenCenter;
    }                completion:^(BOOL finished) {
        // PickerViewをサブビューから削除
        [wPickerView removeFromSuperview];
        
        wSelf.pulldownVC = nil; // ViewControllerを開放
        wSelf.pulldownDatetimeVC = nil; // ViewControllerを開放
    }];
}

#pragma mark internal

- (UIView *)customAccessoryView {
    TLBKeyboardToolbarStandard *accessoryView = [TLBKeyboardToolbarHelper instantiateStandardWithRootView:nil];
    
    // ボタン色の指定があれば反映
    if (self.accessoryViewTintColor) {
        for (id material in accessoryView.subviews) {
            if ([NSStringFromClass([material class]) isEqual:@"UIToolbarTextButton"]) {
                UIBarButtonItem *button = (UIBarButtonItem *)material;
                button.tintColor = self.accessoryViewTintColor;
            }
        }
    }

    accessoryView.doneBlock = ^(BOOL isCancelled) {
        if (!isCancelled) {
            [self doneForPickerView:[self selectedText]];
            [self doneForDatetimePickerView:[self selectedDate]];
        } else {
            [self closePickerView];
        }
    };
    
    return (UIView *) accessoryView;
}

- (void)valueChangedForPickerView:(NSString *)selectedString {
    if (!self.pulldownVC) {
        return;
    }
    
    self.text = selectedString;
    
    if (self.valueChangedBlock) {
        self.valueChangedBlock(self, self.text);
    }
}

- (void)valueChangedForDatetimePickerView:(NSDate *)selectedDate {
    if (!self.pulldownDatetimeVC) {
        return;
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = self.datetimeFormat;
    self.text = [df stringFromDate:selectedDate];
    
    if (self.valueChangedBlock) {
        self.valueChangedBlock(self, self.text);
    }
}

- (void)doneForPickerView:(NSString *)selectedString {
    if (!self.pulldownVC) {
        return;
    }
    
    [self valueChangedForPickerView:selectedString];
    
    if (self.doneBlock) {
        self.doneBlock(self, selectedString);
    }
    
    [self closePickerView];
}

- (void)doneForDatetimePickerView:(NSDate *)selectedDate {
    if (!self.pulldownDatetimeVC) {
        return;
    }
    
    [self valueChangedForDatetimePickerView:selectedDate];
    
    if (self.doneBlock) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = self.datetimeFormat;
        self.doneBlock(self, [df stringFromDate:selectedDate]);
    }
    
    [self closePickerView];
}

- (NSString *)selectedText {
    if (self.pulldownVC) {
        return [self.pulldownVC selectedText];
    }
    
    return nil;
}

- (NSDate *)selectedDate {
    if (self.pulldownDatetimeVC) {
        return [self.pulldownDatetimeVC selectedDate];
    }
    
    return nil;
}

#pragma mark dealloc

- (void)dealloc {
    if (self.pulldownVC) {
        [self.pulldownVC.view removeFromSuperview];
        self.pulldownVC = nil;
    }
    
    if (self.pulldownDatetimeVC) {
        [self.pulldownDatetimeVC.view removeFromSuperview];
        self.pulldownDatetimeVC = nil;
    }
    
#if !OS_OBJECT_USE_OBJC
    dispatch_release(self.semaphore);
#endif
}

@end
