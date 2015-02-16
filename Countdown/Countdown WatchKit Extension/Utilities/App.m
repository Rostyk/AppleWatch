//
//  App.m
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "App.h"
#import "Gallery.h"

#define LARGER_SCREEN_WIDTH 156


@implementation App

+ (instancetype)sharedApp
{
	static dispatch_once_t once;
	static App *sharedInstance;

	dispatch_once(&once, ^
	{
		sharedInstance = [self new];
        sharedInstance.selectedIndex = -1;
	});

	return sharedInstance;
}

- (Gallery *)gallery
{
	if (!_gallery)
	{
		_gallery = [[Gallery alloc] init];
	}

	return _gallery;
}

- (BOOL)isLargerDeviceScreen
{
	if ((int)[WKInterfaceDevice currentDevice].screenBounds.size.width == LARGER_SCREEN_WIDTH)
	{
		return YES;
	}

	return NO;
}

- (HourMode)hourMode
{
	NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];

	if ([[currentTimeZone name] containsString:@"America"])
	{
		return HM_12;
	}
	return HM_12;
}

@end
