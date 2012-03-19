//
//  TFViewController.h
//  StarRating
//
//  Created by Tom Fewster on 18/03/2012.
//

#import <UIKit/UIKit.h>
#import "StarRatingControl.h"

@interface TFViewController : UIViewController <StarRatingDelegate>

@property (weak) IBOutlet UILabel *ratingLabel;
@property (weak) IBOutlet StarRatingControl *starRatingControl;

@end
