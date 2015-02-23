//
//  NotificationInterfaceController.m
//  Countdown
//
//  Created by Ross on 2/18/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AlertNotificationInterfaceController.h"


@interface AlertNotificationInterfaceController()

@end


@implementation AlertNotificationInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


 - (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
 
      completionHandler(WKUserNotificationInterfaceTypeCustom);
 }


@end



