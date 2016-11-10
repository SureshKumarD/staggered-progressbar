# StaggeredProgressBar

This is a library for custom progress bar. Where progress is shown as animated staggered/stashed bars.
In your iOS project, you can use this staggered progress bar, 
If you don't want to use the regular UIProgressbar.

Why to use this library:
   
     1. Get rid of the boring native UIProgressbar
     2. Fluid and rich User Interface
     3. Customizable to the great extend
     

How to use this library:

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
    
    
Latest Version  - StaggeredProgressBar 1.0
    
  
  
StaggeredProgressBar - An alternate for UIProgressBar

Copyright 2015 by the contributors.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 1.0 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

Leanote IOS is licensed under the GPL v2.
    
