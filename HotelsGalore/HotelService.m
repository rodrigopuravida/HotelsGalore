//
//  HotelService.m
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/11/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import "HotelService.h"

@implementation HotelService

+(id)sharedService {
    static HotelService *mySharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        mySharedService = [[self alloc] init];
    });
    return mySharedService;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.coreDataStack = [[CoreDataStack alloc] init];
    }
    return self;
}

-(instancetype)initForTesting {
    self = [super init];
    if (self) {
        self.coreDataStack = [[CoreDataStack alloc] initForTesting];
    }
    return self;
}

-(Reservation *)bookReservationForGuest:(Guest *)guest ForRoom:(Room *)room startDate:(NSDate*)startDate endDate:(NSDate *)endDate {
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    reservation.guest = guest;
    
    NSLog(@"Start date and End dates for reservation are : %@ and %@", reservation.startDate, reservation.endDate);
    NSLog(@"Hotel reserved is : %@", reservation.room.hotel);
    NSLog(@"Room reserved is : %@", reservation.room.number);
    
    //validation for start date to be less than or equal to end date
    if (reservation.endDate < reservation.startDate) {
        return nil;
    }
    
    
    NSError *saveError;
    [self.coreDataStack.managedObjectContext save:&saveError];
    if (!saveError) {
        return reservation;
    } else {
        return nil;
    }
}

@end
