//
//  App.m
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "App.h"
#import "Gallery.h"

@implementation App

+ (instancetype)sharedApp
{
    static dispatch_once_t once;
    static id sharedInstance;

    dispatch_once(&once, ^
                  {
                      sharedInstance = [self new];
                  });

    return sharedInstance;
}

- (Gallery*)gallery {
    if(!_gallery)
        _gallery = [[Gallery alloc] init];

    return _gallery;
}

@end
