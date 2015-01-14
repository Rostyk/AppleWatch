//
//  CountDown.m
//  Countdown
//
//  Created by Ross on 26/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#include "FavouritePhoto.h"
#import "CountDown.h"
#import <WatchKit/WatchKit.h>
#import "LocalPhotosManager.h"

@interface CountDown()
@property (nonatomic, strong) NSDate *theDate;
@property (nonatomic, strong) NSString *associatedImageName;
@property (nonatomic, strong) FavouritePhoto *favouritePhoto;
@end

@implementation CountDown

#pragma mark lifecycle
-(id) initWithDate: (NSDate*) date {
    self = [super init];
    _theDate = date;
    return self;
}

-(NSDate*) date {
    return _theDate;
}

-(void) setDate: (NSDate*) date {
    _theDate = date;
}

-(void) setTimeWithHours: (NSUInteger) hours minutes: (NSUInteger) minutes {
    NSDate *oldDate = _theDate; // Or however you get it.
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:oldDate];
    comps.hour   = hours;
    comps.minute = minutes;
    comps.second = 0;
    NSDate *newDate = [calendar dateFromComponents:comps];
    _theDate = newDate;
}

#pragma mark image name of a defaul gallery iage

-(void) setAssociatedImageName:(NSString *)associatedImageName {
    _associatedImageName = associatedImageName;
    self.favouritePhoto = nil;
}

-(void) setFavouritePhoto:(FavouritePhoto *)favouritePhoto {
    _favouritePhoto = favouritePhoto;
}

-(UIImage*) image {
    if(self.associatedImageName) {
        return [UIImage imageNamed: self.associatedImageName];
    }
    else if (self.favouritePhoto) {
        return self.favouritePhoto.image;
    }

    return nil;
}

-(void) getFullscreenImageWithCompletionBlock: (imageFetchingCompletion) completion {
    if(_associatedImageName) {
        UIImage *fullScreenImage = [UIImage imageNamed: [NSString stringWithFormat:@"%@_fullscreen", _associatedImageName]];
        completion(fullScreenImage);
    }
    else {
        [[LocalPhotosManager sharedManager] fetchFavouriteFullscreenImageWithAssetID:self.favouritePhoto.photoID andCompletion:completion];
    }
}


@end
