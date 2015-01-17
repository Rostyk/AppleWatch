//
//  BaseController.h
//  Countdown
//
//  Created by Steven on 10/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import "ControllerMode.h"


@interface BaseController : WKInterfaceController
@property (nonatomic) ControllerMode controllerMode;
- (instancetype)initWithContext:(NSDictionary *)context;
@end
