//
//  TimerViewController.m
//  MeditationTimer
//
//  Created by David Clements on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerViewController.h"


@implementation TimerViewController


@synthesize lastCheckpoint;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	imageView.image = [[AppContext sharedContext] getCurrentImage];
	
	[UIView beginAnimations:@"fade" context:nil];
	[UIView setAnimationDuration:[[AppContext sharedContext] getCurrentDurationSeconds]];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	imageView.alpha = 0.0f;
	[UIView commitAnimations];
	
	secondsLeft = [[AppContext sharedContext] getCurrentDurationSeconds];
	totalDuration = secondsLeft;
	
	[self setupTimeLabel];
	
    [self checkpoint];					  
	[self recalc];
}

-(void)checkpoint;
{
	@synchronized(self){
		totalAtLastCheckpoint = totalAccumulated;
		self.lastCheckpoint = [NSDate date];
	}
}

-(void)recalc;
{
	@synchronized(self){
	if( !pausing ){
		
		NSTimeInterval timeSinceLastCheckPoint = [lastCheckpoint timeIntervalSinceNow];
		totalAccumulated = totalAtLastCheckpoint + fabs(timeSinceLastCheckPoint);
	}
		progressView.alpha = 1.0 - totalAccumulated / totalDuration;

		
		NSLog(@"Time accululated %f", totalAccumulated);
	
	[self performSelector:@selector(recalc) withObject:nil afterDelay:1.0];
	[self setupTimeLabel];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
	if( progressView.alpha < 1.0f ){
		progressView.alpha = YES;	
	} else {
		progressView.alpha = NO;	
	}
}

-(void)setupTimeLabel;
{
	
	secondsLeft = totalDuration - totalAccumulated;
	
	int minutes = secondsLeft / 60;
	int hours = minutes / 60   ;
	int min = (minutes - ( hours * 60 ));
	int secs = (int)secondsLeft % 60;
	
	if( hours == 0 ){
		hours = min;
	    min = secs;	
	} 

	
	
	timeLeft.text = [NSString stringWithFormat:@"%02d:%02d",hours,min];
}

-(void)pauseButtonTouched:(UIButton *)pauseButton;
{
	//reset duration
	pausing = !pausing;
	pauseButton.selected = !pauseButton.selected;
	
	if( pausing ){
		
	} else {
		[self checkpoint];
	}
}

-(void)exitTouched;
{
	[self dismissModalViewControllerAnimated:NO];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
