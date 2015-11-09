//
//  IHPCreateUserViewController.m
//  iHelp
//
//  Created by Wo Jun Feng on 10/30/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPCreateUserViewController.h"
#import "IHPRequestDataStore.h"
#import <Parse/Parse.h>

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
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    user.email = self.usernameField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            PFObject *iUser = [PFObject objectWithClassName:@"IHPUser"];
            iUser[@"username"] = self.usernameField.text;
            iUser[@"email"] = self.usernameField.text;
            iUser[@"uid"] = user.objectId;
            iUser[@"parent"] = user;
//            UIImage *image = [UIImage imageNamed:@"ben"];
//            NSData *data = UIImageJPEGRepresentation(image, 0.5f);
//            PFFile *imageFile = [PFFile fileWithName:@"ben" data:data];
            
            [iUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
//                    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//                        if (!error) {
//                            PFObject *profilePic = [PFObject objectWithClassName:@"Photos"];
//                            [profilePic setObject:imageFile forKey:@"ben"];
//                            
//                            [profilePic saveInBackground];
//                        }
//                    }];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [self createAlert];
                }
            }];
        }else{
            [self createAlert];
        }
    }];
    
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
