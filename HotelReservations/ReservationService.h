//
//  ReservationService.h
//  HotelReservations
//
//  Created by Bradley Johnson on 12/29/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reservation.h"
#import "Room.h"
#import "Hotel.h"

@interface ReservationService : NSObject


-(instancetype) initWithContext: (NSManagedObjectContext *)context;

-(Reservation *)bookReservationForHotel:(Hotel*)hotel inRoom:(Room*)room startDate:(NSDate*)startDate andEndDate:(NSDate *)endDate;

//-(NSArray *)fetchAvailabileRoomsForHotel:(Hotel *)hotel startDate:(NSDate*)startDate andEndDate:(NSDate *)endDate;

@end
