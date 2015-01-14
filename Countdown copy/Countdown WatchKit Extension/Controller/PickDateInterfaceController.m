//
//  PickDateInterfaceController.m
//  Countdown
//
//  Created by Ross on 25/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "PickDateInterfaceController.h"
#import "DateHelper.h"
#import "RowController.h"
#import "CountDown.h"
#import "CountdownsManager.h"
#import "ControllerMode.h"
#import "App.h"

typedef NS_ENUM(NSInteger, DateMode) {
    DM_YEAR,
    DM_MONTH,
    DM_DAY
};

@interface PickDateInterfaceController()
@property (nonatomic, weak) IBOutlet WKInterfaceTable *table;
@property (nonatomic) DateMode dateMode;
@property (nonatomic) BOOL needsDismissing;

@property (nonatomic, strong) NSString *selectedYear;
@property (nonatomic, strong) NSString *selectedMonth;
@property (nonatomic, strong) NSString *selectedDay;
@end

@implementation PickDateInterfaceController

#pragma mark lifecycle

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
       self.dateMode = DM_YEAR;
       [self cacheImages];
    }
    return self;
}

#pragma mark configure table datasources

- (void)configureTableForYears {

    //Years table view
    NSArray *years = [DateHelper yearsForDatePicker];
    [self.table setNumberOfRows:years.count withRowType:@"Row"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        RowController* row = [self.table rowControllerAtIndex:i];
        [row.textLabel setText: [years objectAtIndex: i]];
    }
}

- (void)configureTableForMonths {
    NSArray *months = [DateHelper monthsForDatePicker];
    [self.table setNumberOfRows:months.count withRowType:@"Row"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        RowController* row = [self.table rowControllerAtIndex:i];
        [row.textLabel setText: [months objectAtIndex: i]];
    }
}

- (void)configureTableForDays {
    NSUInteger days = [DateHelper daysForYear:self.selectedYear month:self.selectedMonth];
    [self.table setNumberOfRows: days withRowType:@"Row"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        RowController* row = [self.table rowControllerAtIndex:i];
        [row.textLabel setText: [NSString stringWithFormat:@"%ld", (i+1)]];
    }
}

#pragma mark table row selection

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    RowController* row = [self.table rowControllerAtIndex:rowIndex];
    [row.image setImageNamed: @"date-selection-mark-active"];

    switch (self.dateMode) {
        case DM_YEAR: {
            self.selectedYear =  [[DateHelper yearsForDatePicker] objectAtIndex: rowIndex];
            [self performSelector:@selector(setDateModeDelayed:) withObject: @(DM_MONTH) afterDelay: 0.5];
            break;
        }
        case DM_MONTH: {
            self.selectedMonth =  [[[DateHelper monthsForDatePicker] objectAtIndex: rowIndex] substringToIndex:3];
            [self performSelector:@selector(setDateModeDelayed:) withObject: @(DM_DAY) afterDelay: 0.5];
            break;
        }

        case DM_DAY: {
            self.selectedDay = [NSString stringWithFormat:@"%ld", (rowIndex + 1)];

            NSDate *date = [DateHelper dateOfYear: self.selectedYear month:self.selectedMonth day:self.selectedDay hours: @"0" minutes:@"0" seconds:@"0"];

            if(self.controllerMode == CM_CREATE) {
                CountDown *countDown = [[CountDown alloc] initWithDate:date];
                [[CountdownsManager sharedManager] addCountDown:countDown];
                self.needsDismissing = YES;
                [self performSelector:@selector(presentTimeController) withObject:nil afterDelay:0.4];
            }
            else {
                [[CountdownsManager sharedManager].editedCountdown setDate: date];
                [[App sharedApp].controllerToPresentOn dismissController];
            }

            break;
        }

        default:
            break;
    }
}

- (void)willActivate {

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
}

- (void)presentTimeController {
    [self presentControllerWithName:@"PickTimeInterfaceController" context: @{@"mode" : @(CM_CREATE)}];
}

#pragma mark cache images

-(void) cacheImages {
    WKInterfaceDevice *device = [WKInterfaceDevice currentDevice];
    [device addCachedImage: [UIImage imageNamed:@"date-selection-mark-active"] name: @"date-selection-mark-active"];
}

#pragma mark date mode handling

-(void) setDateModeDelayed: (NSNumber*) dateMode {
    self.dateMode = (DateMode)([dateMode integerValue]);
}

-(void) setDateMode:(DateMode)dateMode {
    _dateMode = dateMode;
    switch (dateMode) {
        case DM_YEAR:
            [self configureTableForYears];
            [self setTitle: @"Cancel"];
            break;
        case DM_MONTH:
            [self configureTableForMonths];
            [self setTitle: @"Cancel"];
            break;
        case DM_DAY:
            [self configureTableForDays];
            [self setTitle: @"Cancel"];
            break;

        default:
            break;
    }
}

@end
