//
//  StaggeredProgressBar.h
//  StaggeredProgressBar
//
//  Created by Suresh on 11/9/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, SPBarType)
{
    //The progress bar has rounded corners and the gloss effect by default.
    ProgressBarTypeRounded = 0,
    
    //The progress bar has squared corners and no gloss.
    ProgressBarTypeFlat    = 1
};


typedef NS_ENUM (NSUInteger, SPBarBehavior)
{
    // The default behavior of a progress bar. This mode is identical to the
    // UIProgressView.
    SPBarBehaviorDefault       = 0,
    
    //The indeterminate behavior display the stripes when the progress value is
    //equal to 0 only. This mode is helpful when percentage is not yet known,
    //but will be known shortly.
    SPBarBehaviorIndeterminate = 1,
    
    // The waiting behavior display the stripes when the progress value is equal
    // to 1 only.
    SPBarBehaviorWaiting       = 2,
};


@interface StaggeredProgressBar : UIView


@property (nonatomic, assign) IBInspectable NSInteger stripesWidth;
@property (nonatomic, strong) IBInspectable UIColor *stripesColor;
@property (nonatomic, strong) IBInspectable UIColor *trackColor;

//Animation delegate methods.
- (void)startAnimating;
- (void)stopAnimating;

@end
