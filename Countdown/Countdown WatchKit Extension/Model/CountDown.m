//
//  CountDown.m
//  Countdown
//
//  Created by Ross on 26/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "CountDown.h"
@interface CountDown()
@property (nonatomic, strong) NSDate *date;
@end

@implementation CountDown

#pragma mark lifecycle
-(id) initWithDate: (NSDate*) date {
    self = [super init];
    _date = date;
    return self;
}

-(NSDate*) date {
    return _date;
}

-(void) setTimeWithHours: (NSUInteger) hours minutes: (NSUInteger) minutes {
    NSDate *oldDate = _date; // Or however you get it.
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:oldDate];
    comps.hour   = hours;
    comps.minute = minutes;
    comps.second = 0;
    NSDate *newDate = [calendar dateFromComponents:comps];
    _date = newDate;
}

@end
