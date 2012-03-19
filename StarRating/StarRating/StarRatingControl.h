//
//  StarRatingControl.h
//  RouteMonitor
//
//  Created by Tom Fewster on 16/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarRatingDelegate;

@interface StarRatingControl : UIControl

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame andStars:(NSUInteger)_numberOfStars;

@property (strong) UIImage *star;
@property (strong) UIImage *highlightedStar;
@property (assign) NSUInteger rating;
@property (weak) IBOutlet id<StarRatingDelegate> delegate;

@end

@protocol StarRatingDelegate

- (void)starRatingControl:(StarRatingControl *)control didUpdateRating:(NSUInteger)rating;

@end
