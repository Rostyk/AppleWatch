//
//  CountdownsManager.h
//  Countdown
//
//  Created by Ross on 26/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CountDown;

@interface CountdownsManager : NSObject
+ (instancetype)sharedManager;
-(void) addCountDown: (CountDown*) countDown;
-(CountDown*) newlyAddedCountDown;
-(NSArray*) allCountdowns;
@end
