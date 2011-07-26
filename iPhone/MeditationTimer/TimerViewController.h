//
//  TimerViewController.h
//  MeditationTimer
//
//  Created by David Clements on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>

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
	
	NSMutableArray * alarmTimes;
	
	AVAudioPlayer * player;
}

@property(nonatomic,retain) AVAudioPlayer * player;


@property(nonatomic,retain) NSMutableArray * alarmTimes;
@property(nonatomic,retain) NSDate * lastCheckpoint;

-(IBAction)pauseButtonTouched:(UIButton *)pauseButton;
-(IBAction)exitTouched;
-(void)checkpoint;
-(void)setupTimeLabel;
-(void)recalc;

- (void) initializeRepeatingAlarmTimes;
- (void) initializeGoldenAlarmTimes;
-(void)playSound;
@end
