//
//  StarView.m
//  RouteMonitor
//
//  Created by Tom Fewster on 16/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StarView.h"

@implementation StarView

#pragma mark -
#pragma mark Initialization

- (id)initWithDefault:(UIImage*)star highlighted:(UIImage*)highlightedStar position:(int)index {
	self = [super initWithFrame:CGRectZero];
	if (self) {
		[self setImage:star forState:UIControlStateNormal];
		[self setImage:highlightedStar forState:UIControlStateSelected];
		[self setImage:highlightedStar forState:UIControlStateHighlighted];
		[self setTag:index];
		[self setBackgroundColor:[UIColor clearColor]];
	}
	return self;
}

#pragma mark -
#pragma mark UIView methods

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	return self.superview;
}

@end
