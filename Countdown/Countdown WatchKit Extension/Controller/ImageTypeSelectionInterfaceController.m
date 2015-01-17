//
//  ImageTypeSelectionInterfaceController.m
//  Countdown
//
//  Created by Steven on 09/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "ImageTypeSelectionInterfaceController.h"
#import "GalleryType.h"

@implementation ImageTypeSelectionInterfaceController

- (IBAction)defaultImagesButtonClicked
{
	[self presentControllerWithName:@"PickImageInterfaceController" context:@{ @"Type" : @(GT_DEFAULT) }];
}

- (IBAction)favoriteImagesButtonClicked
{
	[self presentControllerWithName:@"PickImageInterfaceController" context:@{ @"Type" : @(GT_FAVORITE) }];
}

@end
