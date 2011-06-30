//
//  ScrubberViewController.m
//  BlipSnipsFacebook
//
//  Created by David Clements on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimerControlViewController.h"


@implementation TimerControlViewController

@synthesize angles;

@synthesize updateSpeedTimer,grabAnglesTimer;
@synthesize lastAngleUpdate, lastSeenAngleUpdate;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	label.text = [NSString stringWithFormat:@"%1.2f",speed];
	self.angles = [NSMutableArray array];
	width = self.view.frame.size.width;
	height = self.view.frame.size.height;
	
	//	NSInvocation *updateSpeedTimerInvocation =
//		[NSInvocation invocationWithMethodSignature:
//		[self methodSignatureForSelector: @selector (updateContextSpeed)]];
//		[updateSpeedTimerInvocation setSelector: @selector (updateContextSpeed)];
//		[updateSpeedTimerInvocation setTarget: self];
//	
//		self.updateSpeedTimer = [NSTimer scheduledTimerWithTimeInterval:0.3f
//															 invocation:updateSpeedTimerInvocation repeats:YES];
	
	NSInvocation *updateAnglesTimerInvocation =
	[NSInvocation invocationWithMethodSignature:
	 [self methodSignatureForSelector: @selector (grabAnglesMethod)]];
	[updateAnglesTimerInvocation setSelector: @selector (grabAnglesMethod)];
	[updateAnglesTimerInvocation setTarget: self];
	
	self.grabAnglesTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
														 invocation:updateAnglesTimerInvocation repeats:YES];
	
	numberOfAngles = 3;
	
}
-(void)updateContextSpeed;
{
	float total = 0;
	for( NSNumber * a in self.angles ){
	   	total += [a floatValue];
	}
	
	speed = total / self.angles.count;
	speed *= 10;
	
	label.text = [NSString stringWithFormat:@"%1.2f", speed];
	
	//DLog(@" speed %1.2f angles %@", speed, self.angles);
	
	[AppContext sharedContext].playBackSpeed = speed;

}

-(void)grabAnglesMethod;
{
	// Convert Angle into speed.....
	moving = lastSeenAngleUpdate != lastAngleUpdate;
	
	if( !moving )
		lastAngle = 0.0; // slow the thing down.
	
	if( moving )
		[self updateContextSpeed];
	
	self.lastSeenAngleUpdate = self.lastAngleUpdate;
	
	[self.angles addObject:[NSNumber numberWithFloat:lastAngle]];
	
	if( self.angles.count > numberOfAngles )
		[self.angles removeObjectAtIndex:0];
	
	
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	CGPoint prevPoint1 = [[[touches allObjects] objectAtIndex:0] previousLocationInView:self.view];
	CGPoint curPoint1 = [[[touches allObjects] objectAtIndex:0] locationInView:self.view];
	
	CGFloat curAngle = [self angleBetweenPoint1:curPoint1 andPoint2:prevPoint1];
	
	if ( curAngle > M_PI / 2 || -1 * curAngle > M_PI /2){
		NSLog(@" too big " );
		return;
	}
	
	lastAngle = curAngle;
	self.lastAngleUpdate = [NSDate date];
			
	float previousAngle = angle;
	
	angle += curAngle;		
	
	if( angle > 2 * M_PI ){
		angle -= ( 2 * M_PI );
	}
	
	
	
	if( angle < 0 ){
		angle = ( 2 * M_PI + angle );
	}
	
	if( previousAngle - angle > 6.0 )
		revolutions ++;
	
	if( angle - previousAngle > 6.0 )
		revolutions --;
	
		
	
	CGAffineTransform newTransform3 = CGAffineTransformRotate(self.view.transform, curAngle);
	
	self.view.transform = newTransform3;
	
	//DLog(@"Current angle %f count %i ",angle, revolutions);
	
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	double radiansPerSection = (((double)M_PI) / 60) * 2.0;
	
	double remainder = (double)angle;
	
	while( remainder > radiansPerSection ){
		remainder -= radiansPerSection;
	    count ++;	
	}
	
	if( remainder > radiansPerSection / 2)
		count ++;
	
	
	
	angle = radiansPerSection * count;
	
	CGAffineTransform newTransform3 = CGAffineTransformMakeRotation(angle);
	
	self.view.transform = newTransform3;
}



- (NSInteger)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
	
	CGFloat deltaX = fabsf(point1.x - point2.x);
	
	CGFloat deltaY = fabsf(point1.y - point2.y);
	
	CGFloat distance = sqrt((deltaY*deltaY)+(deltaX*deltaX));
	
	return distance;
	
}



- (CGFloat)angleBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2

{ 
	
	
	float cx = width / 2.0f;
	float cy = height / 2.0f;
	
	
	float dx = point1.x - cx;
	
	float dy = point1.y - cy;
	
	
	
	double oldangle = atan2(dy,dx);
	
	//DLog(@"p1x %f p1y %f  ", point1.x, point1.y);
	//DLog(@"p2x %f p2y %f  ", point2.x, point2.y);

//	DLog(@"cx %f, cy %f ", cx, cy);
//	DLog(@"dx %f, dy %f ", dx, dy);

	
	dx = point2.x - cx;
	
	dy = point2.y - cy;
	
	double newangle = atan2(dy, dx);

	
	
	return (oldangle - newangle);
	
} 



@end
