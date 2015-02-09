//
//  RoomViewController.m
//  HotelReservations
//
//  Created by Bradley Johnson on 12/20/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import "RoomViewController.h"
#import "Reservation.h"

@interface RoomViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bedsLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *startPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endPicker;

@end

@implementation RoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberLabel.text = [NSString stringWithFormat:@"%@", self.selectedRoom.number];
    self.bedsLabel.text = [NSString stringWithFormat:@"%@", self.selectedRoom.beds];
    self.floorLabel.text = [NSString stringWithFormat:@"%@", self.selectedRoom.floor];
    self.rateLabel.text = [NSString stringWithFormat:@"%@", self.selectedRoom.rate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bookPressed:(id)sender {
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.selectedRoom.managedObjectContext];
    reservation.room = self.selectedRoom;
    reservation.status = @"Booked";
    reservation.dateFrom = self.startPicker.date;
    reservation.dateTo = self.endPicker.date;
    NSError *error;
    [self.selectedRoom.managedObjectContext save:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    } else {
        [self.navigationController popViewControllerAnimated:true];
    }
    
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
