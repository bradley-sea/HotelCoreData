//
//  ReservationFilterViewController.m
//  HotelReservations
//
//  Created by Bradley Johnson on 12/20/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import "ReservationFilterViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"

@interface ReservationFilterViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endPicker;
@property (strong,nonatomic) NSManagedObjectContext *context;

@end

@implementation ReservationFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.context = appDelegate.managedObjectContext;

    // Do any additional setup after loading the view.
}
- (IBAction)searchPressed:(id)sender {
//    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
    // NSDate *startDate =
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room.hotel.name == %@ AND dateFrom <= %@ AND dateTo >= %@", @"Solid Stay", self.startPicker.date, self.endPicker.date];
    fetchRequest.predicate = predicate;
    NSArray *results = [self.context executeFetchRequest:fetchRequest error:nil];
    NSMutableArray *roomsInFirstFetch = [NSMutableArray new];
    for (Reservation *reservation in results) {
        [roomsInFirstFetch addObject:reservation.room];
    }
    
    NSLog(@"%lu",(unsigned long)results.count);
    
    NSFetchRequest *anotherFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY reservations.status != %@", @"Booked"];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY reservations == nil"];
    NSPredicate *anotherPredicate = [NSPredicate predicateWithFormat:@"NOT (self IN %@)", roomsInFirstFetch];

    anotherFetchRequest.predicate = anotherPredicate    ;
    NSArray *finalResults = [self.context executeFetchRequest:anotherFetchRequest error:nil];
//    
  NSLog(@" %lu",(unsigned long)finalResults.count);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
