//
//  Countdown.m
//  Countdown
//
//  Created by Ross on 1/17/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "Countdown.h"
#import "FavouritePhoto.h"
#import "LocalPhotosManager.h"

@implementation Countdown

@dynamic date;
@dynamic alertDate;
@dynamic associatedImageName;
@dynamic favouritePhoto;


#pragma mark lifecycle
- (id)initWithDate:(NSDate *)date
{
    self = [super init];
    self.date = date;
    return self;
}



- (void)setTimeWithHours:(NSUInteger)hours minutes:(NSUInteger)minutes
{
    NSDate *oldDate = self.date;
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:oldDate];
    
    comps.hour   = hours;
    comps.minute = minutes;
    comps.second = 0;
    NSDate *newDate = [calendar dateFromComponents:comps];
    self.date = newDate;
}


- (void)getFullscreenImageWithCompletionBlock:(imageFetchingCompletion)completion
{
    if (self.associatedImageName)
    {
        UIImage *fullScreenImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_fullscreen", self.associatedImageName]];
        completion(fullScreenImage);
    }
    else
    {
        [[LocalPhotosManager sharedManager] fetchFavouriteFullscreenImageWithAssetID:self.favouritePhoto.photoID andCompletion:completion];
    }
}

- (UIImage *)image
{
    if (self.associatedImageName)
    {
        return [UIImage imageNamed:self.associatedImageName];
    }
    else if (self.favouritePhoto)
    {
        return self.favouritePhoto.image;
    }
    
    return nil;
}



@end
