//
//  PickImageInterfaceController.m
//  Countdown
//
//  Created by Steven on 03/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "PickImageInterfaceController.h"
#import "ImageButton.h"
#import "App.h"
#import "Gallery.h"
#import "WKInterfaceButton+Tag.h"
#import "CountDown.h"
#import "CountdownsManager.h"

@interface PickImageInterfaceController()

@property (nonatomic, strong) NSArray *buttons;
//I know its crazy! Since we have no Outletcolelction in this release of WatchKit, lets just out it this ugly way
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button1;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button2;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button3;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button4;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button5;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button6;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button7;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button8;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button9;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button10;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button11;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button12;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button13;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button14;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button15;

@end

@implementation PickImageInterfaceController
#pragma mark lifecycle
- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        [self configureImageButtons];
    }
    return self;
}

- (void) configureImageButtons {
    int i = 0;
    for(WKInterfaceButton *button in self.buttons) {
        NSString *imageName = [[App sharedApp].gallery imageForRow: i];
        [button setBackgroundImageNamed: imageName];
        CGFloat size = [[WKInterfaceDevice currentDevice] screenBounds].size.width /3.1;
        [button setWidth: size];
        [button setHeight: size];
        [button setTag: i];
        i++;
    }
}

- (void)willActivate {
    //[App sharedApp].controllerToPresentOn = self;
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

#pragma mark accessing buttons
-(NSArray*) buttons{
    if(!_buttons) {
        _buttons = @[self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15];
    }
    return _buttons;
}

// IB action doesn't support the sender object
#pragma mark image selection
-(IBAction) imageButton1Clicked { [self buttonClicked: self.button1]; }
-(IBAction) imageButton2Clicked { [self buttonClicked: self.button2]; }
-(IBAction) imageButton3Clicked { [self buttonClicked: self.button3]; }
-(IBAction) imageButton4Clicked { [self buttonClicked: self.button4]; }
-(IBAction) imageButton5Clicked { [self buttonClicked: self.button5]; }
-(IBAction) imageButton6Clicked { [self buttonClicked: self.button6]; }
-(IBAction) imageButton7Clicked { [self buttonClicked: self.button7]; }
-(IBAction) imageButton8Clicked { [self buttonClicked: self.button8]; }
-(IBAction) imageButton9Clicked { [self buttonClicked: self.button9]; }
-(IBAction) imageButton10Clicked { [self buttonClicked: self.button10]; }
-(IBAction) imageButton11Clicked { [self buttonClicked: self.button11]; }
-(IBAction) imageButton12Clicked { [self buttonClicked: self.button12]; }
-(IBAction) imageButton13Clicked { [self buttonClicked: self.button13]; }
-(IBAction) imageButton14Clicked { [self buttonClicked: self.button14]; }
-(IBAction) imageButton15Clicked { [self buttonClicked: self.button15]; }

-(void) buttonClicked: (WKInterfaceButton*) button {
    NSUInteger tag = [self.buttons indexOfObject: button];
    CountDown *countDown = [[CountdownsManager sharedManager] newlyAddedCountDown];
    countDown.associatedImageName = [[App sharedApp].gallery imageForRow: tag];
    [[App sharedApp].controllerToPresentOn dismissController];
}
@end
