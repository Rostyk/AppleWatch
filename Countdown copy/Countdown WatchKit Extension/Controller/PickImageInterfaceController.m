//
//  PickImageInterfaceController.m
//  Countdown
//
//  Created by Steven on 03/12/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "PickImageInterfaceController.h"
#import "ImageButton.h"
#import "App.h"
#import "Gallery.h"
#import "WKInterfaceButton+Tag.h"
#import "CountDown.h"
#import "CountdownsManager.h"
#import "GalleryType.h"
#import "LocalPhotosManager.h"
#import "FavouritePhoto.h"
#import <Photos/Photos.h>

@interface PickImageInterfaceController()

@property (nonatomic) GalleryType galleryType;
@property (nonatomic, strong) NSArray *buttons;
//I know its crazy! Since we have no Outletcolelction in this release of WatchKit, lets just out it this ugly way
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button1;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button2;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button3;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button4;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button5;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button6;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button7;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button8;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button9;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button10;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button11;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button12;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button13;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button14;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button15;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button16;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button17;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button18;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button19;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button20;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button21;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button22;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button23;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button24;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button25;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button26;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button27;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button28;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button29;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button30;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button31;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button32;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button33;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button34;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button35;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button36;
@end

@implementation PickImageInterfaceController
#pragma mark lifecycle
- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        self.galleryType = [context[@"Type"] intValue];
    }
    return self;
}

#pragma mark fetching images
- (void)fetchImages {
    [LocalPhotosManager sharedManager].controller = self;
    [[LocalPhotosManager sharedManager] fetchFavoritePhotos];
}


#pragma mark configuring items
- (void)configureImageButtons {
    int i = 0;
    for (WKInterfaceButton *button in self.buttons) {
        NSString *imageName = [[App sharedApp].gallery imageForRow:i];
        NSLog(@"imageName: %@", imageName);
        CGFloat size = [[WKInterfaceDevice currentDevice] screenBounds].size.width /3.1;
        [button setWidth:size];
        [button setHeight:size];
        [button setTag:i];
        [button setBackgroundImageNamed:imageName];
        NSLog(@"Image index: %i", i);
        i++;
    }
}

- (void)configureFavoriteImageButtons {
    NSArray *images = [[LocalPhotosManager sharedManager] images];
    int i = 0;
    for(WKInterfaceButton *button in self.buttons) {
        if(images.count > i) {
            UIImage *bgImage = images[i];
            [button setBackgroundImage: bgImage];
            CGFloat size = [[WKInterfaceDevice currentDevice] screenBounds].size.width /3.1;
            [button setWidth: size];
            [button setHeight: size];
            [button setTag: i];
            [button setHidden: NO];
        }
        else {
            [button setHidden: YES];
        }

        i++;
    }
}

