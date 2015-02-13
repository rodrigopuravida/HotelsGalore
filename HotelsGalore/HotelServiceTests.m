//
//  HotelServiceTests.m
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/11/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "HotelService.h"
#import "Hotel.h"
#import "Room.h"
#import "Guest.h"

@interface HotelServiceTests : XCTestCase

@property (strong,nonatomic) HotelService *hotelService;
@property (strong,nonatomic) Room *room;
@property (strong,nonatomic) Guest *guest;
@property (strong,nonatomic) Hotel *hotel;
@property (strong,nonatomic) NSDate *startDate;
@property (strong,nonatomic) NSDate *endDate;

@end

@implementation HotelServiceTests

- (void)setUp {
    [super setUp];
    self.hotelService = [[HotelService alloc] initForTesting];
    self.hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
    self.hotel.name = @"Fake Hotel";
    self.hotel.location = @"Fake Location";
    self.hotel.rating = @1;
    
    self.room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
    self.room.number = @101;
    self.room.rate = @1;
    self.room.hotel = self.hotel;
    self.room.beds = @2;
    
    self.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
    self.guest.firstName = @"Testy";
    self.guest.lastName = @"McTestorson";
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.startDate = [NSDate date];
    self.endDate = nil;
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.hotelService = nil;
    self.hotel = nil;
    self.guest = nil;
    self.room = nil;
    self.startDate = nil;
    self.endDate = nil;
    
    [super tearDown];
}

- (void)testBookReservation {
    //self.startDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 2;
    self.endDate = [calendar dateByAddingComponents:components toDate:self.startDate options:0];
    
    
    Reservation *reservation = [self.hotelService bookReservationForGuest:self.guest ForRoom:self.room startDate:self.startDate endDate:self.endDate];
    XCTAssertNotNil(reservation,@"reservation should not be nil for valid dates");
}

- (void)testBookReservationWithEndDateBeforeStartDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -4;
    self.endDate = [calendar dateByAddingComponents:components toDate:self.startDate options:0];
    
    
    Reservation *reservation = [self.hotelService bookReservationForGuest:self.guest ForRoom:self.room startDate:self.startDate endDate:self.endDate];
    XCTAssertNil(reservation,@"reservation should be nil for end date smaller than start date");

}

-(void)testBookReservationWithStartDateAInThePast{
    
    self.startDate = [NSDate dateWithTimeIntervalSinceNow:-2*7*24*60*60];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 2;
   
    self.endDate = [calendar dateByAddingComponents:components toDate:self.startDate options:0];

    Reservation *reservation = [self.hotelService bookReservationForGuest:self.guest ForRoom:self.room startDate:self.startDate endDate:self.endDate];
    XCTAssertNil(reservation,@"reservation should be nil for a start date in the past");
    
}


- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
