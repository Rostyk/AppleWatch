//
//  App.h
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

typedef NS_ENUM (NSInteger, HourMode) {
	HM_24,
	HM_12,
};

@class Gallery;

@interface App : NSObject
+ (instancetype)sharedApp;
@property(nonatomic, assign) WKInterfaceController *controllerToPresentOn;
@property (nonatomic, strong) Gallery *gallery;
@property (nonatomic) NSUInteger selectedIndex;

- (BOOL)isLargerDeviceScreen;
- (HourMode)hourMode;
@end
