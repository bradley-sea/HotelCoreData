//
//  ReservationService.m
//  HotelReservations
//
//  Created by Bradley Johnson on 12/29/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import "ReservationService.h"
#import <CoreData/CoreData.h>
#import "Reservation.h"

@interface ReservationService ()

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation ReservationService


-(instancetype) initWithContext: (NSManagedObjectContext *)context {
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

-(Reservation *)bookReservationForHotel:(Hotel*)hotel inRoom:(Room*)room startDate:(NSDate*)startDate andEndDate:(NSDate *)endDate {
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.context];
    reservation.room = room;
    reservation.status = @"Booked";
    reservation.dateFrom = startDate;
    reservation.dateTo = endDate;
    NSError *error;
    [self.context save:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
        return reservation;
}

@end
