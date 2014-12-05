//
//  Gallery.h
//  Countdown
//
//  Created by Steven on 01/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gallery : NSObject
-(NSString*) imageForRow: (NSUInteger) row;
-(NSUInteger) numberOfRows;
@end
