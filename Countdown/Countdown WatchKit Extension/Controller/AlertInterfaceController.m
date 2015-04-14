//
//  AlertInterfaceController.m
//  Countdown
//
//  Created by Ross on 2/17/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AlertInterfaceController.h"
#import "ControllerMode.h"
#import "CountdownsManager.h"
#import "DateHelper.h"

@interface AlertInterfaceController()
@property (nonatomic, weak) IBOutlet WKInterfaceButton *alertTimeButton;
@property (nonatomic, weak) IBOutlet WKInterfaceSwitch *alertSwitch;
@end


@implementation AlertInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    [self checkAlertDate];
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark handle alert date

- (void) checkAlertDate {
    Countdown *countdown = [CountdownsManager sharedManager].editedCountdown;
    NSDate *alertDate = countdown.alertDate;
    NSDate *startDate = countdown.date;
    
    
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the NSDates
    NSDate *date1 = alertDate;
    NSDate *date2 = startDate;
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    
    NSUInteger minutes = [conversionInfo minute];
    NSUInteger hours = [conversionInfo hour];
    NSUInteger days = [conversionInfo day];
    
    NSString *title = @"";
    if(alertDate == nil) {
        title = @"Set Reminder";
    }
    else {
        if(days > 0) {
            NSString *suffix = (days == 1) ? @"day" : @"days";
            title = [NSString stringWithFormat:@"%lu %@", (unsigned long)days, suffix];
        }
        else if (hours > 0 && minutes > 0) {
            NSString *suffix = (hours == 1) ? @"hour" : @"hours";
            title = [NSString stringWithFormat:@"%lu %@ %lu min", (unsigned long)hours, suffix, minutes];
        }
        else if(hours > 0) {
            NSString *suffix = (hours == 1) ? @"hour" : @"hours";
            title = [NSString stringWithFormat:@"%lu %@", (unsigned long)hours, suffix];
        }
        else if (minutes > 0) {
            NSString *suffix = (hours == 1) ? @"minute" : @"minutes";
            title = [NSString stringWithFormat:@"%lu %@", (unsigned long)minutes, suffix];
        }
    }
    
    [self.alertTimeButton setTitle:title];
}

- (IBAction)alertButtonClicked {
    id context = @{ @"mode" : @(CM_EDIT) , @"screenMode": @(SM_ALERT) };
    [self presentControllerWithName:@"PickDateInterfaceController" context:context];
}

@end



