//
//  CountdownOptionsInterfaceController.m
//  Countdown
//
//  Created by Ross on 2/11/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "OptionsInterfaceController.h"
#import "App.h"

@interface OptionsInterfaceController()

@end


@implementation OptionsInterfaceController

- (IBAction)selectButtonClicked:(id)sender {
    [[App sharedApp].controllerToPresentOn dismissController];
}

- (IBAction)editButtonClicked:(id)sender {
   [self presentControllerWithName:@"EditCountdownInterfaceController" context:nil];
}

@end



