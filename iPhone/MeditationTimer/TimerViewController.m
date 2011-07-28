//
//  TimerViewController.m
//  MeditationTimer
//
//  Created by David Clements on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerViewController.h"


@implementation TimerViewController


@synthesize lastCheckpoint, alarmTimes;



- (void)dealloc {
    [super dealloc];
	self.alarmTimes = nil;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	imageView.image = [[AppContext sharedContext] getCurrentImage];
	
	[UIView beginAnimations:@"fade" context:nil];
	[UIView setAnimationDuration:0.33f];
	[UIView setAnimationDelay:4.0f];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	progressView.frame = CGRectMake(0, 480, 320, 480);
	[UIView commitAnimations];
	
	
	secondsLeft = [[AppContext sharedContext] getCurrentDurationSeconds];
	totalDuration = secondsLeft;
	
	self.alarmTimes = [NSMutableArray array];
	
	[self setupTimeLabel];
	
    [self checkpoint];					  
	
	if( [[AppSettings getString:@"type"] isEqual:@"repeating bells"] ){
		[self initializeRepeatingAlarmTimes];
	} else {
		[self initializeGoldenAlarmTimes];
	}
	
	[self recalc];
	
}


- (void) initializeRepeatingAlarmTimes{
	[alarmTimes addObject:[NSNumber numberWithInt:0]];
	
	NSTimeInterval totalNumberOfSecondsToRunAlarm = totalDuration;
	
	NSNumber * finalDate = [NSNumber numberWithInt:(int)totalNumberOfSecondsToRunAlarm];
	
	NSTimeInterval nextSeconds = [[AppContext sharedContext] getSecondaryTimeSeconds];
	
	NSTimeInterval secsLeft = totalNumberOfSecondsToRunAlarm - nextSeconds;
	NSLog(@"Alarm set for a total of %f seconds and a bell will go off at %f seconds and there are %f seconds left",totalNumberOfSecondsToRunAlarm,nextSeconds,secsLeft);
	
	while(secsLeft > 8.0){
		int t = [[alarmTimes lastObject] intValue];
		NSNumber * nextT = [NSNumber numberWithInt:(t + nextSeconds)];
		
		if( [nextT compare:finalDate] == NSOrderedDescending )
			nextT = finalDate; 
		
		[alarmTimes addObject:nextT];
		
		secsLeft = secsLeft - nextSeconds;
		NSLog(@"Alarm set for a total of %f seconds and a bell will go off at %f seconds and there are %f seconds left",totalNumberOfSecondsToRunAlarm,nextSeconds,secsLeft);
	}
	
	NSLog(@" %@ ", alarmTimes);
	
}

- (void) initializeGoldenAlarmTimes{
	
	[alarmTimes addObject:[NSNumber numberWithInt:0]];
	
	NSTimeInterval totalNumberOfSecondsToRunAlarm = totalDuration;
	
	float nextSeconds = totalNumberOfSecondsToRunAlarm * 0.625f;
	float secsLeft = totalNumberOfSecondsToRunAlarm - nextSeconds;
	NSLog(@"Alarm set for a total of %f seconds and a bell will go off at %f seconds and there are %f seconds left",totalNumberOfSecondsToRunAlarm,nextSeconds,secsLeft);
	
	while(nextSeconds > 8.0){
		int t = [[alarmTimes lastObject] intValue];
		NSNumber * nextT = [NSNumber numberWithInt:(t + nextSeconds)];
		[alarmTimes addObject:nextT];
		nextSeconds = secsLeft * 0.625f;
		secsLeft = secsLeft - nextSeconds;
		NSLog(@"Alarm set for a total of %f seconds and a bell will go off at %f seconds and there are %f seconds left",totalNumberOfSecondsToRunAlarm,nextSeconds,secsLeft);
	}
	[alarmTimes removeObjectAtIndex:0];
	NSLog(@" %@ ", alarmTimes);
	
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
			if( alarmTimes.count > 0 ){
				NSNumber * nextAlarm = [alarmTimes objectAtIndex:0];
				
				if( totalAccumulated > [nextAlarm intValue] ){
					[[AppContext sharedContext] playSound]; 
					[self.alarmTimes removeObjectAtIndex:0];
				}
			}
			
			if( totalAccumulated >= totalDuration ){
				[self performSelector:@selector(exitTouched) withObject:nil afterDelay:0];
				return;
			}
			
		}
		
		imageView.alpha = 1.0 - totalAccumulated / totalDuration;
		
		
		NSLog(@"Time accululated %f", totalAccumulated);
		
		[self performSelector:@selector(recalc) withObject:nil afterDelay:1.0];
		[self setupTimeLabel];
	}
}




-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
	if( progressView.frame.origin.y > 400.0f ){
		
		[UIView beginAnimations:@"fade" context:nil];
		[UIView setAnimationDuration:0.33f];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		progressView.frame = CGRectMake(0, 0, 320, 480);
		[UIView commitAnimations];
		
		
	} else {
		[UIView beginAnimations:@"fade" context:nil];
		[UIView setAnimationDuration:0.33f];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		progressView.frame = CGRectMake(0, 480, 320, 480);
		[UIView commitAnimations];	}
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



@end
