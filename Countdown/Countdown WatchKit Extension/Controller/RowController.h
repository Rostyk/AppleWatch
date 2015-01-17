//
//  RowController.h
//  Countdown
//
//  Created by Ross on 25/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface RowController : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *textLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *image;
@end
