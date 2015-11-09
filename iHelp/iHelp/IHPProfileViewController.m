//
//  IHPProfileViewController.m
//  iHelp
//
//  Created by Kevin Lin on 10/28/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPProfileViewController.h"
#import "IHPRequestDataStore.h"
#import "IHPUser.h"

@interface IHPProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *profileUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileLastNameLabel;

@property (nonatomic, strong) IHPRequestDataStore *dataStore;

@end

@implementation IHPProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataStore = [IHPRequestDataStore sharedDataStore];
    
    IHPUser *user = self.dataStore.user;
    
    self.profilePictureView.image = [UIImage imageNamed:user.profilePicURL];
    self.profileUsernameLabel.text = user.username;
    self.profileEmailLabel.text = user.email;
    self.profileFirstNameLabel.text = user.firstname;
    self.profileLastNameLabel.text = user.lastname;
}


- (IBAction)displayProfileSetting:(UIButton *)sender {
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
