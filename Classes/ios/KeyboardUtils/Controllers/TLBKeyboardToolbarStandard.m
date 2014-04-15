//
//  TLBKeyboardToolbarStandard.m
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBKeyboardToolbarStandard.h"

@implementation TLBKeyboardToolbarStandard

#pragma mark button action

- (IBAction)cancelAction:(id)sender {
    [self completionWithResult:YES];
}

- (IBAction)doneAction:(id)sender {
    // バリデーション
    if (self.validationBlock) {
        if (!self.validationBlock()) {
            return;
        }
    }
    
    [self completionWithResult:NO];
}

- (void)completionWithResult:(BOOL)isCancelled {
    [self.rootView endEditing:YES];
    
    // ユーザ定義処理
    if (self.doneBlock) {
        self.doneBlock(isCancelled);
    }
}

@end
