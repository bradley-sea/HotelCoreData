//
//  TestCoreDataStack.h
//  HotelReservations
//
//  Created by Bradley Johnson on 12/29/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import "CoreDataStack.h"
#import <CoreData/CoreData.h>

@interface TestCoreDataStack : NSObject


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end
