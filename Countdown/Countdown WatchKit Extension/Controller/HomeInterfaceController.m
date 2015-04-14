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
#import "DataProvider.h"

#define HOURS_IMIT_FOR_RED_COUNTDOWN               24


@interface HomeInterfaceController ()
@property (nonatomic, weak) IBOutlet WKInterfaceTimer *smallerTimer;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *smallerTimerGroup;

@property (nonatomic, weak) IBOutlet WKInterfaceTimer *largerTimer;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *largerTimerGroup;

@property (nonatomic, weak) WKInterfaceTimer *timer;
@property (nonatomic, weak) WKInterfaceGroup *timerGroup;

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *dateLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *bgGroup;
@property (nonatomic) NSUInteger fontSize;
- (IBAction)addCountdownItemClicked:(id)sender;
- (IBAction)viewCountdownsItemClicked:(id)sender;
- (IBAction)tutorialItemClicked:(id)sender;
@end


@implementation HomeInterfaceController


#pragma mark lifecycle
- (instancetype)initWithContext:(id)context
{
	self = [super init];
	if (self)
	{
		NSLog(@"%@ initWithContext", self);
	}
	return self;
}

- (void)willActivate
{
    [self displayProperTimer];
    [[DataProvider sharedProvider] creatingOfCountdownComplete];
	[App sharedApp].controllerToPresentOn = self;
	Countdown *countDown = [[CountdownsManager sharedManager] newlyAddedCountDown];
    if(!countDown) {
        countDown = [[DataProvider sharedProvider] latestCountdown];
    }
        
    if(countDown == nil) {
        // lets check if there're any countdowns added. If there're - display the closest
        NSArray *array = [[DataProvider sharedProvider] countDowns];
        
        if(array.count > 0) {
            if([App sharedApp].selectedIndex != -1) {
                countDown = array[[App sharedApp].selectedIndex];
            }
            else {
               countDown = [array firstObject];
            }
        }
    }
    [self displayBackgroundForCountdown:countDown];
	NSDate *date = nil;

	if (countDown)
	{
		date = [countDown date];
		[self.timer setDate:date];
		[self setBottomDate:date];
        [CountdownsManager sharedManager].editedCountdown = nil;
	}
	else
	{
		date = [[NSDate date] dateByAddingTimeInterval:60 * 60 * 24 * 5];

		[self setBottomDate:date];
		[self.timer setDate:date];
	}

	UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize];
	CGSize size = [DateHelper timerDateStringSizeForDate:date font:font];

	[self.timer setWidth:size.width];
	// [self.timer setHeight: size.height];
	[self.timer start];
}

#pragma mark setting date (bottom of the screeb)
- (void)setBottomDate:(NSDate *)date
{
	NSAttributedString *dateString = [DateHelper stringForMainScreenDateLabel:date];

    
    NSUInteger seconds = [DateHelper secondsBetweendates:date date:[[NSDate alloc] init]];
    double secondsInAnHour = 3600;
    NSUInteger hoursBetweenDates = seconds / secondsInAnHour;
    
    if(fabs(hoursBetweenDates) < HOURS_IMIT_FOR_RED_COUNTDOWN) {
        [self.smallerTimer setTextColor:[UIColor redColor]];
        [self.largerTimer setTextColor:[UIColor redColor]];
    }
    else {
        [self.smallerTimer setTextColor:[UIColor whiteColor]];
        [self.largerTimer setTextColor:[UIColor whiteColor]];
    }
	[self.dateLabel setAttributedText:dateString];
}

#pragma mark showing / hiding timer according to screen resolution
- (void)displayProperTimer
{
	if ([[App sharedApp] isLargerDeviceScreen])
	{
		self.timer = self.largerTimer;
		self.timerGroup = self.largerTimerGroup;
		[self.smallerTimerGroup setHidden:YES];
		self.fontSize = 29;
	}
	else
	{
		self.timer = self.smallerTimer;
		self.timerGroup = self.smallerTimerGroup;
		[self.largerTimerGroup setHidden:YES];
		self.fontSize = 26;
	}
}

#pragma mark displaying background
- (void)displayBackgroundForCountdown:(Countdown *)countDown
{
	if (countDown)
	{
		[countDown getFullscreenImageWithCompletionBlock:^(UIImage *image) {
			 [self.bgGroup setBackgroundImage:image];
		 }];
	}
}

- (void)didDeactivate
{
	// This method is called when watch view controller is no longer visible
	NSLog(@"%@ did deactivate", self);
}

#pragma mark context menu
- (IBAction)addCountdownItemClicked:(id)sender
{
	// [self pushControllerWithName: @"PickYearInterfaceController" context: @{@"from" : @"HomeController"} ];
	[self presentControllerWithName:@"PickDateInterfaceController" context:nil];
}

- (IBAction)viewCountdownsItemClicked:(id)sender
{
	[self presentControllerWithName:@"CountdownsListInterfaceController" context:@{ @"mode" : @(CM_CREATE) }];
}

- (IBAction)tutorialItemClicked:(id)sender
{
	[self presentControllerWithNames:@[@"TutorialsScreen1", @"TutorialsScreen2", @"TutorialsScreen3", @"TutorialsScreen4"] contexts:nil];
}

@end
