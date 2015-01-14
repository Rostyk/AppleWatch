//
//  CountdownsManager.m
//  Countdown
//
//  Created by Ross on 26/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "CountdownsManager.h"

@interface CountdownsManager()
@property (nonatomic, strong) NSMutableArray *countdowns;
@end

@implementation CountdownsManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static id sharedInstance;

    dispatch_once(&once, ^
                  {
                      sharedInstance = [self new];
                  });
    
    return sharedInstance;
}

-(NSMutableArray*) countdowns {
    if(!_countdowns) {
        _countdowns = [[NSMutableArray alloc] init];
    }
    return _countdowns;
}

-(void) addCountDown: (CountDown*) countDown {
    [self.countdowns addObject: countDown];
}

-(CountDown*) newlyAddedCountDown {
    return [self.countdowns lastObject];
}

-(NSArray*) allCountdowns {
    return self.countdowns;
}

@end
