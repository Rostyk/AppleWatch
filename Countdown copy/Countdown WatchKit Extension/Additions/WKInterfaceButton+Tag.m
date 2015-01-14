//
//  WKInterfaceButton_Tagged.m
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "WKInterfaceButton+Tag.h"

@implementation WKInterfaceButton(Tag)

NSUInteger _tag;
-(void) setTag:(NSUInteger)tag {
    _tag = tag;
}

-(NSUInteger) tag {
    return _tag;
}
@end
