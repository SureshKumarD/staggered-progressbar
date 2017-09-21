//
//  ViewController.m
//  StaggeredProgressBar
//
//  Created by Suresh on 11/9/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

#import "ViewController.h"
#import "StaggeredProgressBar.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet StaggeredProgressBar *staggeredProgressBar1;
@property (weak, nonatomic) IBOutlet StaggeredProgressBar *staggeredProgressBar2;
@property (weak, nonatomic) IBOutlet StaggeredProgressBar *staggeredProgressBar3;
@property (weak, nonatomic) IBOutlet StaggeredProgressBar *staggeredProgressBar4;
@property (weak, nonatomic) IBOutlet StaggeredProgressBar *staggeredProgressBar5;
@property (weak, nonatomic) IBOutlet StaggeredProgressBar *staggeredProgressBar6;
@property (weak, nonatomic) IBOutlet StaggeredProgressBar *staggeredProgressBar7;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addProgressBars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ProgressBar Creation Methods

- (void)addProgressBars {
    [self.staggeredProgressBar1 startAnimating];
    [self.staggeredProgressBar2 startAnimating];
    [self.staggeredProgressBar3 startAnimating];
    [self.staggeredProgressBar4 startAnimating];
    [self.staggeredProgressBar5 startAnimating];
    [self.staggeredProgressBar6 startAnimating];
    [self.staggeredProgressBar7 startAnimating];
    
    
    [self addStaggeredProgressBarByCode];
}


- (void)addStaggeredProgressBarByCode {
    
    //Caption label.
    UILabel *captionLabel = [[UILabel alloc] initWithFrame:(CGRect){10, 25, 300, 21}];
    [captionLabel setText:@"This progress bar added by code."];
    
    //Progress bar.
    StaggeredProgressBar *progressBar = [[StaggeredProgressBar alloc] initWithFrame:(CGRect){0,70,self.view.frame.size.width, 7}];
    [progressBar setStripesColor:[UIColor cyanColor]];
    [progressBar setVelocity:1.5];
    [progressBar setStripesWidth:7];
    
    
    //Add, created caption label, progress bar into container view.
    [self.containerView addSubview:captionLabel];
    [self.containerView addSubview:progressBar];
    
    
    //Start progressing animation.
    [progressBar startAnimating];
    
    
    
}

@end
