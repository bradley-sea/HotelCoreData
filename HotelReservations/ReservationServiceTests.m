//
//  ReservationServiceTests.m
//  HotelReservations
//
//  Created by Bradley Johnson on 12/29/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ReservationService.h"
#import "TestCoreDataStack.h"

@interface ReservationServiceTests : XCTestCase
@property (strong,nonatomic) TestCoreDataStack *coreDataStack;
@property (strong,nonatomic) ReservationService *reservationService;
@end

@implementation ReservationServiceTests

- (void)setUp {
    [super setUp];
    self.coreDataStack = [[TestCoreDataStack alloc] init];
    self.reservationService = [[ReservationService alloc] initWithContext:self.coreDataStack.managedObjectContext];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.coreDataStack = nil;
    self.reservationService = nil;
}

-(void)testBookReservation {
    
    Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.coreDataStack.managedObjectContext];
    hotel.name = @"Fake Hotel";
    Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.coreDataStack.managedObjectContext];
    room.number = @101;
    room.hotel = hotel;
    room.beds = @1;
    room.rate = @1;
    room.floor = @1;
    NSDate *now = [NSDate date];
    Reservation *reservation = [self.reservationService bookReservationForHotel:hotel inRoom:room startDate:now andEndDate:now];
    
    XCTAssertNotNil(reservation, @"reservation should not be nil");
    XCTAssertTrue([reservation.room.number isEqualToNumber: @101], @"reservation should have correct room number");
}

@end
