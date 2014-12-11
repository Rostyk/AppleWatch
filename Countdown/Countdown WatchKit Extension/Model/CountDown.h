//
//  CountDown.h
//  Countdown
//
//  Created by Ross on 26/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^imageFetchingCompletion)(UIImage*);
@class FavouritePhoto;

@interface CountDown : NSObject
-(NSDate*) date;
-(UIImage*) image;

-(id) initWithDate: (NSDate*) date;
-(void) setDate: (NSDate*) date;
-(void) setTimeWithHours: (NSUInteger) hours minutes: (NSUInteger) minutes;
-(void) setAssociatedImageName:(NSString *)associatedImageName;
-(void) setFavouritePhoto:(FavouritePhoto *)favouritePhoto;

-(void) getFullscreenImageWithCompletionBlock: (imageFetchingCompletion) completion;
@end
