//
//  CountdownsManager.h
//  Countdown
//
//  Created by Ross on 26/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Countdown.h"

@interface CountdownsManager : NSObject

@property (nonatomic, strong) Countdown *editedCountdown;
@property (nonatomic, strong) Countdown *newlyAddedCountDown;

+ (instancetype)sharedManager;
@end
