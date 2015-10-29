//
//  IHPUserLoginViewController.m
//  iHelp
//
//  Created by Wo Jun Feng on 10/29/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPUserLoginViewController.h"
#import "IHPRequestDataStore.h"
#import <Firebase/Firebase.h>

@interface IHPUserLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic)Firebase *rootRef;
@property (nonatomic)BOOL isValidLogin;

@end

@implementation IHPUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a reference to a Firebase database URL
    self.rootRef = [[Firebase alloc] initWithUrl:@"https://luminous-torch-5235.firebaseIO.com"];
    
    // Write data to Firebase
    //    [myRootRef setValue:@"Leo test."];
    
    // Read data and react to changes
//    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
//    }];
    
    
//    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://luminous-torch-5235.firebaseIO.com"];
//    [ref authAnonymouslyWithCompletionBlock:^(NSError *error, FAuthData *authData) {
//        if (error) {
//            // There was an error logging in anonymously
//        } else {
//            // We are now logged in
//            NSLog(@"logged in anonymously");
//        }
//    }];
    
    
    //create firebase new user
//    [myRootRef createUser:@"leof999@test.com" password:@"123456" withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
//        if (error) {
//            // There was an error creating the account
//        } else {
//            NSString *uid = [result objectForKey:@"uid"];
//            NSLog(@"Successfully created user account with uid: %@", uid);
//        }
//    }];
//    
    
}

- (IBAction)loginButtonTapped:(id)sender {
    //log in with User credential
    [self.rootRef authUser:self.usernameField.text password:self.passwordField.text withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            // There was an error logging in to this account
            self.isValidLogin = NO;
            [self createAlert];

            
        } else {
            self.isValidLogin = YES;
            [self fetchLoggedinUserData];
            NSLog(@"logged in successfully");
        }
    }];
}

-(BOOL)isValidUsernamePassword{
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return self.isValidLogin;
}


@end
