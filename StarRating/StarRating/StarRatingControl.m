//
//  StarRatingControl.m
//  RouteMonitor
//
//  Created by Tom Fewster on 16/03/2012.
//

#import "StarRatingControl.h"
#import "StarView.h"

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
		StarView *v = [[StarView alloc] initWithDefault:_star highlighted:_highlightedStar position:i];
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
	
	NSLog(@"FrameWidth/Height:%0.2f/%0.2f", self.frame.size.width, self.frame.size.height);
	NSLog(@"CellWidth:%0.2f", cellWidth);
	
	[_stars enumerateObjectsUsingBlock:^(StarView *star, NSUInteger idx, BOOL *stop) {
		star.frame = CGRectMake(kStarPadding + idx * cellWidth + idx * kStarPadding, 0, cellWidth, cellWidth);
	}];
}

#pragma mark -
#pragma mark Touch Handling

- (UIButton*)starForPoint:(CGPoint)point {
	for (StarView *star in _stars) {
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
	[self setRating:index];
	return YES;		
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
	[super cancelTrackingWithEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint point = [touch locationInView:self];

	NSUInteger index = [self indexForStarAtPoint:point];
	if (index != NSNotFound) {
		[self setRating:index];
	} else if (point.x < ((UIButton*)[_stars objectAtIndex:0]).frame.origin.x) {
		[self setRating:0];
	}
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[self.delegate starRatingControl:self didUpdateRating:self.rating];
	[super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark -
#pragma mark Rating Property

- (void)setRating:(NSUInteger)rating {
	_currentIdx = rating;
	[_stars enumerateObjectsUsingBlock:^(StarView *star, NSUInteger idx, BOOL *stop) {
		star.highlighted = (idx <= _currentIdx);
	}];
}

- (NSUInteger)rating {
	return (NSUInteger)_currentIdx+1;
}

@end
