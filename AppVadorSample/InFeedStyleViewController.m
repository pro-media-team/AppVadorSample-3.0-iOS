//
//  InFeedStyleViewController.m
//  
//
//  Created by Hirohide Sano on 2014/11/03.
//  Copyright (c) 2014年 AppVador Inc. All rights reserved.
//

#import "MainController.h"
#import "InFeedStyleViewController.h"

@interface InFeedStyleViewController ()

@property (nonatomic) APVAdManager *ad1;
@property (nonatomic) APVAdManager *ad2;

@end

@implementation InFeedStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sample (UITableView)";
    self.tableView.delegate = self;

    // 2つの動画を先読みする
    self.ad1 = [[APVAdManager alloc] initWithPubId:@"59d43dad47785b027efc76ef6013c9af" withDelegate:self];
    self.ad1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [self.ad1 load];

    self.ad2 = [[APVAdManager alloc] initWithPubId:@"59d43dad47785b027efc76ef6013c9af" withDelegate:self];
    self.ad2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [self.ad2 load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma APVAdManagerDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

# pragma UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"apv"];
    // 3番目と6番目に動画枠を表示する。
    if (indexPath.row == 2 && self.ad1.isReady) {
        [self.ad1 showAdForView:cell withRect:CGRectMake(0, 0, 320, 180)];
    } else if (indexPath.row == 5 && self.ad2.isReady) {
        [self.ad2 showAdForView:cell withRect:CGRectMake(0, 0, 320, 180)];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"test %d", (int)indexPath.item];
    }
    
    return cell;
}

@end
