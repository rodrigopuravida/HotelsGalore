//
//  HashTable.h
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/13/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject

-(void)setObject:(id)object forKey:(NSString*)key;

-(void)removeObjectForKey:(NSString*)key;

-(void)objectForKey:(NSString*)key;

-(instancetype)initWithSize:(NSInteger*)size;

@end
