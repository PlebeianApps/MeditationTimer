//
//  ScrubberViewController.h
//  BlipSnipsFacebook
//
//  Created by David Clements on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TimerControlViewController : UIViewController {
	double angle;
	int revolutions;
	
	IBOutlet UILabel * label;
	
	int count;
	float speed;
	
	NSMutableArray * angles;
	
	CGFloat width;
	CGFloat height;
	
	NSTimer * updateSpeedTimer;
	NSTimer * grabAnglesTimer;
	NSDate * lastAngleUpdate;
	NSDate * lastSeenAngleUpdate;

	double lastAngle;
	int numberOfAngles;
	
	BOOL moving;

}

@property(nonatomic,retain) NSDate * lastAngleUpdate;
@property(nonatomic,retain) NSDate * lastSeenAngleUpdate;


@property(nonatomic,retain) NSMutableArray * angles;

@property(nonatomic,retain) NSTimer * updateSpeedTimer;
@property(nonatomic,retain) NSTimer * grabAnglesTimer;



- (CGFloat)angleBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;
- (NSInteger)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;

@end
