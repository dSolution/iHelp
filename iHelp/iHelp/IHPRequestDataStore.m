//
//  IHPRequestDataStore.m
//  iHelp
//
//  Created by Kevin Lin on 10/23/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPRequestDataStore.h"

@implementation IHPRequestDataStore
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Singleton

+ (instancetype)sharedDataStore {
    static IHPRequestDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[IHPRequestDataStore alloc] init];
    });
    
    return _sharedDataStore;
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//- (void)fetchData
//{
// perform a fetch request to fill an array property on your datastore
//}

#pragma mark - Core Data Stack

// Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iHelp.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iHelp" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)fetchUserData{
    PFObject *user= [PFUser currentUser];
    
    // Using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parent = %@", user];
    PFQuery *query = [PFQuery queryWithClassName:@"IHPUser" predicate:predicate];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        
        if (!error) {
            self.userData = object;
        }else{
            NSLog(@"Issue!!!!!!!!!!!!!!!!!!!!!");
        }
        
    }];
    
    PFQuery *photeQuery = [PFQuery queryWithClassName:@"Photos"];
    
    [photeQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        NSLog(@"Retrieved data");
        
        if (!error) {
            NSLog(@"Image name: %@", user[@"profilePic"]);
            
            PFFile *file = [object objectForKey:user[@"profilePic"]];
            NSLog(@"Retieving Image!!!!!!!!!!");
            [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    self.profilePic = image;
                    
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:@"dataLoaded" object:nil];
                    
                }else{
                    NSLog(@"Unable to retrieve profile image!");
                }
            }];
        }else{
            NSLog(@"Error: %@", error.description);
        }
    }];
    
    //pin user object to local store - making log in blazing fast !
    [user pinInBackground];
    [self.userData pinInBackground];
}

//-(void)fetchDataWithUsername:(NSString *)username{
//    //Retrieving data from storage
//    NSFetchRequest *retrieveAllRequests = [NSFetchRequest fetchRequestWithEntityName:@"IHPRequest"];
//    NSFetchRequest *retrieveAllUsers = [NSFetchRequest fetchRequestWithEntityName:@"IHPUser"];
//    
//    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"username MATCHES %@", username];
//    retrieveAllUsers.predicate = userPredicate;
//    NSArray *users = [self.managedObjectContext executeFetchRequest:retrieveAllUsers error:nil];
//    self.user = users[0];
//    
//    //NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"requestCategory MATCHES[c] %@", self.user.areaOfInterest];
//    //retrieveAllRequests.predicate = categoryPredicate;
//    self.requests = [self.managedObjectContext executeFetchRequest:retrieveAllRequests error:nil];
//}
//
//-(void)fetchDataWithUID:(NSString *)uid{
//    //Retrieving data from storage
//    NSFetchRequest *retrieveAllRequests = [NSFetchRequest fetchRequestWithEntityName:@"IHPRequest"];
//    NSFetchRequest *retrieveAllUsers = [NSFetchRequest fetchRequestWithEntityName:@"IHPUser"];
//    
//    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"uid MATCHES %@", uid];
//    retrieveAllUsers.predicate = userPredicate;
//    NSArray *users = [self.managedObjectContext executeFetchRequest:retrieveAllUsers error:nil];
//    self.user = users[0];
//    
//    //NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"requestCategory MATCHES[c] %@", self.user.areaOfInterest];
//    //retrieveAllRequests.predicate = categoryPredicate;
//    self.requests = [self.managedObjectContext executeFetchRequest:retrieveAllRequests error:nil];
//}

-(void)refreshAllRequests{
    NSFetchRequest *retrieveAllRequests = [NSFetchRequest fetchRequestWithEntityName:@"IHPRequest"];
    self.requests = [self.managedObjectContext executeFetchRequest:retrieveAllRequests error:nil];
}

@end
