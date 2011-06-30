//
//  MainViewController.m
//  MeditationTimer
//
//  Created by David Clements on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "TimerControlViewController.h"

@implementation MainViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	TimerControlViewController * controller = [[TimerControlViewController alloc] initWithNibName:@"TimerControlViewController" bundle:nil];
	controller.view.center = CGPointMake(160, 180);
	[self.view addSubview:controller.view];
	
	[[AppContext sharedContext] addObserver:self forKeyPath:@"playBackSpeed" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString*) path ofObject:(id) object change:(NSDictionary*)change context:(void*)context;
{
	seconds += [AppContext sharedContext].playBackSpeed * 100;
	if( seconds < 0 )
		seconds = 0;
	
	[self setupTimeLabel];
}

-(void)setupTimeLabel;
{

	int hours = seconds / 60 / 60;
	int minutes = (seconds - ( hours * 60 * 60 )) / 60;
	timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",hours,minutes];
}



- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
