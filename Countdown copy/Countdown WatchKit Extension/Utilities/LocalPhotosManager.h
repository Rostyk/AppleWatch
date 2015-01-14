//
//  LocalPhotosManager.h
//  Countdown
//
//  Created by Steven on 09/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountDown.h"

@class PickImageInterfaceController;

@interface LocalPhotosManager : NSObject
+ (instancetype)sharedManager;
- (void) fetchFavoritePhotos;

- (NSArray *)images;
- (NSArray *)assets;

-(void) fetchFavouriteFullscreenImageWithAssetID:(NSString*) assetId andCompletion:(imageFetchingCompletion) completion;
@property (nonatomic, assign) PickImageInterfaceController *controller;

@end
