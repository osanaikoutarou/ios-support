//
//  TLBPulldownTableViewController.m
//  ios-support-demo
//
//  Created by Tanaka Hiroki on 2014/05/02.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBPulldownTableViewController.h"

#import "TLBPulldown.h"

@interface TLBPulldownTableViewController ()

@property(nonatomic, weak) IBOutlet TLBPulldown *birthday;
@property(nonatomic, weak) IBOutlet TLBPulldown *state;

@end

@implementation TLBPulldownTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // カラー設定マクロ
    self.tableView.backgroundColor = COLOR_BACK_MAIN;
    
    self.birthday.datetimeMode = YES;
    self.birthday.datetimeFormat = @"yyyy-MM-dd";
    self.birthday.datetimeLatestDate = [NSDate dateWithTimeIntervalSinceNow:0];
    
    self.state.text = @"東京都";
    self.state.dataSource = ^{
        return @[@"北海道",@"青森県",@"岩手県",@"宮城県",@"秋田県",@"山形県",@"福島県",@"茨城県",@"栃木県",@"群馬県",
                 @"埼玉県",@"千葉県",@"東京都",@"神奈川県",@"新潟県",@"富山県",@"石川県",@"福井県",@"山梨県",@"長野県",
                 @"岐阜県",@"静岡県",@"愛知県",@"三重県",@"滋賀県",@"京都府",@"大阪府",@"兵庫県",@"奈良県",@"和歌山県",
                 @"鳥取県",@"島根県",@"岡山県",@"広島県",@"山口県",@"徳島県",@"香川県",@"愛媛県",@"高知県",@"福岡県",
                 @"佐賀県",@"長崎県",@"熊本県",@"大分県",@"宮崎県",@"鹿児島県",@"沖縄県"];
    };
}

@end
