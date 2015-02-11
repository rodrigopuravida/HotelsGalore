//
//  RoomsViewController.m
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/9/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import "RoomsViewController.h"
#import "Hotel.h"
#import "Room.h"
#import "ReservationsViewController.h"

@interface RoomsViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *rooms;

@end

@implementation RoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.rooms =(NSArray *) self.hotel.rooms.allObjects;
    //NSSet *roomsArray =  self.hotel.rooms;
    NSLog(@"%lu", (unsigned long)self.hotel.rooms.count);

    
    
    // Do any additional setup after loading the view.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.rooms){
        return self.rooms.count;
    } else {
        return 0;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
    Room *currentRoom = self.rooms[indexPath.row];
    NSString *roomNumber = [NSString stringWithFormat:@"%@", currentRoom.number];
    cell.textLabel.text = roomNumber;
    //NSLog(@"I'm going to book for this room : %@", roomNumber);

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SHOW_RESERVATION"]) {
        ReservationsViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        Room *room = self.rooms[indexPath.row];
        destinationVC.selectedRoom = room;
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
