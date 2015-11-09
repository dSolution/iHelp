//
//  IHPDataStore.m
//  iHelp
//
//  Created by Kevin Lin on 11/9/15.
//  Copyright © 2015 dSolution. All rights reserved.
//
#import "IHPDataStore.h"

@implementation IHPDataStore
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Singleton

+ (instancetype)sharedDataStore {
    static IHPDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[IHPDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

-(void)getUserFromLogin:(void (^)(BOOL))completionBlock{
    
    //Returns the current PFUser object.
    PFObject *currentUser= [PFUser currentUser];
    
    //Calling the ParseAPIClient to retrive the user profile ojbect.
    [IHPParseAPIClient fetchUserProfileDataWithUserObject:currentUser andCompletion:^(PFObject *data){
        
        //Storing the returned user object from Parse.
        self.userData = data;
        [IHPParseAPIClient fetchUserProfilePictureWithUserObject:data andCompletion:^(NSData *image) {
            UIImage *profileImage = [UIImage imageWithData:image];
            self.profilePic = profileImage;
        }];
        //Callback to the Login controller with confirmation of success.
        completionBlock(YES);
    }];
}



//- (void)saveContext
//{
//    NSError *error = nil;
//    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
//    if (managedObjectContext != nil) {
//        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
//}
//
////- (void)fetchData
////{
//// perform a fetch request to fill an array property on your datastore
////}
//
//#pragma mark - Core Data Stack
//
//// Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
//// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
//- (NSManagedObjectContext *)managedObjectContext
//{
//    if (_managedObjectContext != nil) {
//        return _managedObjectContext;
//    }
//
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iHelp.sqlite"];
//
//    NSError *error = nil;
//
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iHelp" withExtension:@"momd"];
//    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
//
//    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
//    if (coordinator != nil) {
//        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
//    }
//    return _managedObjectContext;
//}
//
//#pragma mark - Application's Documents directory
//
//// Returns the URL to the application's Documents directory.
//- (NSURL *)applicationDocumentsDirectory
//{
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//}

//-(void)fetchUserData{
//    PFObject *user= [PFUser currentUser];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parent = %@", user];
//
//    PFQuery *query = [PFQuery queryWithClassName:@"IHPUser" predicate:predicate];
//    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
//        if (!error) {
//            self.userData = object;
//
//            PFFile *profilePicture = [object objectForKey:@"profilePicture"];
//            [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
//                if (!error) {
//                    UIImage *profileImage = [UIImage imageWithData:data];
//                    self.profilePic = profileImage;
//
//                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//                    [center postNotificationName:@"dataLoaded" object:nil];
//                }else{
//                    NSLog(@"Unable to get profile image from parse");
//                }
//            }];
//        }else{
//            NSLog(@"Unable to get userData from parse");
//        }
//
//    }];
//
//    //pin user object to local store
//    [user pinInBackground];
//    [self.userData pinInBackground];
//}

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

//-(void)refreshAllRequests{
//    NSFetchRequest *retrieveAllRequests = [NSFetchRequest fetchRequestWithEntityName:@"IHPRequest"];
//    self.requests = [self.managedObjectContext executeFetchRequest:retrieveAllRequests error:nil];
//}

@end
