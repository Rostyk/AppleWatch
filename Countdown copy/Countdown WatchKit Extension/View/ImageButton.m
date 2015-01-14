//
//  ImageButton.m
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton

NSUInteger _tag;

-(void) setTag:(NSUInteger)tag {
    _tag = tag;
}

-(NSUInteger) tag {
    return _tag;
}

@end
