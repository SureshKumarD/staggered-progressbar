//
//  StaggeredProgressBar.m
//  StaggeredProgressBar
//
//  Created by Suresh on 11/9/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

#import "StaggeredProgressBar.h"

//CONSTANT : animation interval in seconds.
const NSTimeInterval animationTimeInterval = 0.3f/30.0f;

@interface StaggeredProgressBar()

@property (nonatomic, assign) CGFloat internalCornerRadius;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, getter = isStripesAnimated) IBInspectable BOOL stripesAnimated;
@property (nonatomic, assign) IBInspectable BOOL hideStripes;
@property (nonatomic, assign) double stripesOffset;

@property (nonatomic, assign) IBInspectable double stripesAnimationVelocity;
@property (nonatomic, assign) IBInspectable ProgressBarType progressBarType;

@property (nonatomic, strong) NSArray *colors;
@property (atomic, assign) IBInspectable CGFloat progress;
@property (nonatomic, assign) IBInspectable BOOL progressStretch;
@property (nonatomic, assign) IBInspectable ProgressBarBehavior progressBarBehavior;
@property (nonatomic, assign) IBInspectable BOOL uniformTintColor;
@property (nonatomic, strong, nonnull) NSArray *progressTintColors;
@property (nonatomic, strong, nonnull) IBInspectable UIColor *progressTintColor;
@property (nonatomic, strong, nonnull) IBInspectable UIColor *trackTintColor;
@property (nonatomic, assign) IBInspectable CGFloat progressBarInset;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@end

@implementation StaggeredProgressBar

@synthesize progress = _progress;


- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self allocateOrInitializeObjects];
    }
    return self;
}

- (void)allocateOrInitializeObjects
{
    _stripesOffset                = 0;
    _stripesWidth                 = 10;
    _stripesColor                 = [UIColor blueColor];
    _stripesAnimationVelocity     = 1;
    _stripesAnimated              = YES;
    _hideStripes                  = NO;
    
    _progressBarType              = ProgressBarTypeRounded;
    _progressStretch              = YES;
    _progress                     = 1.0f;
    _progressBarBehavior          = ProgressBarBehaviorDefault;
    _cornerRadius                 = 0;
    
    self.backgroundColor          = [UIColor blackColor];
    
    
}

#pragma mark - Drawing & Animation methods

//Animate progress.

//Getter : Progress with thread safety.
- (CGFloat)progress
{
    @synchronized (self)
    {
        return _progress;
    }
}

//Setter : Progress.
- (void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}

//Setter : Progress with animation.
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    @synchronized (self)
    {
        CGFloat newProgress = progress;
        if (newProgress > 1.0f)
        {
            newProgress = 1.0f;
        } else if (newProgress < 0.0f)
        {
            newProgress = 0.0f;
        }
        
        _progress = newProgress;
        
        [self setNeedsDisplay];
        
    }
}


//Setter : Behavior.
- (void)setBehavior:(BOOL)behavior
{
    _progressBarBehavior = behavior;
    
    [self setNeedsDisplay];
}

//Drawing method, get called on each setNeedsDisplay.
- (void)drawRect:(CGRect)rect
{
    if (self.isHidden)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Refresh the corner radius value
    self.internalCornerRadius = 0;
    
    if (_progressBarType == ProgressBarTypeRounded) {
        if (_cornerRadius > 0) {
            self.internalCornerRadius = _cornerRadius;
        }
        else {
            self.internalCornerRadius = rect.size.height / 2;
        }
    }
    
    // Compute the progressOffset for the stripe's animation
    self.stripesOffset = (!self.stripesAnimated || fabs(self.stripesOffset) > 2 * _stripesWidth - 1) ? 0 : 1 * fabs(self.stripesAnimationVelocity) + self.stripesOffset;
    
    // Compute the inner rectangle
    CGRect innerRect;
    if (_progressBarType == ProgressBarTypeRounded)
    {
        innerRect = CGRectMake(_progressBarInset,
                               _progressBarInset,
                               CGRectGetWidth(rect) * self.progress - 2 * _progressBarInset,
                               CGRectGetHeight(rect) - 2 * _progressBarInset);
    } else
    {
        innerRect = CGRectMake(0, 0, CGRectGetWidth(rect) * self.progress, CGRectGetHeight(rect));
    }
    
    if (self.progress == 0 && _progressBarBehavior == ProgressBarBehaviorIndeterminate)
    {
        [self drawStripes:context withRect:rect];
    } else if (self.progress > 0)
    {
        if (_stripesWidth > 0 && !self.hideStripes)
        {
            if (_progressBarBehavior == ProgressBarBehaviorWaiting)
            {
                if (self.progress == 1.0f)
                {
                    [self drawStripes:context withRect:innerRect];
                }
            } else if (_progressBarBehavior != ProgressBarBehaviorIndeterminate)
            {
                [self drawStripes:context withRect:innerRect];
            }
        }
        
    }
    
}



//Calculate offset point to draw stripes.
- (void)drawStripes:(CGContextRef)context withRect:(CGRect)rect
{
    if (_stripesWidth == 0) {
        return;
    }
    
    CGContextSaveGState(context);
    {
        UIBezierPath *allStripes = [UIBezierPath bezierPath];
        
        //Get start and end range for no. of stripes.
        NSInteger start = -_stripesWidth;
        NSInteger end   = rect.size.width / (2 * _stripesWidth) + (2 * _stripesWidth);
        CGFloat yOffset = (_progressBarType == ProgressBarTypeRounded) ? _progressBarInset : 0;
        
        for (NSInteger i = start; i <= end; i++)
        {
            
            UIBezierPath *stripe = [self stripeWithOrigin:CGPointMake(i * 2 * _stripesWidth + _stripesOffset, yOffset) bounds:rect];
            [allStripes appendPath:stripe];
            
            
        }
        
        //Clip the progress frame
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:_internalCornerRadius];
        
        CGContextAddPath(context, [clipPath CGPath]);
        CGContextClip(context);
        
        CGContextSaveGState(context);
        {
            // Clip the stripes
            CGContextAddPath(context, [allStripes CGPath]);
            CGContextClip(context);
            
            CGContextSetFillColorWithColor(context, [_stripesColor CGColor]);
            CGContextFillRect(context, rect);
        }
        CGContextRestoreGState(context);
    }
    CGContextRestoreGState(context);
}


//Draw stripe with point.
- (UIBezierPath *)stripeWithOrigin:(CGPoint)origin bounds:(CGRect)frame {
    CGFloat height     = CGRectGetHeight(frame);
    UIBezierPath *bezPath = [UIBezierPath bezierPath];
    
    [bezPath moveToPoint:origin];
    [bezPath addLineToPoint:CGPointMake(origin.x - _stripesWidth, origin.y)];
    [bezPath addLineToPoint:CGPointMake(origin.x - _stripesWidth, origin.y + height)];
    [bezPath addLineToPoint:CGPointMake(origin.x, origin.y + height)];
    [bezPath addLineToPoint:origin];
    [bezPath closePath];
    
    return bezPath;
}


#pragma mark - Animation delegate methods.

- (void)startAnimating {
    
    if (_timer == nil)
    {
        _timer = [NSTimer timerWithTimeInterval:animationTimeInterval
                                         target:self
                                       selector:@selector(setNeedsDisplay)
                                       userInfo:nil
                                        repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

- (void)stopAnimating {
    [self.timer invalidate];
    self.timer        = nil;
    self.stripesColor = nil;
}


#pragma mark -
- (void)dealloc {
    
    [self stopAnimating];
}


@end
