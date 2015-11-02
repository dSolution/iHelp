//
//  IHPFeedTableViewController.m
//  iHelp
//
//  Created by Kevin Lin on 10/27/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPFeedTableViewController.h"
#import <Parse/Parse.h>

@interface IHPFeedTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameTextLabel;
//@property (weak, nonatomic) IBOutlet UILabel *requestTitleLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *requestImageView;
//@property (weak, nonatomic) IBOutlet UILabel *requestViewCountLabel;

@end

@implementation IHPFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //UIImage *userProfileImage = [UIImage imageNamed:self.dataStore.user.profilePicURL];
    //self.userProfileImageView.image = userProfileImage;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataStore = [IHPRequestDataStore sharedDataStore];
    [self.dataStore fetchUserData];
    PFObject *user = self.dataStore.userData;
    
    self.usernameTextLabel.text = user[@"username"];
    
    [self.tableView reloadData];
    self.tabBarController.tabBar.hidden = NO;
}

- (IBAction)userLogout:(id)sender {
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataStore.requests.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IHPRequestFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestFeedCell" forIndexPath:indexPath];
    
    
    IHPRequest *eachRequest = self.dataStore.requests[indexPath.row];
    
    cell.requestTitleLabel.text = eachRequest.requestTitle;
    cell.requestImageView.image = [UIImage imageNamed:eachRequest.requestImageURL];
    cell.requestViewCountLabel.text = [NSString stringWithFormat:@"%lu", (NSUInteger)eachRequest.requestViewCount];
    cell.requestStatusLabel.text = eachRequest.requestStatus;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    IHPRequestFeedDetailViewController *destinationVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    destinationVC.request = self.dataStore.requests[indexPath.row];
}


@end
