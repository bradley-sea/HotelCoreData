//
//  Reservation.h
//  HotelReservations
//
//  Created by Bradley Johnson on 12/20/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * dateFrom;
@property (nonatomic, retain) NSDate * dateTo;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) Room *room;
@property (nonatomic, retain) NSManagedObject *guest;

@end
