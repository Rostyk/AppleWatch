//
//  Gallery.m
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "Gallery.h"
#import <WatchKit/WatchKit.h>

#define NUMBER_OF_IMAGES    36

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
        for (int item = 1; item <= NUMBER_OF_IMAGES; item++) {
            NSString *imageName = [NSString stringWithFormat:@"gallery%i", item];
            [device addCachedImage: [UIImage imageNamed: imageName] name: imageName];
            [self.arrayOfImageNames addObject: imageName];
        }
    NSLog(@"self.arrayOfImageNames:\n%@",self.arrayOfImageNames);
}

-(NSMutableArray*) arrayOfImageNames {
    if(!_arrayOfImageNames) {
        _arrayOfImageNames = [[NSMutableArray alloc] init];
    }
    return _arrayOfImageNames;
}

-(NSString*) imageForRow: (NSUInteger) row {
    return self.arrayOfImageNames[row];
}


@end
