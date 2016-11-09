//
//  ViewController.m
//  StaggeredProgressBar
//
//  Created by Suresh on 11/9/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addPlainProgressBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ProgressBar Creation Methods

- (void)addPlainProgressBar {
    
}

@end
