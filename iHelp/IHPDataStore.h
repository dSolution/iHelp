//
//  IHPDataStore.h
//  iHelp
//
//  Created by Kevin Lin on 11/9/15.
//  Copyright © 2015 dSolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>
#import "IHPParseAPIClient.h"

@interface IHPDataStore : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *requests;
@property (nonatomic, strong) PFObject *userData;
@property (nonatomic, strong) UIImage *profilePic;

+ (instancetype) sharedDataStore;
//- (void)saveContext;
- (void)getUserFromLogin:(void (^)(BOOL))completionBlock;

@end
