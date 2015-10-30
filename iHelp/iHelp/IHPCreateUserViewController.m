//
//  IHPCreateUserViewController.m
//  iHelp
//
//  Created by Wo Jun Feng on 10/30/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPCreateUserViewController.h"
#import <Firebase/Firebase.h>


@interface IHPCreateUserViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation IHPCreateUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerTapped:(id)sender {
    
    Firebase *rootRef = [[Firebase alloc] initWithUrl:@"https://luminous-torch-5235.firebaseIO.com"];
    
    //create firebase new user
    [rootRef createUser:self.usernameField.text password:self.passwordField.text withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            // There was an error creating the account
            [self createAlert];
        } else {
            NSString *uid = [result objectForKey:@"uid"];
            NSLog(@"Successfully created user account with uid: %@", uid);
        }
    }];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Please try again"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
