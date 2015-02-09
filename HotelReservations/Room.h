//
//  Room.h
//  HotelReservations
//
//  Created by Bradley Johnson on 12/20/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * floor;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) Hotel *hotel;
@property (nonatomic, retain) NSSet *reservations;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(NSManagedObject *)value;
- (void)removeReservationsObject:(NSManagedObject *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;

@end
