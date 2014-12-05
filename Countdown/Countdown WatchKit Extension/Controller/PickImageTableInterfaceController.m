//
//  PickImageInterfaceController.m
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "PickImageTableInterfaceController.h"
#import "App.h"
#import "ImageRowController.h"
#import "Gallery.h"
#import "ImageButton.h"
#import "CountdownsManager.h"
#import "Countdown.h"
//#import "WKInterfaceButton+Tag.h"

@interface PickImageTableInterfaceController()
@property (nonatomic, weak) IBOutlet WKInterfaceTable *table;
@end

@implementation PickImageTableInterfaceController

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
    Gallery *gallery = [App sharedApp].gallery;

    //Images table
    [self.table setNumberOfRows: 4 withRowType:@"ImageRow"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        ImageRowController *row = [self.table rowControllerAtIndex: i];

        //left image
        [row.image setImageNamed: [gallery imageForRow:i]];

    }
}

- (void)willActivate {
    //[App sharedApp].controllerToPresentOn = self;
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

#pragma mark image selection

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    CountDown *countDown = [[CountdownsManager sharedManager] newlyAddedCountDown];
    countDown.associatedImageName = [[App sharedApp].gallery imageForRow: rowIndex];
    //[self dismissController];
    [[App sharedApp].controllerToPresentOn dismissController];
}


@end
