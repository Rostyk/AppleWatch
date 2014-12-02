//
//  CountDown.h
//  Countdown
//
//  Created by Ross on 26/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountDown : NSObject
-(NSDate*) date;
-(id) initWithDate: (NSDate*) date;
@property (nonatomic, strong) NSString *associatedImageName;
-(void) setTimeWithHours: (NSUInteger) hours minutes: (NSUInteger) minutes;
@end
