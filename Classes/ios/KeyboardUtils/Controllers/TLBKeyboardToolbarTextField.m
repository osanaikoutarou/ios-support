//
//  TLBKeyboardToolbarTextField.m
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBKeyboardToolbarTextField.h"

@interface TLBKeyboardToolbarTextField ()

@property(nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation TLBKeyboardToolbarTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addNotifications];
    }
    return self;
}

- (void)dealloc {
    [self removeNotifications];
}

#pragma mark setter/getter

- (void)setDefaultValue:(NSString *)defaultValue {
    _defaultValue = defaultValue;
    
    self.textField.text = defaultValue;
}

- (NSString *)placeholderValue {
    return self.textField.placeholder;
}

- (void)setPlaceholderValue:(NSString *)placeholderValue {
    self.textField.placeholder = placeholderValue;
}

#pragma mark button action

- (IBAction)cancelAction:(id)sender {
    // テキストはデフォルトに戻しておく
    self.textField.text = self.defaultValue;
    
    [self completionWithResult:YES];
}

- (IBAction)doneAction:(id)sender {
    // バリデーション
    if (self.validationBlock) {
        if (!self.validationBlock(self.textField.text)) {
            return;
        }
    }
    
    // デフォルトを更新する
    self.defaultValue = self.textField.text;
    
    [self completionWithResult:NO];
}

- (void)completionWithResult:(BOOL)isCancelled {
    // self.textFieldとキーボード呼び出し元のresponderの
    // 両方のレスポンダをresignするために2回呼ぶ
    [self.rootView endEditing:YES];
    [self.rootView endEditing:YES];
    
    // ユーザ定義処理
    if (self.doneBlock) {
        self.doneBlock(isCancelled, self.textField.text);
    }
}

#pragma mark keyboard

- (void)addNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(focusTextField:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)removeNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)focusTextField:(NSNotification *)aNotif {
    [self.textField becomeFirstResponder];
}

@end
