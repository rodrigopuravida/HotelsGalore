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

@interface HotelListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *hotels;

@end

@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    //you could create a predicate here
    NSError *fetchError;
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
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
    Hotel *hotel = self.hotels[indexPath.row];
    cell.textLabel.text = hotel.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected a cell");
}




@end
