//
//  ReservationsViewController.m
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/10/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import "ReservationsViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "HotelService.h"

@interface ReservationsViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *firstNameGuest;
@property (weak, nonatomic) IBOutlet UITextField *lastNameGuest;

@end

@implementation ReservationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO: Add Image to Top of this Screen
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reserveNowPressed:(id)sender {
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[[HotelService sharedService] coreDataStack].managedObjectContext];
    guest.firstName = self.firstNameGuest.text;
    guest.lastName = self.lastNameGuest.text;
    
    [[HotelService sharedService] bookReservationForGuest:guest ForRoom:self.selectedRoom startDate:self.startDatePicker.date endDate:self.endDatePicker.date];
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
