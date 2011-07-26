//
//  MainViewController.h
//  MeditationTimer
//
//  Created by David Clements on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import "TimerViewController.h"
@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	
	NSTimeInterval  minutes;
	IBOutlet UILabel * timeLabel;
}

-(void)setupTimeLabel;

- (IBAction)showInfo:(id)sender;
-(IBAction)showAbout;
-(IBAction)startButtonTouched;
@end
