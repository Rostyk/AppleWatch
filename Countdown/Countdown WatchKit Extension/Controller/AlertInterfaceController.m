//
//  AlertInterfaceController.m
//  Countdown
//
//  Created by Ross on 2/17/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AlertInterfaceController.h"
#import "ControllerMode.h"

@interface AlertInterfaceController()
@property (nonatomic, weak) IBOutlet WKInterfaceButton *alertTimeButton;
@property (nonatomic, weak) IBOutlet WKInterfaceSwitch *alertSwitch;
@end


@implementation AlertInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark set alert date
- (IBAction)alertButtonClicked {
    id context = @{ @"mode" : @(CM_EDIT) , @"screenMode": @(SM_ALERT) };
    [self presentControllerWithName:@"PickDateInterfaceController" context:context];
}

@end



