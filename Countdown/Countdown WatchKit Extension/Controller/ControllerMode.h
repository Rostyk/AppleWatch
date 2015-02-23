//
//  ControllerMode.h
//  Countdown
//
//  Created by Steven on 10/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#ifndef Countdown_ControllerMode_h
#define Countdown_ControllerMode_h

typedef NS_ENUM (NSInteger, ControllerMode) {
	CM_CREATE = 0,
	CM_EDIT,
	CM_ALERT
};

typedef NS_ENUM (NSInteger, ScreenMode)
{
    SM_PLAIN = 0,
    SM_ALERT,
};
#endif
