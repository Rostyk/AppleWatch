//
//  CountdownsListInterfaceController.m
//  Countdown
//
//  Created by Steven on 02/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "CountdownsListInterfaceController.h"
#import "CountdownsRowController.h"
#import "CountdownsManager.h"
#import "DateHelper.h"
#import "CountDown.h"


@interface CountdownsListInterfaceController()
@property (nonatomic, weak) IBOutlet WKInterfaceTable *table;
@end

@implementation CountdownsListInterfaceController

#pragma mark lifecycle
- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        [self configureImagesTable];
    }
    return self;
}

#pragma mark configuring table view
- (void)configureImagesTable {

    CountdownsManager *manager = [CountdownsManager sharedManager];
    //Images table
    [self.table setNumberOfRows: [manager allCountdowns].count withRowType:@"CountdownRow"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        CountdownsRowController *row = [self.table rowControllerAtIndex: i];
        CountDown *countDown = [[manager allCountdowns] objectAtIndex: i];
        [row.dateLabel setText: [DateHelper stringDateForCountdownsListCell: [countDown date]]];
        [row.image setImage: [countDown image]];
    }
}

- (void)willActivate {

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

#pragma mark image selection

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {

     CountdownsManager *manager = [CountdownsManager sharedManager];
     CountDown *countDown = [[manager allCountdowns] objectAtIndex: rowIndex];
    
    [CountdownsManager sharedManager].editedCountdown = countDown;
    [self presentControllerWithName:@"EditCountdownInterfaceController" context: nil];
    
}
@end
