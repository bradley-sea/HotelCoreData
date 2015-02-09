//
//  CoreDataStack.m
//  HotelReservations
//
//  Created by Bradley Johnson on 12/20/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import "CoreDataStack.h"
#import "Hotel.h"
#import "Room.h"


@implementation CoreDataStack

//-(instancetype)init {
//    self = [super init];
//    
//    if (self) {
//        
////        //get the context
////        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
////        _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
////        
////        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HotelReservations.sqlite"];
////        NSError *error = nil;
////        NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
////        if (!store) {
////            NSLog(@"failed to add the persistent store");
////            abort();
////        }
//        
//    }
//    return self;
//}

//-(NSManagedObjectContext *)managedObjectContext {
//    if (! _managedObjectContext) {
//                _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    }
//}

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
        NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        if (!store) {
            NSLog(@"failed to add the persistent store");
            abort();
        }
        
    }
    return _persistentStoreCoordinator;
}

-(void)seedDataBaseIfNeeded {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    NSError *fetchError;
    
    NSInteger results = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
    
    if (results == 0) {
        
        NSURL * seedURL = [[NSBundle mainBundle] URLForResource:@"seed" withExtension:@"json"];
        NSData *seedData = [[NSData alloc] initWithContentsOfURL:seedURL];
        
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:seedData options:0 error:&error];
        if (!error) {
        NSArray *hotelsArray = jsonDictionary[@"Hotels"];
        
        for (NSDictionary *hotelDictionary in hotelsArray) {
            Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:_managedObjectContext];
            hotel.name = hotelDictionary[@"name"];
            hotel.stars = hotelDictionary[@"stars"];
            hotel.location = hotelDictionary[@"location"];
            
            NSArray *roomsArray = hotelDictionary[@"rooms"];
            
            for (NSDictionary *roomDictionary in roomsArray) {
                Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:_managedObjectContext];
                room.number = roomDictionary[@"number"];
                room.beds = roomDictionary[@"beds"];
                room.floor = roomDictionary[@"floor"];
                room.rate = roomDictionary[@"rate"];
                room.hotel = hotel;
                    }
                }
        
            }
      
      
        NSError *saveError;
        [_managedObjectContext save:&saveError];
      
      
        if (saveError) {
            NSLog(@" %@",saveError.localizedDescription);
        }
    }
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "BPJ.HotelReservations" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
