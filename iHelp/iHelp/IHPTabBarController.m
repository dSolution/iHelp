//
//  IHPTabBarController.m
//  iHelp
//
//  Created by Kevin Lin on 10/27/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPTabBarController.h"
#import "IHPFeedTableViewController.h"

@interface IHPTabBarController ()

@end

@implementation IHPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad in tabBarController.");
    self.selectedIndex = 0;

    NSArray *icons = @[@"feed", @"profile",@"request"];
    for (NSUInteger i=0; i<self.tabBar.items.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        UIImage *icon = [UIImage imageNamed:icons[i]];
        item.image = icon;
        item.tag = 3;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    NSLog(@"Current selected tab before: %lu", self.tabBarController.selectedIndex);
//    self.tabBarController.selectedIndex = 1;
//    self.tabBar setSelectedItem:
//     NSLog(@"Current selected tab after: %lu", self.tabBarController.selectedIndex);
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
