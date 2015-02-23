//
//  NotificationController.m
//  Countdown WatchKit Extension
//
//  Created by Ross on 21/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController ()
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *alertLabel;
@end


@implementation NotificationController

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		// Initialize variables here.
		// Configure interface objects here.
		NSLog(@"%@ init", self);
	}
	return self;
}

- (void)willActivate
{
	// This method is called when watch view controller is about to be visible to user
	NSLog(@"%@ will activate", self);
}


#pragma mark show countdown

- (IBAction)showCountdown:(id)sender {
    
}


- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
 
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}



- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {

    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


@end



