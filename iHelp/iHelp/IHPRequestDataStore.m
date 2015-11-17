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

-(void)getUserFromLogin:(void (^)(BOOL))completionBlock{
 
    PFObject *user= [PFUser currentUser];
    
    // Using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parent = %@", user];
    PFQuery *query = [PFQuery queryWithClassName:@"IHPUser" predicate:predicate];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        
        if (!error) {
            self.userData = object;
            
            PFFile *profilePicture = [object objectForKey:@"profilePicture"];
            [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    self.profilePic = image;
                    NSLog(@"User data: %@", image);
                    completionBlock(YES);

                }else{
                    NSLog(@"Unable to get profile image from parse");
                }
            }];
            NSLog(@"User data: %@", self.userData);
        }else{
            NSLog(@"User data error: %@", error.description);
        }
        
    }];

}

-(void)refreshAllRequests{
    NSFetchRequest *retrieveAllRequests = [NSFetchRequest fetchRequestWithEntityName:@"IHPRequest"];
    self.requests = [self.managedObjectContext executeFetchRequest:retrieveAllRequests error:nil];
}

@end
