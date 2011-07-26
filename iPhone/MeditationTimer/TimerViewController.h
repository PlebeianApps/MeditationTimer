//
//  TimerViewController.h
//  MeditationTimer
//
//  Created by David Clements on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TimerViewController : UIViewController {

	IBOutlet UILabel * timeLeft;
	IBOutlet UIView * progressView;
	IBOutlet UIImageView * imageView;
	
	int secondsLeft;
	
	int totalDuration;
	BOOL pausing;
	NSDate * startDate;
}

@property(nonatomic,retain) NSDate * startDate;

-(IBAction)pauseButtonTouched;
-(IBAction)exitTouched;

@end
