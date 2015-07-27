//
//  MainController.m
//
//
//  Created by Hirohide Sano on 2014/11/03.
//  Copyright (c) 2014年 AppVador Inc. All rights reserved.
//

#import "MainController.h"
#import "NormalStyleViewController.h"
#import "InFeedStyleViewController.h"
#import "InterstitialViewController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sample List";
}

# pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item) {
        case 0:
            [self.navigationController pushViewController:[[NormalStyleViewController alloc] init] animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:[[InFeedStyleViewController alloc] init] animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:[[InterstitialViewController alloc] init] animated:YES];
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"apv"];

    NSString *label;
    switch (indexPath.item) {
        case 0:
            label = @"Normal style";
            break;
            
        case 1:
            label = @"In-Feed style";
            break;
            
        case 2:
            label = @"Interstitial";
            
        default:
            break;
    }
    
    cell.textLabel.text = label;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
