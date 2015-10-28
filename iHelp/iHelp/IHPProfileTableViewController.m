//
//  IHPProfileTableViewController.m
//  iHelp
//
//  Created by Kevin Lin on 10/28/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPProfileTableViewController.h"
#import "IHPRequestDataStore.h"
#import "IHPUser.h"
#import "IHPRequestListTableViewController.h"

@interface IHPProfileTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *profileUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileLastNameLabel;

@property (nonatomic, strong) IHPRequestDataStore *dataStore;
@property (weak, nonatomic) IBOutlet UITableViewCell *completedRequestCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *openRequestCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *respondedRequestCell;
@property (nonatomic, strong)NSSet *completedRequestList;
@property (nonatomic, strong)NSSet *openRequestList;
@end

@implementation IHPProfileTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataStore = [IHPRequestDataStore sharedDataStore];
    
    IHPUser *user = self.dataStore.user;
    
    self.profilePictureView.image = [UIImage imageNamed:user.profilePicURL];
    self.profileUsernameLabel.text = user.username;
    self.profileEmailLabel.text = user.email;
    self.profileFirstNameLabel.text = user.firstname;
    self.profileLastNameLabel.text = user.lastname;
    
    NSPredicate *completedRequestPredicate = [NSPredicate predicateWithFormat:@"requestStatus MATCHES 'closed'"];
    self.completedRequestList = [user.requests filteredSetUsingPredicate:completedRequestPredicate];
    self.completedRequestCell.textLabel.text = @"Closed Requests";
    self.completedRequestCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", self.completedRequestList.count];
    
    
    NSPredicate *openRequestPredicate = [NSPredicate predicateWithFormat:@"NOT (requestStatus MATCHES 'closed')"];
    self.openRequestList = [user.requests filteredSetUsingPredicate:openRequestPredicate];
    self.openRequestCell.textLabel.text = @"Open Requests";
    self.openRequestCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", self.openRequestList.count];
    
    self.respondedRequestCell.textLabel.text = @"Responded Requests";
    self.respondedRequestCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", user.requestsHelped.count];
}

- (IBAction)displayProfileSetting:(UIButton *)sender {
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    IHPRequestListTableViewController *destinationVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"completedRequest"]) {
        destinationVC.requests = [self.completedRequestList allObjects];
        
    } else if ([segue.identifier isEqualToString:@"openRequests"]) {
        destinationVC.requests = [self.openRequestList allObjects];
        
    } else if ([segue.identifier isEqualToString:@"respondedRequests"]){
        destinationVC.requests = [self.dataStore.user.requestsHelped allObjects];
    }
    
}


@end
