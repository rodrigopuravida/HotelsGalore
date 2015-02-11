//
//  AvailabilityViewController.m
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/10/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "HotelService.h"

@interface AvailabilityViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSegmentControl;
//TODO: Need to investigate as why this is still referring to old context
//@property (strong,nonatomic) NSManagedObjectContext *context;

@end

@implementation AvailabilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //self.context = appDelegate.managedObjectContext;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkAvailabilityPressed:(id)sender {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
    
    NSString *selectedHotel = [self.hotelSegmentControl titleForSegmentAtIndex:self.hotelSegmentControl.selectedSegmentIndex];
    NSLog(@"Hotel selected for availability is %@", selectedHotel.description);
    
    //fetch all rooms with hotel name that matches the selected hotel
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.hotel.name MATCHES %@",selectedHotel];
    
    fetchRequest.predicate = predicate;
    
    
    NSFetchRequest *reservationFetch = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  //This is my predicate but using John's for efficiency purpoees
    
//    NSPredicate *reservationPredicate = [NSPredicate predicateWithFormat:@"(room.hotel.name MATCHES %@ AND startDate >= %@ AND startDate <= %@)OR (room.hotel.name MATCHES %@ AND startDate <= %@ AND endDate >= %@) OR (room.hotel.name MATCHES %@ AND startDate >= %@ AND endDate <= %@) OR (room.hotel.name MATCHES %@ AND startDate <= %@ AND endDate >= %@)", selectedHotel,self.startDatePicker.date, self.endDatePicker.date, selectedHotel,self.startDatePicker.date, self.endDatePicker.date, selectedHotel,self.startDatePicker.date, self.endDatePicker.date, selectedHotel,self.startDatePicker.date, self.endDatePicker.date, selectedHotel];

    NSPredicate *reservationPredicate = [NSPredicate predicateWithFormat:@"room.hotel.name MATCHES %@ AND startDate <= %@ AND endDate >= %@", selectedHotel,self.endDatePicker.date, self.startDatePicker.date];

    
    NSLog(@"Start date and End dates to check for availability are : %@ and %@", self.startDatePicker.date, self.endDatePicker.date);

    reservationFetch.predicate = reservationPredicate;
    NSError *fetchError;
    
    NSArray *results = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:reservationFetch error:&fetchError];
    NSLog(@"Rooms reserved in that period are: %lu", (unsigned long)results.count);
    
    NSMutableArray *rooms = [NSMutableArray new];
    
    for (Reservation *reservation in results) {
        [rooms addObject:reservation.room];
        NSLog(@"Rooms checked out for availability are: %@", reservation.room);
    }

    
    NSFetchRequest *anotherFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
    NSPredicate *roomsPredicate = [NSPredicate predicateWithFormat:@"hotel.name MATCHES %@ AND NOT (self IN %@)",selectedHotel, rooms];
    anotherFetchRequest.predicate = roomsPredicate;
    NSError *finalError;
    NSArray *finalResults = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:anotherFetchRequest error:&finalError];
    if (finalError) {
        NSLog(@"%@",finalError.localizedDescription);
    }
    
    NSLog(@"results for number of available rooms : %lu",(unsigned long)finalResults.count);
    //NSLog(@"ARRAY for number of available rooms : %@",finalResults);
    
    for (Room *availableRoom in finalResults) {
        NSLog(@"These room is available for this hotel and dates selected: %@", availableRoom);
    }
    
    //case 1 Start date overlaps existing reservation
    

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
