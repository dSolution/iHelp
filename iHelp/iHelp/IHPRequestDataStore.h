//
//  IHPRequestDataStore.h
//  iHelp
//
//  Created by Kevin Lin on 10/23/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "IHPUser.h"
#import "IHPRequest.h"
#import <Parse/Parse.h>

@interface IHPRequestDataStore : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *requests;
@property (nonatomic, strong) IHPUser *user;
@property (nonatomic, strong) PFObject *userData;
@property (nonatomic, strong) UIImage *profilePic;

+ (instancetype) sharedDataStore;

- (void) saveContext;
-(void)getUserFromLogin:(void (^)(BOOL))completionBlock;
-(void)refreshAllRequests;

@end
