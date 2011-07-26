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
	
	NSTimeInterval secondsLeft;
	
	NSTimeInterval totalDuration;
	NSTimeInterval totalAccumulated;
	
	NSDate * lastCheckpoint;
	NSTimeInterval totalAtLastCheckpoint;
	
	BOOL pausing;
}

@property(nonatomic,retain) NSDate * lastCheckpoint;

-(IBAction)pauseButtonTouched:(UIButton *)pauseButton;
-(IBAction)exitTouched;
-(void)checkpoint;
-(void)setupTimeLabel;
-(void)recalc;

@end
