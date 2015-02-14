//
//  HotelListViewController.m
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/9/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import "HotelListViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomsViewController.h"
#import "HotelService.h"

@interface HotelListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *hotels;
@property (strong,nonatomic) Hotel *hotel;

@end

@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
    //code showing how to use fetch via MOM
    //  NSManagedObjectModel *MOM = context.persistentStoreCoordinator.managedObjectModel;
    //  NSFetchRequest *fetchRequest = [MOM fetchRequestTemplateForName:@"HotelFetch"];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    //you could create a predicate here
    NSError *fetchError;
    
    //NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
    
    NSArray *results = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];

    if (!fetchError) {
        self.hotels = results;
        //NSLog(@"%@", self.hotels);
        [self.tableView reloadData];
    }

    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.hotels) {
        return self.hotels.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOTEL_CELL" forIndexPath:indexPath];
    self.hotel = self.hotels[indexPath.row];
    cell.textLabel.text = self.hotel.name;
    //NSLog(@"I'm going to search a room for Hotel: %@", self.hotel.name);
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SHOW_ROOMS"]) {
        RoomsViewController *showRoomsVC = (RoomsViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathsForSelectedRows.firstObject;
        showRoomsVC.hotel = self.hotels[indexPath.row];
        
    }
}




@end
