//
//  IHPRequestListTableViewController.m
//  iHelp
//
//  Created by Kevin Lin on 10/28/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPRequestListTableViewController.h"
#import "IHPRequestFeedDetailViewController.h"

@interface IHPRequestListTableViewController ()

@end

@implementation IHPRequestListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.requests.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestCell" forIndexPath:indexPath];
    
    IHPRequest *eachRequest = self.requests[indexPath.row];
    
    cell.textLabel.text = eachRequest.requestTitle;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    IHPRequestFeedDetailViewController *destinationVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    destinationVC.request = self.requests[indexPath.row];
}
@end
