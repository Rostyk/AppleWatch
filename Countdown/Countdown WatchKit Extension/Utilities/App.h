//
//  App.h
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
@class Gallery;

@interface App : NSObject
+ (instancetype)sharedApp;
@property(nonatomic, assign) WKInterfaceController *controllerToPresentOn;
@property (nonatomic, strong) Gallery *gallery;
@end
