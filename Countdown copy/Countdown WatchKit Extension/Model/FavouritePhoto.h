//
//  FavouritePhoto.h
//  Countdown
//
//  Created by Steven on 09/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FavouritePhoto : NSObject

//local identifier of the PHAsset object
@property (nonatomic, strong) NSString *photoID;
@property (nonatomic, strong) UIImage *image;
@end
