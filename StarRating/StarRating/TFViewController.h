//
//  TFViewController.h
//  StarRating
//
//  Created by Tom Fewster on 18/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRatingControl.h"

@interface TFViewController : UIViewController <StarRatingDelegate>

@property (weak) IBOutlet UILabel *ratingLabel;
@property (weak) IBOutlet StarRatingControl *starRatingControl;

@end
