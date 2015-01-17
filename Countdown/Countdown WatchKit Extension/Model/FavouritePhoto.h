//
//  FavouritePhoto.h
//  Countdown
//
//  Created by Ross on 1/17/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FavouritePhoto : NSManagedObject

@property (nonatomic, retain) NSString * photoID;
@property (nonatomic, retain) id image;

@end
