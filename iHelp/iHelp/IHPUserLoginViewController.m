//
//  IHPUserLoginViewController.m
//  iHelp
//
//  Created by Wo Jun Feng on 10/29/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPUserLoginViewController.h"
#import "IHPRequestDataStore.h"

@interface IHPUserLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation IHPUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginButtonTapped:(id)sender {
    if ([self isValidUsernamePassword]) {
        [self fetchLoggedinUserData];
    } else {
        [self createAlert];
    }
    
}

-(BOOL)isValidUsernamePassword{
//    IHPRequestDataStore *data = [IHPRequestDataStore sharedDataStore];
//    if (data.user) {
//        return YES;
//    }
    return YES;
}

- (void)createAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid login username or password"
                                                                   message:@"Please re-enter"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)fetchLoggedinUserData{
    IHPRequestDataStore *data = [IHPRequestDataStore sharedDataStore];
    [data fetchDataWithUsername:@"leof99"];

}

@end
