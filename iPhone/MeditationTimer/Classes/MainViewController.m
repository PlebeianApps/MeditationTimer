//
//  MainViewController.m
//  MeditationTimer
//
//  Created by David Clements on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "TimerControlViewController.h"
#import "AboutViewController.h"

@implementation MainViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	TimerControlViewController * controller = [[TimerControlViewController alloc] initWithNibName:@"TimerControlViewController" bundle:nil];
	controller.view.center = CGPointMake(160, 230);
	[self.view addSubview:controller.view];
	
	[[AppContext sharedContext] addObserver:self forKeyPath:@"playBackSpeed" options:0 context:nil];
	
	minutes = [AppSettings getInt:@"minutes"];
	[self setupTimeLabel];
}

- (void)observeValueForKeyPath:(NSString*) path ofObject:(id) object change:(NSDictionary*)change context:(void*)context;
{
	minutes += [AppContext sharedContext].playBackSpeed;
	if( minutes < 0 )
		minutes = 0;
	
	[AppSettings storeInt:minutes forKey:@"minutes"];
	
	[AppSettings storeString:[NSString stringWithFormat:@"%i minutes",(int)minutes] forKey:@"duration"];
	
	[self setupTimeLabel];
}

-(void)showAbout;
{
	AboutViewController * controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

-(void)setupTimeLabel;
{
	NSTimeInterval mins = [[AppContext sharedContext] getCurrentDurationSeconds] / 60;
	int hours = (int)mins / 60   ;
	int min = ((int)mins - ( hours * 60 ));
	timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",hours,min];
}

-(void)viewDidAppear:(BOOL)animated;
{
	[super viewDidAppear:animated];
	minutes = [[AppContext sharedContext] getCurrentDurationSeconds] / 60;
	[self setupTimeLabel];
}


-(void)startButtonTouched;
{
	TimerViewController * controller = [[TimerViewController alloc] initWithNibName:@"TimerViewController" bundle:nil];
	[self presentModalViewController:controller animated:NO];
	[controller release];
	
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
