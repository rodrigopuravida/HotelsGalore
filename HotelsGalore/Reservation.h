//
//  Reservation.h
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/9/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room;
@class Guest;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Room *room;
@property (nonatomic, retain) Guest *guest;

@end
