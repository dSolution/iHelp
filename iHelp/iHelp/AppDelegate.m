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
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"ohEzZGrjlaA45d65URVvZLIGfyExmSn1FaNOYRUK"
                  clientKey:@"u2A5wxHsYaZnYc97VoBcnZ4rPCHNhZJqjLbAF8hF"];
    
    return YES;
}


@end
