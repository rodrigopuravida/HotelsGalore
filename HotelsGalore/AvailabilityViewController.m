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
    
    NSString *selectedHotel = [self.hotelSegmentControl titleForSegmentAtIndex:self.hotelSegmentControl.selectedSegmentIndex];
    NSLog(@"Hotel selected for availability is %@", selectedHotel.description);
    
    
    [[HotelService sharedService] checkRoomAvailabilityForGuest:selectedHotel startDate:self.startDatePicker.date endDate:self.endDatePicker.date];

    [self dismissViewControllerAnimated:true completion:nil];
    
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
