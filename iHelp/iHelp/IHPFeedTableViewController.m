//
//  IHPFeedTableViewController.m
//  iHelp
//
//  Created by Kevin Lin on 10/27/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPFeedTableViewController.h"

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
    
//    IHPRequestDataStore *dataStore = [IHPRequestDataStore sharedDataStore];
//        NSManagedObjectContext *manageContext = dataStore.managedObjectContext;
//    
//        IHPUser *ben = [NSEntityDescription insertNewObjectForEntityForName:@"IHPUser" inManagedObjectContext:manageContext];
//    
//        ben.username = @"bennyBoy123";
//        ben.location = @"New York";
//        ben.email = @"bennyboyWithGirl@gmail.com";
//        ben.firstname = @"Ben";
//        ben.lastname = @"Gao";
//        ben.profilePicURL = @"ben";
//        ben.gender = @"Male";
//        ben.areaOfInterest = @"car";
//        ben.intro = @"My name is Benny and i am a car collector.";
//        NSDate *today = [NSDate date];
//        ben.dateJoined = [today timeIntervalSinceReferenceDate];
//    
//        IHPRequest *request = [NSEntityDescription insertNewObjectForEntityForName:@"IHPRequest" inManagedObjectContext:manageContext];
//        request.requestUser = ben;
//        request.requestTitle = @"Looking for the super hot Pagani car";
//        request.requestDescription = @"Contact me if you have one, I have a lot of money";
//        request.requestImageURL = @"zondaF";
//        request.requestCategory = @"car";
//        request.requestViewCount = 10000;
//        request.requestReward = YES;
//        request.requestRewardDescription = @"Negotiable";
//        request.requestDate = [today timeIntervalSinceReferenceDate];
//        request.requestDuration = 365;
//        request.requestStatus = @"Open";
//        
//        [dataStore saveContext];

    self.dataStore = [IHPRequestDataStore sharedDataStore];
    
    self.usernameTextLabel.text = self.dataStore.user.username;
    UIImage *userProfileImage = [UIImage imageNamed:self.dataStore.user.profilePicURL];
    self.userProfileImageView.image = userProfileImage;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
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
