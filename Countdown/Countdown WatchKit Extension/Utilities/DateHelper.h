//
//  DateHelper.h
//  Countdown
//
//  Created by Ross on 25/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DateHelper : NSObject

// date picker
+ (NSArray *)yearsForDatePicker;
+ (NSArray *)monthsForDatePicker;
+ (NSDate *)dateOfYear:(NSString *)year month:(NSString *)month day:(NSString *)day hours:(NSString *)hours minutes:(NSString *)minutes seconds:(NSString *)seconds;

// general
+ (NSUInteger)daysForYear:(NSString *)year month:(NSString *)month;
+ (NSUInteger)daysForCurrentDate;
+ (CGSize)timerDateStringSizeForDate:(NSDate *)targetDate font:(UIFont *)font;
+ (NSString *)timerDateStringForDate:(NSDate *)targetDate font:(UIFont *)font;

+ (NSString *)stringDateForCountdownsListCell:(NSDate *)date;
+ (NSAttributedString *)stringForMainScreenDateLabel:(NSDate *)date;
+ (NSUInteger)secondsBetweendates:(NSDate *)date1 date:(NSDate *)date2;
@end
