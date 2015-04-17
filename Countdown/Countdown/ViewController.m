//
//  ViewController.m
//  Countdown
//
//  Created by Ross on 21/11/14.
//  Copyright (c) 2014 Umbrella. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *bgView;
@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.bgView.image = [UIImage imageNamed:@"fe"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
