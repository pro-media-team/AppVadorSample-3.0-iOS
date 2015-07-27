//
//  InterstitialViewController.m
//  
//
//  Created by Hirohide Sano on 2015/07/27.
//  Copyright (c) 2015年 AppVador Inc. All rights reserved.
//

#import "InterstitialViewController.h"

@interface InterstitialViewController () {
}

@property UIView *containerView;
@property UILabel *statusLabel;
@property UIButton *showButton;
@property (nonatomic) APVInterstitialAd *interstitialAd;

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Interstitial";
    
    
    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 20)];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.statusLabel];
    
    self.showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.showButton.frame = CGRectMake(0, 50, 320, 50);
    self.showButton.enabled = NO;
    [self.showButton setTitle:@"Show interstitial ad" forState:UIControlStateNormal];
    [self.showButton addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchDown];
    [self.containerView addSubview:self.showButton];
    
    [self initAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initAd
{
    // publication id for demo
    self.interstitialAd = [[APVInterstitialAd alloc] initWithPubId:@"b7e66fe8956e0f2aaf1ee10b75b5eb47" withDelegate:self];
    [self.interstitialAd load];
    self.showButton.enabled = NO;
    self.statusLabel.text = @"loading ad.";
}

- (void)showAd
{
    if (self.interstitialAd.isReady) {
        [self.interstitialAd presentFromRootViewController:self];
    }
}

# pragma APVInterstitialAdDelegate

- (void)interstitialDidFailedToPlay:(NSObject *)error
{
    self.statusLabel.text = @"Failed to play ad.";
}

- (void)interstitialDidReadyToPlay
{
    NSLog(@"ready to play");
    self.showButton.enabled = YES;
    self.statusLabel.text = @"Ready to play ad.";
}

- (void)interstitialDidCompletion
{
    self.statusLabel.text = @"Complete ad.";
}

- (void)interstitialDidDismiss
{
    self.statusLabel.text = @"Dismiss interstitial ad. reloading...";
    self.showButton.enabled = NO;
    [self.interstitialAd load];
}

@end
