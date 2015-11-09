//
//  IHPRequest+CoreDataProperties.h
//  iHelp
//
//  Created by Kevin Lin on 10/23/15.
//  Copyright © 2015 IHP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "IHPRequest.h"
#import "IHPUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface IHPRequest (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *requestTitle;
@property (nullable, nonatomic, retain) NSString *requestDescription;
@property (nullable, nonatomic, retain) NSString *requestImageURL;
@property (nullable, nonatomic, retain) NSString *requestCategory;
@property (nonatomic) int64_t requestViewCount;
@property (nonatomic) BOOL requestReward;
@property (nullable, nonatomic, retain) NSString *requestRewardDescription;
@property (nullable, nonatomic, retain) NSString *requestLocation;
@property (nonatomic) NSTimeInterval requestDate;
@property (nonatomic) int64_t requestDuration;
@property (nullable, nonatomic, retain) NSString *requestStatus;
@property (nullable, nonatomic, retain) IHPUser *requestUser;
@property (nullable, nonatomic, retain) IHPUser *requestHelper;

@end

NS_ASSUME_NONNULL_END
