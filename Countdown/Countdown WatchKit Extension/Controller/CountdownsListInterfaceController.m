//
//  CountdownsListInterfaceController.m
//  Countdown
//
//  Created by Steven on 02/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "CountdownsListInterfaceController.h"
#import "CountdownsRowController.h"
#import "CountdownsManager.h"
#import "DateHelper.h"
#import "DataProvider.h"
#import "CountDown.h"
#import "App.h"

@interface CountdownsListInterfaceController ()
@property (nonatomic, weak) IBOutlet WKInterfaceTable *table;
@end

@implementation CountdownsListInterfaceController

#pragma mark lifecycle
- (instancetype)initWithContext:(id)context
{
	self = [super init];
	if (self)
	{
		[self configureImagesTable];
	}
	return self;
}

#pragma mark configuring table view
- (void)configureImagesTable
{
	DataProvider *provider = [DataProvider sharedProvider];

	// Images table
	[self.table setNumberOfRows:[provider countDowns].count withRowType:@"CountdownRow"];
	for (NSInteger i = 0; i < self.table.numberOfRows; i++)
	{
		CountdownsRowController *row = [self.table rowControllerAtIndex:i];
		Countdown *countdown = [[provider countDowns] objectAtIndex:i];
		[row.dateLabel setText:[DateHelper stringDateForCountdownsListCell:[countdown date]]];
		[row.image setBackgroundImage:[countdown image]];
	}
}

- (void)willActivate
{
}

- (void)didDeactivate
{
	// This method is called when watch view controller is no longer visible
	NSLog(@"%@ did deactivate", self);
}

#pragma mark image selection

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
	DataProvider *provider = [DataProvider sharedProvider];
	Countdown *countDown = [[provider countDowns] objectAtIndex:rowIndex];

    [App sharedApp].selectedIndex = rowIndex;
    
	[CountdownsManager sharedManager].editedCountdown = countDown;
	[self presentControllerWithName:@"OptionsInterfaceController" context:nil];
}

@end
