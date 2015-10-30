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

@interface IHPRequestDataStore : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *requests;
@property (nonatomic, strong) IHPUser *user;

+ (instancetype) sharedDataStore;
- (void) saveContext;
- (void) fetchDataWithUsername:(NSString *)username;
-(void)fetchDataWithUID:(NSString *)uid;
-(void)refreshAllRequests;

@end
