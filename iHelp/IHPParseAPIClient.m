//
//  IHPParseAPIClient.m
//  iHelp
//
//  Created by Kevin Lin on 11/9/15.
//  Copyright © 2015 dSolution. All rights reserved.
//

#import "IHPParseAPIClient.h"

@implementation IHPParseAPIClient

/**
 *  Fetch user profile data from Parse
 *
 *  @param user            PFObject form current user
 *  @param completionBlock Callback to pass returned user profile data from Parse
 */
+(void)fetchUserProfileDataWithUserObject:(PFObject *)user andCompletion:(void (^)(PFObject *data))completionBlock{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parent = %@", user];
    PFQuery *query = [PFQuery queryWithClassName:@"IHPUser" predicate:predicate];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error) {
            completionBlock(object);
        }else{
            NSLog(@"Unable to get userData from parse");
        }
    }];
}
/**
 *  Fetch user profile image - temporarily images handling
 *
 *  @param userObject      PFObject from current user
 *  @param completionBlock Callback to pass returned image data from Parse
 */
+(void)fetchUserProfilePictureWithUserObject:(PFObject *)userObject andCompletion:(void (^)(NSData *image))completionBlock{
    PFFile *profilePicture = [userObject objectForKey:@"profilePicture"];
    [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            completionBlock(data);
        }else{
            NSLog(@"Unable to get profile image from parse");
        }
    }];
}

@end
