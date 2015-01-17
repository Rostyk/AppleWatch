//
//  PickImageInterfaceController.h
//  Countdown
//
//  Created by Steven on 03/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "BaseController.h"

@interface PickImageInterfaceController : BaseController
@property (weak, nonatomic)IBOutletCollection(WKInterfaceButton) NSArray * coll;

- (void)reloadData;
@end