- (void)willActivate {
    if(self.galleryType == GT_FAVORITE) {
        [self fetchImages];
    }
    if(self.galleryType == GT_DEFAULT) {
        [self configureImageButtons];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

#pragma mark accessing buttons
-(NSArray*) buttons{
    if(!_buttons) {
        _buttons = @[self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.button16, self.button17, self.button18, self.button19, self.button20, self.button21, self.button22, self.button23, self.button24, self.button25, self.button26, self.button27, self.button28, self.button29, self.button30, self.button31, self.button32, self.button33, self.button34, self.button35, self.button36];
    }
    return _buttons;
}

// IB action doesn't support the sender object
#pragma mark image selection
-(IBAction) imageButton1Clicked { [self buttonClicked: self.button1]; }
-(IBAction) imageButton2Clicked { [self buttonClicked: self.button2]; }
-(IBAction) imageButton3Clicked { [self buttonClicked: self.button3]; }
-(IBAction) imageButton4Clicked { [self buttonClicked: self.button4]; }
-(IBAction) imageButton5Clicked { [self buttonClicked: self.button5]; }
-(IBAction) imageButton6Clicked { [self buttonClicked: self.button6]; }
-(IBAction) imageButton7Clicked { [self buttonClicked: self.button7]; }
-(IBAction) imageButton8Clicked { [self buttonClicked: self.button8]; }
-(IBAction) imageButton9Clicked { [self buttonClicked: self.button9]; }
-(IBAction) imageButton10Clicked { [self buttonClicked: self.button10]; }
-(IBAction) imageButton11Clicked { [self buttonClicked: self.button11]; }
-(IBAction) imageButton12Clicked { [self buttonClicked: self.button12]; }
-(IBAction) imageButton13Clicked { [self buttonClicked: self.button13]; }
-(IBAction) imageButton14Clicked { [self buttonClicked: self.button14]; }
-(IBAction) imageButton15Clicked { [self buttonClicked: self.button15]; }
-(IBAction) imageButton16Clicked { [self buttonClicked: self.button16]; }
-(IBAction) imageButton17Clicked { [self buttonClicked: self.button17]; }
-(IBAction) imageButton18Clicked { [self buttonClicked: self.button18]; }
-(IBAction) imageButton19Clicked { [self buttonClicked: self.button19]; }
-(IBAction) imageButton20Clicked { [self buttonClicked: self.button20]; }
-(IBAction) imageButton21Clicked { [self buttonClicked: self.button21]; }
-(IBAction) imageButton22Clicked { [self buttonClicked: self.button22]; }
-(IBAction) imageButton23Clicked { [self buttonClicked: self.button23]; }
-(IBAction) imageButton24Clicked { [self buttonClicked: self.button24]; }
-(IBAction) imageButton25Clicked { [self buttonClicked: self.button25]; }
-(IBAction) imageButton26Clicked { [self buttonClicked: self.button26]; }
-(IBAction) imageButton27Clicked { [self buttonClicked: self.button27]; }
-(IBAction) imageButton28Clicked { [self buttonClicked: self.button28]; }
-(IBAction) imageButton29Clicked { [self buttonClicked: self.button29]; }
-(IBAction) imageButton30Clicked { [self buttonClicked: self.button30]; }
-(IBAction) imageButton31Clicked { [self buttonClicked: self.button31]; }
-(IBAction) imageButton32Clicked { [self buttonClicked: self.button32]; }
-(IBAction) imageButton33Clicked { [self buttonClicked: self.button33]; }
-(IBAction) imageButton34Clicked { [self buttonClicked: self.button34]; }
-(IBAction) imageButton35Clicked { [self buttonClicked: self.button35]; }
-(IBAction) imageButton36Clicked { [self buttonClicked: self.button36]; }

-(void) buttonClicked: (WKInterfaceButton*) button {

    CountDown *countDown = (self.controllerMode == CM_CREATE) ?[[CountdownsManager sharedManager] newlyAddedCountDown] : [CountdownsManager sharedManager].editedCountdown;
    NSUInteger tag = [self.buttons indexOfObject: button];
    
    if(self.galleryType == GT_DEFAULT) {
        countDown.associatedImageName = [[App sharedApp].gallery imageForRow: tag];
    }

    if(self.galleryType == GT_FAVORITE) {
        FavouritePhoto *photo = [[FavouritePhoto alloc] init];

        NSArray *images = [[LocalPhotosManager sharedManager] images];
        NSArray *assets = [[LocalPhotosManager sharedManager] assets];
        photo.image = images[tag];
        photo.photoID = ((PHAsset*)assets[tag]).localIdentifier;

        [countDown setFavouritePhoto: photo];
    }

    [[App sharedApp].controllerToPresentOn dismissController];
}

-(void) reloadData {
    [LocalPhotosManager sharedManager].controller = nil;
    if(self.galleryType == GT_FAVORITE) {
        [self configureFavoriteImageButtons];
    }
    if(self.galleryType == GT_DEFAULT) {
        [self configureImageButtons];
    }
}
@end
