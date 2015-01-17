//
//  CountdownsManager.m
//  Countdown
//
//  Created by Ross on 26/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "CountdownsManager.h"
#import "Countdown.h"
#import "DataProvider.h"

@implementation CountdownsManager

+ (instancetype)sharedManager
{
	static dispatch_once_t once;
	static id sharedInstance;

	dispatch_once(&once, ^
	{
		sharedInstance = [self new];
	});

	return sharedInstance;
}

@end
