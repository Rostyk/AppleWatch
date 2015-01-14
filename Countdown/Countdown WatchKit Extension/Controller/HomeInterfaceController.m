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
#import <AssetsLibrary/AssetsLibrary.h>
#import "ControllerMode.h"


@interface HomeInterfaceController()
@property (nonatomic, weak) IBOutlet WKInterfaceTimer *smallerTimer;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *smallerTimerGroup;

@property (nonatomic, weak) IBOutlet WKInterfaceTimer *largerTimer;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *largerTimerGroup;

@property (nonatomic, weak) WKInterfaceTimer *timer;
@property (nonatomic, weak) WKInterfaceGroup *timerGroup;

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *dateLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *bgGroup;
@property (nonatomic) NSUInteger fontSize;
-(IBAction) addCountdownItemClicked:(id)sender;
-(IBAction) viewCountdownsItemClicked:(id)sender;
-(IBAction) tutorialItemClicked:(id)sender;
@end


@implementation HomeInterfaceController


#pragma mark lifecycle
- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        NSLog(@"%@ initWithContext", self);
    }
    return self;
}

- (void)willActivate {
    
    [self displayProperTimer];
    [self displayBackground];
    [App sharedApp].controllerToPresentOn = self;
    CountDown *countDown = [[CountdownsManager sharedManager] newlyAddedCountDown];
    NSDate *date = nil;

    if(countDown) {
        date = [countDown date];
        [self.timer setDate: [countDown date]];
        [self setBottomDate: date];
    }
    else {
        date = [[NSDate date] dateByAddingTimeInterval: 60*60*24*5];
        
        [self setBottomDate: [[NSDate alloc] init]];
        [self.timer setDate: date];
    }

    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size: self.fontSize];
    CGSize size = [DateHelper timerDateStringSizeForDate:date font:font];
    
    [self.timer setWidth: size.width];
    //[self.timer setHeight: size.height];
    [self.timer start];
}

#pragma mark setting date (bottom of the screeb)
-(void) setBottomDate: (NSDate *)date{
    NSAttributedString *dateString = [DateHelper stringForMainScreenDateLabel: date];
    [self.dateLabel setAttributedText: dateString];
}

#pragma mark showing / hiding timer according to screen resolution
-(void) displayProperTimer {
    if([[App sharedApp] isLargerDeviceScreen]) {
        self.timer = self.largerTimer;
        self.timerGroup = self.largerTimerGroup;
        [self.smallerTimerGroup setHidden: YES];
        self.fontSize = 29;
    }
    else {
        self.timer = self.smallerTimer;
        self.timerGroup = self.smallerTimerGroup;
        [self.largerTimerGroup setHidden: YES];
        self.fontSize = 26;
    }
}

#pragma mark displaying background
-(void) displayBackground {
   CountDown *countDown = [[CountdownsManager sharedManager] newlyAddedCountDown];

    if(countDown) {
        [countDown getFullscreenImageWithCompletionBlock:^(UIImage *image) {
            [self.bgGroup setBackgroundImage: image];
        }];
    }

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
    [self presentControllerWithName: @"CountdownsListInterfaceController" context: @{@"mode" : @(CM_CREATE)}];
}

-(IBAction) tutorialItemClicked:(id)sender {
    [self presentControllerWithNames:@[@"TutorialsScreen1", @"TutorialsScreen2", @"TutorialsScreen3", @"TutorialsScreen4"] contexts: nil];
}

@end



