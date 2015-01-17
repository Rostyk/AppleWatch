//
//  BaseController.m
//  Countdown
//
//  Created by Steven on 10/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "BaseController.h"

@implementation BaseController

- (instancetype)initWithContext:(id)context
{
	self = [super init];
	if (self)
	{
		if (context[@"mode"])
		{
			self.controllerMode = [context[@"mode"] integerValue];
		}
		else
		{
			self.controllerMode = CM_CREATE;
		}
	}
	return self;
}

@end
