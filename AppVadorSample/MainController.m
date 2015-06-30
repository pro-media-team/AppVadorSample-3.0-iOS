//
//  ViewController.m
//
//
//  Created by Hirohide Sano on 2014/11/03.
//  Copyright (c) 2014年 AppVador Inc. All rights reserved.
//

#import "MainController.h"
#import "MainViewController.h"
#import "SecondViewController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
