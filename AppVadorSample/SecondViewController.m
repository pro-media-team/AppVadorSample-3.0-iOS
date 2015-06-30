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

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property APVAdManager *ad;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // test "be799a9af42fd94b851539335d3713ab"
    // scaleout "2ed7bf2abc4130eca582aae77bcd35db"
    // dev "6bbbe1585dc2be1962a437db80636d01", Env.DEVELOPMENT
    
    self.tableView.delegate = self;
    
    self.ad = [[APVAdManager alloc] initWithPubId:@"6bbbe1585dc2be1962a437db80636d01"
                                     withDelegate:self
                                          withEnv:APV_ENV_DEVELOPMENT];
    self.ad.preloadType = APV_PRELOAD_ALL;
    self.ad.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [self.ad load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma APVAdManagerDelegate

- (void)onFailedToPlayAd:(NSObject *)error
{
    NSLog(@"[MainViewController] failed to play ad %@", error);
}

- (void)onReadyToPlayAd
{
    NSLog(@"[MainViewController] ready to play ad");
}

- (void)onPlayingAd
{
    
}

- (void)onMuteAd
{
    
}

- (void)onUnmuteAd
{
    
}

- (void)onCompletionAd
{
    
}

- (void)onClickAd
{
    
}

- (void)onCloseAd
{
    
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
    
    if (indexPath.item == 3) {
        [self.ad showAdForView: cell withRect:CGRectMake(0, 0, 320, 200)];
    } else {
        cell.textLabel.text = @"test";
    }
    
    return cell;
}

@end
