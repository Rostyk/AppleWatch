//
//  PickImageInterfaceController.h
//  Countdown
//
//  Created by Steven on 03/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <WatchKit/WatchKit.h>

@interface PickImageInterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutletCollection(WKInterfaceButton) NSArray *coll;

@end
