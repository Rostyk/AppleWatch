//
//  CountdownsRowController.h
//  Countdown
//
//  Created by Steven on 02/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
@interface CountdownsRowController : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel* dateLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup* image;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup* bgGroup;
@end
