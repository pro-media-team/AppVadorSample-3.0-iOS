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
    self.title = @"Sample (ScrollView)";
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1024)];
    [self.scrollView addSubview: self.containerView];
    [self.scrollView setContentSize:CGSizeMake(320, 1024)];
    
    self.adView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 250)];
    [self.containerView addSubview: self.adView];
    
    UIButton *showAdButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showAdButton.frame = CGRectMake(0, 0, 320, 50);
    [showAdButton setTitle:@"ShowAd" forState:UIControlStateNormal];
    [showAdButton addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchDown];
    [self.containerView addSubview:showAdButton];
    
    [self initAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showAd
{
    [self initAd];
}

- (void)initAd
{
    if (self.ad != nil) {
        [self.ad removeAd];
        self.ad = nil;
    }
    
    // production demo "be799a9af42fd94b851539335d3713ab"
    self.ad = [[APVAdManager alloc] initWithPubId:@"be799a9af42fd94b851539335d3713ab" withDelegate:self];
    self.ad.preloadType = APV_PRELOAD_META;
    self.ad.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [self.ad load];
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
    NSLog(@"[MainViewController] playing");
}

- (void)onMuteAd
{
    NSLog(@"[MainViewController] mute");
}

- (void)onUnmuteAd
{
    NSLog(@"[MainViewController] unmute");
}

- (void)onCompletionAd
{
    NSLog(@"[MainViewController] complete");
}

- (void)onClickAd
{
    NSLog(@"[MainViewController] click");
}

- (void)onCloseAd
{
    NSLog(@"[MainViewController] close");
}

@end
