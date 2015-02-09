//
//  AvailabilityViewController.m
//  HotelReservations
//
//  Created by Bradley Johnson on 12/20/14.
//  Copyright (c) 2014 BPJ. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "Room.h"
#import "RoomViewController.h"

@interface AvailabilityViewController () <UITableViewDataSource>

@property (weak,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSArray *results;
@property (strong,nonatomic) NSMutableArray *rooms;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AvailabilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.context = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    self.results = [self.context executeFetchRequest:fetchRequest error:nil];
    
    self.rooms = [NSMutableArray new];
    for (Hotel *hotel in self.results) {
        NSArray *roomsArray = hotel.rooms.allObjects;
        [self.rooms addObject:roomsArray];
    }
    
    self.tableView.dataSource = self;
    
                                    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.results.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Hotel *hotel = self.results[section];
    return hotel.name;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Hotel *hotel = self.results[section];
    return hotel.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
    NSArray *roomsArray = self.rooms[indexPath.section];
    Room *room = roomsArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", room.number, room.rate];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SHOW_ROOM"]) {
        RoomViewController *destinationVC = segue.destinationViewController;
        NSArray *roomArray = self.rooms[self.tableView.indexPathForSelectedRow.section];
        destinationVC.selectedRoom = roomArray[self.tableView.indexPathForSelectedRow.row];
    }
}



@end
