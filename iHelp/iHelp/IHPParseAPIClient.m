//
//  IHPParseAPIClient.m
//  iHelp
//
//  Created by Wo Jun Feng on 11/7/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPParseAPIClient.h"

@implementation IHPParseAPIClient

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

+(void)fetchUserProfilePictureWithUserObject:(PFObject *)userObject andCompletion:(void (^)(NSData *image))completionBlock{
    PFFile *profilePicture = [userObject objectForKey:@"profilePicture"];
    [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            completionBlock(data);
            
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"dataLoaded" object:nil];
        }else{
            NSLog(@"Unable to get profile image from parse");
        }
    }];
}
@end
