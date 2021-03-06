//
//  AppDelegate.m
//  HotelsGalore
//
//  Created by Rodrigo Carballo on 2/9/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

#import "AppDelegate.h"
#import "Hotel.h"
#import "Room.h"
#import "Bucket.h"
#import "HashTable.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory  inDomains:NSUserDomainMask] lastObject]);
    
    // Override point for customization after application launch.
    
    
    
    
    //MARK: TESTING HASH TABLE ===========================================================
    NSLog(@"TESTING HASHTABLE");
    
    //initializing hash table
    HashTable *myHashTable = [[HashTable alloc] initWithSize:10];
    
    for (int i = 0; i <30;i++)
    {
        NSString *key = [NSString stringWithFormat:@"key %d",i];
        [myHashTable setObject:[NSString stringWithFormat:@"Bat %d",i] forKey:key];
        NSLog(@"Key is: %@", key);
    }
    //remove one node from middle key '15'
    NSLog(@"Removing Key 15");
    [myHashTable removeObjectForKey:@"15"];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    //[self saveContext];
}


@end
