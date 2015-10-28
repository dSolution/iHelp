//
//  AppDelegate.m
//  iHelp
//
//  Created by Kevin Lin on 10/23/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "AppDelegate.h"
#import "IHPRequestDataStore.h"
#import "IHPRequest.h"
#import "IHPUser.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //IHPRequestDataStore *dataStore = [IHPRequestDataStore sharedDataStore];
//    NSManagedObjectContext *manageContext = dataStore.managedObjectContext;
    
//    IHPUser *ben = [NSEntityDescription insertNewObjectForEntityForName:@"IHPUser" inManagedObjectContext:manageContext];
//    
//    ben.username = @"leof99";
//    ben.location = @"New York";
//    ben.email = @"leofff123@gmail.com";
//    ben.firstname = @"Leo";
//    ben.lastname = @"Feng";
//    ben.profilePicURL = @"leo";
//    ben.gender = @"Male";
//    ben.areaOfInterest = @"game";
//    ben.intro = @"My name is Leo and I like to play games.";
//    NSDate *today = [NSDate date];
//    ben.dateJoined = [today timeIntervalSinceReferenceDate];
//    
//    IHPRequest *request = [NSEntityDescription insertNewObjectForEntityForName:@"IHPRequest" inManagedObjectContext:manageContext];
//    request.requestUser = ben;
//    request.requestTitle = @"Looking for the first edition Mario Cart game";
//    request.requestDescription = @"Looking for the first edition Mario Cart game. Note: Need to be playable";
//    request.requestImageURL = @"mariocart";
//    request.requestCategory = @"game";
//    request.requestViewCount = 100;
//    request.requestReward = YES;
//    request.requestRewardDescription = @"$100";
//    request.requestDate = [today timeIntervalSinceReferenceDate];
//    request.requestDuration = 15;
//    request.requestStatus = @"Open";
//    
//    [dataStore saveContext];
    
//    [dataStore fetchDataWithUsername:@"leof99"];
//    
//    IHPUser *ben = dataStore.user;
//    NSArray *allRequest = dataStore.requests;
//    
//    NSLog(@"The User is: %@", ben.firstname);
//    NSLog(@"Below is all %@'s requests: \n", ben.firstname);
//    for (IHPRequest *request in allRequest) {
//        NSLog(@"Request title: %@", request.requestTitle);
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        dateFormat.timeStyle = NSDateFormatterNoStyle;
//        dateFormat.dateStyle = NSDateFormatterMediumStyle;
//        
//        NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:request.requestDate];
//        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//        [dateFormat setLocale:usLocale];
//        NSLog(@"Request Date: %@",[dateFormat stringFromDate:date]);
//        
//        NSLog(@"Image Url: %@", ben.profilePicURL);
//        
//    }
    
    IHPRequestDataStore *data = [IHPRequestDataStore sharedDataStore];
    [data fetchDataWithUsername:@"bennyBoy123"];
    return YES;
}


@end
