//
//  NormalStyleViewController.m
//
//
//  Created by Hirohide Sano on 2014/11/03.
//  Copyright (c) 2014年 AppVador Inc. All rights reserved.
//

#import <AppVadorSDK/APVAdManager.h>
#import "NormalStyleViewController.h"

@interface NormalStyleViewController () {
}

@property UIScrollView *scrollView;
@property UIView *containerView;
@property UIView *adView;
@property UILabel *statusLabel;
@property UIButton *showButton;
@property APVAdManager *ad;

@end

@implementation NormalStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Normal Style";
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(320, 1024);
    [self.view addSubview:self.scrollView];
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 2048)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.containerView];
    
    self.adView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 250)];
    [self.containerView addSubview:self.adView];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 20)];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.statusLabel];
    
    self.showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.showButton.frame = CGRectMake(0, 0, 320, 50);
    self.showButton.enabled = NO;
    [self.showButton setTitle:@"ShowAd" forState:UIControlStateNormal];
    [self.showButton addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchDown];
    [self.containerView addSubview:self.showButton];
    
    [self initAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initAd
{
    if (self.ad != nil) {
        self.statusLabel.text = @"remove ad.";
        [self.ad removeAd];
        self.ad = nil;
    }
    
    // publication id for demo
    self.ad = [[APVAdManager alloc] initWithPubId:@"59d43dad47785b027efc76ef6013c9af" withDelegate:self];
    self.ad.preloadType = APV_PRELOAD_ALL;
    self.ad.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [self.ad load];
    self.showButton.enabled = NO;
    self.statusLabel.text = @"loading ad.";
}

- (void)showAd
{
    if (self.ad.isReady) {
        [self.ad showAdForView: self.adView];
    }
}

# pragma APVAdManagerDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)onFailedToPlayAd:(NSObject *)error
{
    self.statusLabel.text = @"Failed to play ad.";
}

- (void)onReadyToPlayAd
{
    NSLog(@"ready to play");
    self.showButton.enabled = YES;
    self.statusLabel.text = @"Ready to play ad.";
}

- (void)onPlayingAd
{
    NSLog(@"onplaying");
    self.statusLabel.text = @"Playing ad.";
}

- (void)onCompletionAd
{
    self.statusLabel.text = @"Complete ad.";
}

@end
