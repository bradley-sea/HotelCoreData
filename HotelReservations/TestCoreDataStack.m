//
//  TestCoreDataStack.m
//  HotelReservations
//
//  Created by Bradley Johnson on 12/29/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import "TestCoreDataStack.h"

@implementation TestCoreDataStack
-(NSManagedObjectContext *)managedObjectContext {
    
    if (! _managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (! _persistentStoreCoordinator) {
        
        //load the MOM file
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HotelReservations" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        //setup the PSC
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HotelReservations.sqlite"];
        NSError *error = nil;
        NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error];
        if (!store) {
            NSLog(@"failed to add the persistent store");
            abort();
        }
        
    }
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "BPJ.HotelReservations" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
