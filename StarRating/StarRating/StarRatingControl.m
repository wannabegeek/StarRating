//
//  StarRatingControl.m
//  RouteMonitor
//
//  Created by Tom Fewster on 16/03/2012.
//

#import "StarRatingControl.h"

#define kDefaultNumberOfStars 5
#define kStarPadding 5.0f


@interface StarRatingControl ()
@property (assign) int numberOfStars;
@property (assign) int currentIdx;
//@property (strong) UIImage *star;
//@property (strong) UIImage *highlightedStar;

@property (strong) NSArray *stars;
@end

@implementation StarRatingControl

@synthesize star = _star;
@synthesize highlightedStar = _highlightedStar;

@synthesize delegate;
@synthesize numberOfStars = _numberOfStars;
@synthesize currentIdx = _currentIdx;

@synthesize stars = _stars;

#pragma mark -
#pragma mark Initialization

- (void)setupView {
	self.clipsToBounds = YES;
	_currentIdx = -1;
	_star = [UIImage imageNamed:@"star.png"];
	_highlightedStar = [UIImage imageNamed:@"star_highlighted.png"];
	NSMutableArray *s = [NSMutableArray arrayWithCapacity:_numberOfStars];
	for (int i=0; i<_numberOfStars; i++) {
		UIImageView *v = [[UIImageView alloc] initWithImage:_star highlightedImage:_highlightedStar];
		[self addSubview:v];
		[s addObject:v];
	}
	_stars = [s copy];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
		_numberOfStars = kDefaultNumberOfStars;
		[self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_numberOfStars = kDefaultNumberOfStars;
		[self setupView];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame andStars:(NSUInteger)numberOfStars {
	self = [super initWithFrame:frame];
	if (self) {
		_numberOfStars = numberOfStars;
		[self setupView];
	}
	return self;
}

- (void)layoutSubviews {
	CGFloat width = (self.frame.size.width - (kStarPadding * (_numberOfStars + 1))) / _numberOfStars;
	CGFloat cellWidth = MIN(self.frame.size.height, width);

	// We need to align the starts in the center of the view
	CGFloat padding = (self.frame.size.width - (cellWidth * _numberOfStars + (kStarPadding * (_numberOfStars + 1)))) / 2.0f;
	
	[_stars enumerateObjectsUsingBlock:^(UIImageView *star, NSUInteger idx, BOOL *stop) {
		star.frame = CGRectMake(padding + kStarPadding + idx * cellWidth + idx * kStarPadding, 0, cellWidth, cellWidth);
	}];
}

#pragma mark -
#pragma mark Touch Handling

- (UIImageView*)starForPoint:(CGPoint)point {
	for (UIImageView *star in _stars) {
		if (CGRectContainsPoint(star.frame, point)) {
			return star;
		}
	}

	return nil;
}

- (NSUInteger)indexForStarAtPoint:(CGPoint)point {
	return [_stars indexOfObject:[self starForPoint:point]];
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint point = [touch locationInView:self];	
	NSUInteger index = [self indexForStarAtPoint:point];
	if (index != NSNotFound) {
		[self setRating:index+1];
		if ([self.delegate respondsToSelector:@selector(starRatingControl:willUpdateRating:)]) {
			[self.delegate starRatingControl:self willUpdateRating:self.rating];
		}
	} else if (point.x < ((UIImageView *)[_stars objectAtIndex:0]).frame.origin.x) {
		[self setRating:0];
		if ([self.delegate respondsToSelector:@selector(starRatingControl:willUpdateRating:)]) {
			[self.delegate starRatingControl:self willUpdateRating:self.rating];
		}
	}

	return YES;		
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
	[super cancelTrackingWithEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint point = [touch locationInView:self];

	NSUInteger index = [self indexForStarAtPoint:point];
	if (index != NSNotFound) {
		[self setRating:index + 1];
		if ([self.delegate respondsToSelector:@selector(starRatingControl:willUpdateRating:)]) {
			[self.delegate starRatingControl:self willUpdateRating:self.rating];
		}
	} else if (point.x < ((UIImageView*)[_stars objectAtIndex:0]).frame.origin.x) {
		[self setRating:0];
		if ([self.delegate respondsToSelector:@selector(starRatingControl:willUpdateRating:)]) {
			[self.delegate starRatingControl:self willUpdateRating:self.rating];
		}
	}
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	if ([self.delegate respondsToSelector:@selector(starRatingControl:didUpdateRating:)]) {
		[self.delegate starRatingControl:self didUpdateRating:self.rating];
	}
	[super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark -
#pragma mark Rating Property

- (void)setRating:(NSUInteger)rating {
	_currentIdx = rating;
	[_stars enumerateObjectsUsingBlock:^(UIImageView *star, NSUInteger idx, BOOL *stop) {
		star.highlighted = (idx < _currentIdx);
	}];
}

- (NSUInteger)rating {
	return (NSUInteger)_currentIdx;
}

@end
