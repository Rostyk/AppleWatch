//
//  LocalPhotosManager.h
//  Countdown
//
//  Created by Steven on 09/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickImageInterfaceController.h"

@interface LocalPhotosManager : NSObject
+ (instancetype)sharedManager;
-(void) fetchFavoritePhotos;

-(NSArray*) images;
-(NSArray*) assets;

@property (nonatomic, assign) PickImageInterfaceController *controller;
@end
