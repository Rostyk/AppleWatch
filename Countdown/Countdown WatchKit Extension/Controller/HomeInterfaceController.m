//
//  InterfaceController.m
//  Countdown WatchKit Extension
//
//  Created by Ross on 21/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "HomeInterfaceController.h"
#import "PickDateInterfaceController.h"
#import "DateHelper.h"
#import "CountdownsManager.h"
#import "CountDown.h"
#import "App.h"

@interface HomeInterfaceController()
@property (nonatomic, weak) IBOutlet WKInterfaceTimer *timer;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *timerGroup;
-(IBAction) addCountdownItemClicked:(id)sender;
-(IBAction) viewCountdownsItemClicked:(id)sender;
-(IBAction) tutorialItemClicked:(id)sender;
@end


@implementation HomeInterfaceController


#pragma mark lifecycle
- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
    }
    return self;
}

- (void)willActivate {

    [App sharedApp].controllerToPresentOn = self;
    CountDown *countDown = [[CountdownsManager sharedManager] newlyAddedCountDown];
    NSDate *date = nil;

    if(countDown) {
        date = [countDown date];
        [self.timer setDate: [countDown date]];
    }
    else {
        NSString *dateStr = @"Tue, 4 Dec 2014 22:53:58 +0000";
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
        date = [dateFormat dateFromString:dateStr];
        [self.timer setDate: date];
    }

    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:26];
    CGSize size = [DateHelper timerDateStringSizeForDate:date font:font];
    
    [self.timer setWidth: size.width];
    //[self.timer setHeight: size.height];
    

    [self.timer start];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

#pragma mark context menu
- (IBAction)addCountdownItemClicked:(id)sender {
    //[self pushControllerWithName: @"PickYearInterfaceController" context: @{@"from" : @"HomeController"} ];
    [self presentControllerWithName: @"PickDateInterfaceController" context: nil];
}

-(IBAction) viewCountdownsItemClicked:(id)sender {
    [self presentControllerWithName: @"CountdownsListInterfaceController" context: nil];
}

-(IBAction) tutorialItemClicked:(id)sender {
    
}

@end



