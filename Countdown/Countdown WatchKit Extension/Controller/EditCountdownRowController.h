//
//  EditContdownRowController.h
//  Countdown
//
//  Created by Steven on 02/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface EditCountdownRowController : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *captionLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *image;
@end
