//
//  IHPUserLoginViewController.m
//  iHelp
//
//  Created by Wo Jun Feng on 10/29/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPUserLoginViewController.h"
#import "IHPRequestDataStore.h"
#import <Parse/Parse.h>

@interface IHPUserLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (nonatomic)BOOL isValidLogin;

@end

@implementation IHPUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.usernameField.text = @"";
    self.passwordField.text = @"";
}

- (IBAction)loginButtonTapped:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (user) {
            self.isValidLogin = YES;
            IHPRequestDataStore *dataStore = [IHPRequestDataStore sharedDataStore];
            [dataStore getUserFromLogin:^(BOOL success) {
                if (success) {
                    NSLog(@"Login successfully!");
                    [self login];
                }
            }];
        }
        else{
            self.isValidLogin = NO;
            [self createAlert];
            NSLog(@"Login failed!");
        }
    }];
}

-(void)login{
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}

- (void)createAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid login username or password"
                                                                   message:@"Please try again"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
