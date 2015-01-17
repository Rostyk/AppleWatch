//
//  Countdown.h
//  Countdown
//
//  Created by Ross on 1/17/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

typedef void (^imageFetchingCompletion)(UIImage *);

@class FavouritePhoto;

@interface Countdown : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDate * alertDate;
@property (nonatomic, retain) NSString * associatedImageName;
@property (nonatomic, retain) FavouritePhoto *favouritePhoto;

- (id)initWithDate:(NSDate *)date;
- (void)setTimeWithHours:(NSUInteger)hours minutes:(NSUInteger)minutes;
- (void)getFullscreenImageWithCompletionBlock:(imageFetchingCompletion)completion;
- (UIImage *)image;
@end
