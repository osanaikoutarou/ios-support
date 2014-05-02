//
//  TLBKeyboardAccessoryTableViewController.m
//  ios-support-demo
//
//  Created by Tanaka Hiroki on 2014/05/02.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBKeyboardAccessoryTableViewController.h"

#import "TLBKeyboardToolbarHelper.h"

@interface TLBKeyboardAccessoryTableViewController () <UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UILabel *sendingType;
@property(nonatomic, weak) IBOutlet UITextField *mailAddress;

@end

@implementation TLBKeyboardAccessoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TLBKeyboardToolbarSegmentedControl *accessoryView = [TLBKeyboardToolbarHelper instantiateSegmentedControlWithRootView:self.view];
    
    __typeof__(self) __weak wSelf = self;
    
    accessoryView.titleValue = @"Type";
    accessoryView.segmentedControlLists = @[@"To:", @"Cc:", @"Bcc:"];
    accessoryView.defaultIndex = 0;
    accessoryView.doneBlock = ^(BOOL isCancelled, NSUInteger resultIndex, NSString *resultText) {
        wSelf.sendingType.text = resultText;
    };
    
    self.mailAddress.inputAccessoryView = accessoryView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

@end
