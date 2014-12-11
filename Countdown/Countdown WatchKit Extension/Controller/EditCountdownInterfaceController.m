//
//  EditCountdownInterfaceController.m
//  Countdown
//
//  Created by Steven on 02/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "EditCountdownInterfaceController.h"
#import "EditCountdownRowController.h"
#import "ControllerMode.h"

typedef NS_ENUM(NSInteger, EditItem) {
    EI_DATE = 0,
    EI_TIME,
    EI_IMAGE,
    EI_ALERT
};


@interface EditCountdownInterfaceController()
@property (nonatomic, weak) IBOutlet WKInterfaceTable *table;
@end


@implementation EditCountdownInterfaceController

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

    //Images table
    [self.table setNumberOfRows: 4 withRowType:@"EditCountdownRow"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        EditCountdownRowController *row = [self.table rowControllerAtIndex: i];
        switch (i) {
            case EI_DATE: {
                [row.image setImageNamed:@"edit-date-icon"];
                [row.captionLabel setText:@"Date"];
                break;
            }
            case EI_TIME: {
                [row.image setImageNamed:@"edit-watch-icon"];
                [row.captionLabel setText:@"Time"];
                break;
            }
            case EI_IMAGE: {
                [row.image setImageNamed:@"edit-image-icon"];
                [row.captionLabel setText:@"Image"];
                break;
            }
            case EI_ALERT: {
                [row.image setImageNamed:@"edit-alert-icon"];
                [row.captionLabel setText:@"Alert"];
                break;
            }
            default:
                break;
        }
    }
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    EditItem item = rowIndex;
    id context = @{@"mode" : @(CM_EDIT)};

    NSString *controllerID = nil;
    switch (item) {
        case EI_DATE: {
            controllerID = @"PickDateInterfaceController";
            break;
        }
        case EI_TIME: {
            controllerID = @"PickTimeInterfaceController";
            break;
        }
        case EI_IMAGE: {
            controllerID = @"PickImageInterfaceController";
            break;
        }
        case EI_ALERT: {
            break;
        }
        default:
            break;
    }

    [self presentControllerWithName:controllerID context: context];
}

- (void)willActivate {

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}


@end
