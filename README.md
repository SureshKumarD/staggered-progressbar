# StaggeredProgressBar

This is a library for custom progress bar. Where progress is shown as animated staggered/stashed bars.
In your iOS project, you can use this staggered progress bar by integrating our library.

WHY TO USE THIS LIBRARY:

     1. Get rid of the boring native UIProgressbar
     2. Fluid and rich User Interface
     3. Customizable to the great extend
     

HOW TO USE THIS LIBRARY:

    //Progress bar.
    StaggeredProgressBar *progressBar = [[StaggeredProgressBar alloc] 
                                              initWithFrame:(CGRect){0,70,self.view.frame.size.width, 7}];
    [progressBar setStripesColor:[UIColor cyanColor]];
    [progressBar setVelocity:1.5];
    [progressBar setStripesWidth:7];
    
    
    //Add, progress bar into container view.
    [self.view addSubview:progressBar];
    
    
    //Start progressing animation.
    [progressBar startAnimating];
    
At some point you want to stop the progress bar, and remove it from the container.
    
    //Stop progress
    [progressBar stopAnimating];
    [progressBar removeFromSuperView];
    
    
VERSION

    StaggeredProgressBar v1.0
    
SCREENSHOT
   
    ![StaggeredProgressBar](StaggeredProgressBar.png?raw=true "Example StaggeredProgressBar")
    
    
  
LICENSE

    StaggeredProgressBar - An alternate for UIProgressBar
    Copyright 2015 by opensource community.




    
