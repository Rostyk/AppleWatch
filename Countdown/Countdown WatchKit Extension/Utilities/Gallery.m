//
//  Gallery.m
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "Gallery.h"
#import <WatchKit/WatchKit.h>

#define NUMBER_OF_ROWS_IN_GALLERY  4
#define NUMBER_OF_IMAGES_IN_ROW    3

@interface Gallery()
@property (nonatomic, strong) NSMutableArray *arrayOfImageNames;
@end

@implementation Gallery

#pragma mark lifecycle
-(id) init {
    self = [super init];
    [self cacheImages];
    return self;
}

#pragma mark handling images
-(void) cacheImages {
    WKInterfaceDevice *device = [WKInterfaceDevice currentDevice];
    for(int row=0; row < NUMBER_OF_ROWS_IN_GALLERY; row++)
        for(int item=1; item <= NUMBER_OF_IMAGES_IN_ROW; item++) {

            NSString *imageName = [NSString stringWithFormat:@"gal%i%i", (row+1), item];
            [device addCachedImage: [UIImage imageNamed: imageName] name: imageName];
            [self.arrayOfImageNames addObject: imageName];
        }
}

-(NSMutableArray*) arrayOfImageNames {
    if(!_arrayOfImageNames) {
        _arrayOfImageNames = [[NSMutableArray alloc] init];
    }
    return _arrayOfImageNames;
}

-(NSString*) imageForRow: (int) row {
    return self.arrayOfImageNames[row];
}

-(NSUInteger) numberOfRows {
    return NUMBER_OF_IMAGES_IN_ROW;
}

@end
