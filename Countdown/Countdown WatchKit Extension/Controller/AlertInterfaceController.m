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
    NSUInteger seconds = [DateHelper secondsBetweendates:alertDate date:startDate];
    
    NSUInteger minutes = seconds / 60;
    NSUInteger hours = minutes / 60;
    NSUInteger days = minutes / 60;
    
    NSString *title = @"";
    if(alertDate == nil) {
        title = @"Never";
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



