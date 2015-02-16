//
//  DataProvider.h
//  Countdown
//
//  Created by Ross on 1/17/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Countdown;
@class FavouritePhoto;

@interface DataProvider : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+ (instancetype)sharedProvider;

- (Countdown *)newCountdown;
- (FavouritePhoto *)favouritePhoto;

- (NSArray *)countDowns;
- (void)removeCountDown:(Countdown *)countDown;
- (void)save;
@end
