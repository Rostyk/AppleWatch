//
//  DateHelper.m
//  Countdown
//
//  Created by Ross on 25/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "DateHelper.h"
#import <WatchKit/WatchKit.h>

#define NUMBER_OF_YEARS_TO_DISPLAY_IN_PICKER   3
#define LARGEST_NUMBER_OF_DIGITS_IN_PICKER     11

#define LARGER_SCREEN_WIDTH                    156
@implementation DateHelper

+ (NSArray*) yearsForDatePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    NSUInteger currentYear = [yearString integerValue];
    NSMutableArray *years = [[NSMutableArray alloc] init];
    for(int i=0; i<NUMBER_OF_YEARS_TO_DISPLAY_IN_PICKER + 1; i++) {
        [years addObject: [NSString stringWithFormat:@"%lu", (currentYear + i)]];
    }

    return years;
}

+ (NSArray*) monthsForDatePicker {
    return @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
}

+ (NSDate*) dateOfYear: (NSString*) year month: (NSString*)month day: (NSString*)day hours: (NSString*) hours minutes: (NSString*) minutes seconds: (NSString*) seconds {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MMM-dd hh:mm:ss"];
    NSString *combinedDateString = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@", year, month, day, hours, minutes, seconds];

   return [formatter dateFromString: combinedDateString];

}

+(NSUInteger) daysForYear: (NSString*) year month: (NSString*) month {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MMM-dd"];
    NSString *dateString = [NSString stringWithFormat:@"%@-%@-01", year, month];
    NSDate *date = [formatter dateFromString: dateString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:date];

    return (days.length + 1);
}

+(NSUInteger) daysForCurrentDate {
    NSDate *date = [[NSDate alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:date];
    return days.length;
}

+(NSString*) timerDateStringForDate: (NSDate*) targetDate font: (UIFont*)font{

    NSUInteger flags = NSCalendarUnitDay | NSCalendarUnitHour| NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *now = [[NSDate alloc] init];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:now toDate: targetDate options:0];


    NSString* daysString = ([components day] > 0) ? ([NSString stringWithFormat:@"%ldd ", (long)[components day]]) : @"";
    // in case its more than 999 days it ill display 1, 000d
    if ([daysString length] > 5) {
        NSMutableString *mutable = [NSMutableString stringWithString:daysString];
        [mutable insertString:@"," atIndex: [daysString length]-3];
        daysString = mutable;
    }
    NSString *minutesString = ([components minute] <= 9) ? ([NSString stringWithFormat:@"0%ld", (long)[components minute]]) : [NSString stringWithFormat:@"%ld", (long)[components minute]];
    NSString *secondsString = ([components second] <= 9) ? ([NSString stringWithFormat:@"0%ld", (long)[components second]]) : [NSString stringWithFormat:@"%ld", (long)[components second]];

    NSString *timerString = [NSString stringWithFormat:@"%@%ld:%@:%@",daysString, (long)[components hour], minutesString, secondsString];

    return timerString;
}

+(CGSize) timerDateStringSizeForDate: (NSDate*) targetDate font: (UIFont*)font{


    NSString *timerString = [DateHelper timerDateStringForDate: targetDate font:font];


    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 0.5;

    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:timerString attributes:@{NSFontAttributeName : font}];


    CGRect labelRect = [attributedString
                        boundingRectWithSize:CGSizeMake([WKInterfaceDevice currentDevice].screenBounds.size.width*2, font.pointSize)
                        options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                        
                        context: context];
    float trackingApplied = font.pointSize - context.actualScaleFactor * font.pointSize;
    CGFloat actualFontSize = round(font.pointSize * context.actualScaleFactor);
    labelRect.size.height = actualFontSize + trackingApplied;


    NSUInteger length = [DateHelper timerDateStringForDate:targetDate font:font].length;

    NSLog(@"Screen width: %f", [WKInterfaceDevice currentDevice].screenBounds.size.width);
    if(length > LARGEST_NUMBER_OF_DIGITS_IN_PICKER) {
        //if((int)[WKInterfaceDevice currentDevice].screenBounds.size.width == LARGER_SCREEN_WIDTH)
            //labelRect.size.height -= 5;
        //else
            labelRect.size.height -= trackingApplied /2.;
    }


   return labelRect.size;
}

+(NSString*) stringDateForCountdownsListCell: (NSDate*) date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM. dd, yyyy"];
    return [formatter stringFromDate: date];
}

+(NSAttributedString*) stringForMainScreenDateLabel: (NSDate*) date {

    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor : [UIColor blackColor]];
    [shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
    [shadow setShadowBlurRadius : 1];



    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@" EEE, MMM. d, yyyy"];
    NSString *dateString = [formatter stringFromDate: date];

    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString : dateString attributes : @{
                                                                                                                  NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size: 13],NSShadowAttributeName : shadow }];
    return attributedString;
}

@end
