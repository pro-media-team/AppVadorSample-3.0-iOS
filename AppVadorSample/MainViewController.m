//
//  ViewController.m
//  AppVadorDev
//
//  Created by Hirohide Sano on 2014/11/03.
//  Copyright (c) 2014年 AppVador Inc. All rights reserved.
//

#import "MainController.h"
#import "MainViewController.h"

@interface MainViewController () {
    
}

@property APVAdManager *ad;
@property UIView *containerView;
@property UIView *adView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ad = [[APVAdManager alloc] initWithPubId:@"be799a9af42fd94b851539335d3713ab" withDelegate:self];
    self.ad.preloadType = APV_PRELOAD_ALL;
    self.ad.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [self.ad load];
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1024)];
    [self.scrollView addSubview: self.containerView];
    [self.scrollView setContentSize:CGSizeMake(320, 1024)];
    
    self.adView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 250)];
    [self.containerView addSubview: self.adView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma APVAdManagerDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)onFailedToPlayAd:(NSObject *)error
{
    NSLog(@"[MainViewController] failed to play ad %@", error);
}

- (void)onReadyToPlayAd
{
    NSLog(@"[MainViewController] ready to play ad");
    if (self.ad.isReady) {
        NSLog(@"[MainViewController] ad is ready");
        [self.ad showAdForView: self.adView];
    }
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

@end
