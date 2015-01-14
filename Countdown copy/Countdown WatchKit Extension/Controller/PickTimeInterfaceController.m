//
//  PickTimeInterfaceController.m
//  Countdown
//
//  Created by Steven on 28/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "PickTimeInterfaceController.h"
#import "App.h"
#import "CountdownsManager.h"
#import "CountDown.h"
#import "ControllerMode.h"

typedef NS_ENUM(NSInteger, TimeMode) {
    TM_HOURS,
    TM_MINUTES,
};

typedef NS_ENUM(NSInteger, ClockMode) {
    CM_AM,
    CM_PM,
    CM_NONE
};



@interface PickTimeInterfaceController()
-(IBAction) setTimeClicked:(id)sender;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *mainButton;
-(IBAction) minusButtonClicked: (id) sender;
-(IBAction) plusButtonClicked: (id) sender;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *timeLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *pmLabel;
@property (nonatomic) TimeMode timeMode;
@property (nonatomic) int timeComponentCount;

@property (nonatomic) ClockMode clockMode;
@property (nonatomic) int pickedHours;
@property (nonatomic) int pickedMinutes;
@property (nonatomic) int maxHour;
@end


@implementation PickTimeInterfaceController


#pragma mark lifecycle
- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        self.timeMode = TM_HOURS;
        self.timeComponentCount = 0;
    }
    return self;
}

- (void)willActivate {
    [self setHourMode];
    [self configureButton];
    [self updateTimeLabel];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (void) setTimeMode:(TimeMode)timeMode {
    _timeMode = timeMode;
    [self configureButton];
}

#pragma mark hour mode
- (void) setHourMode {
    if([[App sharedApp] hourMode] == HM_12) {
        self.clockMode = CM_AM;
        [self.pmLabel setText:@"AM"];
        self.maxHour = 12;
    }
    if([[App sharedApp] hourMode] == HM_24) {
        self.clockMode = CM_NONE;
        self.maxHour = 24;
        [self.pmLabel setAlpha: 0.0];
    }
}

#pragma mark configuring main button
- (void) configureButton {
    switch (self.timeMode) {
        case TM_HOURS:
            [self.mainButton setTitle: @"Set hours"];
            break;
        case TM_MINUTES:
            [self.mainButton setTitle: @"Set minutes"];
            break;
        default:
            break;
    }
}
#pragma mark increasing decreasing time label
-(IBAction) minusButtonClicked: (id) sender {
    [self decreaseTimeComponent];
    [self updateTimeLabel];
}

-(IBAction) plusButtonClicked: (id) sender {
    [self increaseTimeComponent];
    [self updateTimeLabel];
}

#pragma mark set time button clicked
-(IBAction) setTimeClicked:(id)sender {
    switch (self.timeMode) {
        case TM_HOURS:
            self.timeMode = TM_MINUTES;
            self.pickedHours = self.timeComponentCount;
            //adding 12 hours as we're using only 12hrs shift (expl.: 5pm == 17.00)
            if(self.clockMode == CM_PM)
                self.pickedHours += 12;
            [self resetTimeComponent];
            [self.pmLabel setAlpha: 0.0];
            break;
        case TM_MINUTES:
            self.pickedMinutes = self.timeComponentCount;
            [self setCountdownTime];
            [self presentImagePicker];
            break;
        default:
            break;
    }
}

#pragma mark presenting image picker
-(void) presentImagePicker {
    if(self.controllerMode == CM_CREATE) {
        [self presentControllerWithName:@"ImageTypeSelectionInterfaceController" context: @{@"mode" : @(CM_CREATE)}];
    }
    if(self.controllerMode == CM_EDIT) {
        [[App sharedApp].controllerToPresentOn dismissController];
    }

}

#pragma mark upadting time of a countdown 
-(void) setCountdownTime {
    CountdownsManager *manager = [CountdownsManager sharedManager];
    CountDown *countDown = (self.controllerMode == CM_CREATE) ? [manager newlyAddedCountDown] : manager.editedCountdown;
    [countDown setTimeWithHours: self.pickedHours minutes: self.pickedMinutes];
}

#pragma mark managing time component
-(void) increaseTimeComponent {
    switch (self.timeMode) {
        case TM_HOURS:
            self.timeComponentCount ++;
            if(self.timeComponentCount > self.maxHour) {
                self.timeComponentCount = 0;
                [self trackPmLabel];
            }
            break;
        case TM_MINUTES:
            self.timeComponentCount ++;
            if(self.timeComponentCount > 60)
                self.timeComponentCount = 0;
            break;
        default:
            break;
    }

}

-(void) decreaseTimeComponent {
    switch (self.timeMode) {
        case TM_HOURS:
            self.timeComponentCount --;
            if(self.timeComponentCount < 0) {
                self.timeComponentCount = 0;
                [self trackPmLabel];
            }
            break;
        case TM_MINUTES:
            self.timeComponentCount --;
            if(self.timeComponentCount < 0)
                self.timeComponentCount = 0;
            break;
        default:
            break;
    }
}

-(void) resetTimeComponent {
    [self.timeLabel setText:@"00"];
    self.timeComponentCount = 0;
}

#pragma mark tracking pm/am
-(void) trackPmLabel {
    if(self.clockMode == CM_AM) {
        self.clockMode = CM_PM;
        [self.pmLabel setText:@"PM"];
    }
    else if(self.clockMode == CM_PM) {
        self.clockMode = CM_AM;
        [self.pmLabel setText: @"AM"];
    }
}

#pragma mark updating time label
-(void) updateTimeLabel {
    NSString *timeString = (self.timeComponentCount > 9) ? [NSString stringWithFormat: @"%i", self.timeComponentCount] : [NSString stringWithFormat: @"0%i", self.timeComponentCount];
    [self.timeLabel setText: timeString];
}

@end
