//
//  IHPUser+CoreDataProperties.h
//  iHelp
//
//  Created by Kevin Lin on 10/23/15.
//  Copyright © 2015 IHP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "IHPUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface IHPUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *firstname;
@property (nullable, nonatomic, retain) NSString *lastname;
@property (nullable, nonatomic, retain) NSString *profilePicURL;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nullable, nonatomic, retain) NSString *areaOfInterest;
@property (nullable, nonatomic, retain) NSString *intro;
@property (nonatomic) int64_t rating;
@property (nonatomic) NSTimeInterval dateJoined;
@property (nullable, nonatomic, retain) NSSet<IHPRequest *> *requests;
@property (nullable, nonatomic, retain) NSSet<IHPRequest *> *requestsHelped;

@end

@interface IHPUser (CoreDataGeneratedAccessors)

- (void)addRequestsObject:(IHPRequest *)value;
- (void)removeRequestsObject:(IHPRequest *)value;
- (void)addRequests:(NSSet<IHPRequest *> *)values;
- (void)removeRequests:(NSSet<IHPRequest *> *)values;

- (void)addRequestsHelpedObject:(IHPRequest *)value;
- (void)removeRequestsHelpedObject:(IHPRequest *)value;
- (void)addRequestsHelped:(NSSet<IHPRequest *> *)values;
- (void)removeRequestsHelped:(NSSet<IHPRequest *> *)values;

@end

NS_ASSUME_NONNULL_END
