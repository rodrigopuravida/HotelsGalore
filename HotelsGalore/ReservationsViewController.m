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
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.selectedRoom.managedObjectContext];
    
    reservation.startDate = self.startDatePicker.date;
    reservation.endDate = self.endDatePicker.date;
    reservation.room = self.selectedRoom;
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.selectedRoom.managedObjectContext];
//    guest.firstName = @"Bruce";
//    guest.lastName = @"Waynwe";
    guest.firstName = self.firstNameGuest.text;
    guest.lastName = self.lastNameGuest.text;
    reservation.guest = guest;
    
    NSLog(@"%lu",(unsigned long)self.selectedRoom.reservations.count);
    
    NSError *saveError;
    [self.selectedRoom.managedObjectContext save:&saveError];
    
    if (saveError) {
        NSLog(@" %@",saveError.localizedDescription);
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
