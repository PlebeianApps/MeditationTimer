//
//  MainViewController.h
//  MeditationTimer
//
//  Created by David Clements on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	
	NSTimeInterval  seconds;
	IBOutlet UILabel * timeLabel;
}

- (IBAction)showInfo:(id)sender;

@end
