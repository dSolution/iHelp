//
//  IHPParseAPIClient.h
//  iHelp
//
//  Created by Wo Jun Feng on 11/7/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface IHPParseAPIClient : NSObject

+(void)fetchUserProfileDataWithUserObject:(PFObject *)user andCompletion:(void (^)(PFObject *data))completionBlock;
+(void)fetchUserProfilePictureWithUserObject:(PFObject *)userObject andCompletion:(void (^)(NSData *image))completionBlock;

@end
