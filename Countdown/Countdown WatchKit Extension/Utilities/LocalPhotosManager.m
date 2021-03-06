//
//  LocalPhotosManager.m
//  Countdown
//
//  Created by Steven on 09/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "LocalPhotosManager.h"
#import <Photos/Photos.h>
#import <WatchKit/WatchKit.h>
#import "PickImageInterfaceController.h"
#define GALLERY_IMAEG_SIZE 52

@interface LocalPhotosManager ()
@property (nonatomic, strong) PHImageManager *imageManager;
@property (nonatomic, strong) NSMutableArray *favoriteImages;
@property (nonatomic, strong) NSMutableArray *favoriteAssets;
@end

@implementation LocalPhotosManager

+ (instancetype)sharedManager
{
	static dispatch_once_t once;
	static LocalPhotosManager *sharedInstance;

	dispatch_once(&once, ^
	{
		sharedInstance = [self new];
		sharedInstance.imageManager = [[PHImageManager alloc] init];
	});

	return sharedInstance;
}

#pragma mark fetching favorite images
- (void)fetchFavoritePhotos
{
	[self clearImages];

	PHFetchOptions *favouriteOptions = [PHFetchOptions new];
	favouriteOptions.predicate = [NSPredicate predicateWithFormat:@"favorite == YES"];
	PHFetchResult *allPhotosResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:favouriteOptions];

	__weak __typeof__(self) weakSelf = self;
	__block int count = 0;
	[allPhotosResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
		 [weakSelf.favoriteAssets addObject:asset];
		 CGFloat scale = [WKInterfaceDevice currentDevice].screenScale;
		 [weakSelf.imageManager requestImageForAsset:asset targetSize:CGSizeMake(GALLERY_IMAEG_SIZE * scale, GALLERY_IMAEG_SIZE * scale) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
			  [weakSelf.favoriteImages addObject:result];

			  if (idx == (allPhotosResult.count - 1))
			  {
				  count++;
				  if (count == 2)
				  {
					  [weakSelf.controller reloadData];
					  weakSelf.controller = nil;
				  }
				  else
				  {
					  [weakSelf clearImages];
				  }
			  }
		  }];
	 }];
}

#pragma mark fetch fulscreen favourite image
- (void)fetchFavouriteFullscreenImageWithAssetID:(NSString *)assetId andCompletion:(imageFetchingCompletion)completion
{
	__weak __typeof__(self) weakSelf = self;

	PHAsset *fullscreenAsset = nil;
	for (PHAsset *asset in self.assets)
	{
		if ([asset.localIdentifier isEqualToString:assetId])
		{
			fullscreenAsset = asset; break;
		}
	}
	__block int count = 0;
	CGFloat scale = [WKInterfaceDevice currentDevice].screenScale;
	CGFloat width = [WKInterfaceDevice currentDevice].screenBounds.size.width;
	CGFloat height = [WKInterfaceDevice currentDevice].screenBounds.size.height;
	if (fullscreenAsset)
	{
		[weakSelf.imageManager requestImageForAsset:fullscreenAsset targetSize:CGSizeMake(width * scale, height * scale) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
			 count++;
			 if (count == 2)
			 {
				 completion(result);
			 }
		 }];
	}
}

#pragma mark favorite images accessor
- (NSMutableArray *)favoriteImages
{
	if (!_favoriteImages)
	{
		_favoriteImages = [[NSMutableArray alloc] init];
	}

	return _favoriteImages;
}

- (NSArray *)images
{
	return _favoriteImages;
}

#pragma mark favorite assetd accessor
- (NSMutableArray *)favoriteAssets
{
	if (!_favoriteAssets)
	{
		_favoriteAssets = [[NSMutableArray alloc] init];
	}

	return _favoriteAssets;
}

- (NSArray *)assets
{
	return _favoriteAssets;
}

#pragma mark clearing images
- (void)clearImages
{
	[_favoriteImages removeAllObjects];
}

@end
