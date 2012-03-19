//
//  TFViewController.m
//  StarRating
//
//  Created by Tom Fewster on 18/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFViewController.h"

@interface TFViewController ()
@property (strong) NSArray *ratingLabels;

@end

@implementation TFViewController

@synthesize ratingLabel = _ratingLabel;
@synthesize ratingLabels = _ratingLabels;
@synthesize starRatingControl = _starRatingControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
	_ratingLabels = [NSArray arrayWithObjects:@"Unrated", @"Hate it", @"Don't like it", @"It's OK", @"It's good", @"It's great", nil];
	
	_starRatingControl.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)starRatingControl:(StarRatingControl *)control didUpdateRating:(NSUInteger)rating {
	_ratingLabel.text = [_ratingLabels objectAtIndex:rating];
}

- (void)starRatingControl:(StarRatingControl *)control willUpdateRating:(NSUInteger)rating {
	_ratingLabel.text = [_ratingLabels objectAtIndex:rating];
}

@end
