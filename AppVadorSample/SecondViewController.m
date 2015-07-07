//
//  ViewController.m
//  AppVadorDev
//
//  Created by Hirohide Sano on 2014/11/03.
//  Copyright (c) 2014年 AppVador Inc. All rights reserved.
//

#import "MainController.h"
#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic) NSMutableDictionary *ads;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sample (UITableView)";
    self.tableView.delegate = self;
    self.ads = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < 3; i++) {
        // production demo "be799a9af42fd94b851539335d3713ab"
        APVAdManager *ad = [[APVAdManager alloc] initWithPubId:@"be799a9af42fd94b851539335d3713ab" withDelegate:self];
        ad.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        [ad load];
        NSNumber *key = [NSNumber numberWithInt:(i + 1) * 3];
        [self.ads setObject:ad forKey:key];
    }
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

- (void)onFailedToPlayAd:(NSObject *)error
{
    NSLog(@"[SecondViewController] failed to play ad %@", error);
}

- (void)onReadyToPlayAd
{
    NSLog(@"[SecondViewController] ready to play ad");
}

- (void)onPlayingAd
{
    NSLog(@"[SecondViewController] playing");
}

- (void)onMuteAd
{
    NSLog(@"[SecondViewController] mute");
}

- (void)onUnmuteAd
{
    NSLog(@"[SecondViewController] unmute");
}

- (void)onCompletionAd
{
    NSLog(@"[SecondViewController] complete");
}

- (void)onClickAd
{
    NSLog(@"[SecondViewController] click");
}

- (void)onCloseAd
{
    NSLog(@"[SecondViewController] close");
}

# pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"apv"];
    
    NSNumber *key = [NSNumber numberWithInt:(int)indexPath.item];
    APVAdManager *ad = [self.ads objectForKey:key];
    if (ad) {
        [ad showAdForView:cell withRect:CGRectMake(0, 0, 320, 180)];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"test %d", (int)indexPath.item];
    }
    
    return cell;
}

@end
