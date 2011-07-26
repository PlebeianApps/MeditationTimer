/**
 * Copyright (c) 2009 Alex Fajkowski, Apparent Logic LLC
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
#import "AFOpenFlowViewController.h"
#import "UIImageExtras.h"
#import "AFGetImageOperation.h"


@implementation AFOpenFlowViewController


//#error Change theses values to your Flickr API key & secret


- (void)dealloc {
	[loadImagesOperationQueue release];
	[interestingPhotosDictionary release];
	
    [super dealloc];
}



- (IBAction)infoButtonPressed:(id)sender {
	NSString *alertString;

		alertString = @"Sample images included in this project are all in the public domain, courtesy of NASA.";
	UIAlertView *infoAlertPanel = [[UIAlertView alloc] initWithTitle:@"OpenFlow Demo App" 
															 message:[NSString stringWithFormat:@"%@\n\nFor more info about the OpenFlow API, visit apparentlogic.com.", alertString]
															delegate:nil 
												   cancelButtonTitle:nil 
												   otherButtonTitles:@"Dismiss", nil];
	[infoAlertPanel show];
	[infoAlertPanel release];
}




-(void)viewDidLoad{

	loadImagesOperationQueue = [[NSOperationQueue alloc] init];
	
	NSString * directoryPath = [[NSBundle mainBundle] pathForResource:@"images" ofType:@""];
	
	NSLog(@"%@",directoryPath);
	
	int i = 0;
	int sets = 1;
		
	for( NSString * file in [[NSFileManager defaultManager] directoryContentsAtPath:directoryPath] ) {				
		UIImage * image = [UIImage imageWithContentsOfFile:[directoryPath stringByAppendingPathComponent:file]];
		
		for( int j = 0 ; j < sets; j++){
			[(AFOpenFlowView *)openFlowView setImage:image forIndex:i];
		}
		i++;
	}
	
	[(AFOpenFlowView *)openFlowView setNumberOfImages:i]; 
			
	
}



- (void)imageDidLoad:(NSArray *)arguments {
	UIImage *loadedImage = (UIImage *)[arguments objectAtIndex:0];
	NSNumber *imageIndex = (NSNumber *)[arguments objectAtIndex:1];
	


	[(AFOpenFlowView *)openFlowView setImage:loadedImage forIndex:[imageIndex intValue]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return NO;
}

- (UIImage *)defaultImage {
	return [UIImage imageNamed:@"default.png"];
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index {
	AFGetImageOperation *getImageOperation = [[AFGetImageOperation alloc] initWithIndex:index viewController:self];

	
	[loadImagesOperationQueue addOperation:getImageOperation];
	[getImageOperation release];
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index {
	NSLog(@"Cover Flow selection did change to %d", index);

}

-(void)openFlowView:(AFOpenFlowView *)openFlowView  didTapSelectedCoverView:(int)index{
	
	//if( animating )
//		return;
//	
//	BaseAggravateViewController * controller = [BaseAggravateViewController initFromDefaultNibForIndex:index];
//	controller.delegate = self;
//	
//	float scale = 0.1f;
//	
//	
//	CATransform3D transform = CATransform3DMakeScale(scale,scale, 1.0);	
//	[controller.view layer].transform = transform;
//	
//	
//	[self.view addSubview:controller.view];
//
//	[self performSelector:@selector(growIn:) withObject:controller afterDelay:0.1f];	
	//[audioPlayer pause];

}


-(void)growIn:(UIViewController *)controller{

	animating = YES;
	
	currentScale = 11;
	float scale = currentScale / 10.0f;
	[UIView beginAnimations:nil context:controller];
	[UIView setAnimationDuration:0.50f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseIn];
	//[UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped:finished:context:)];
	CATransform3D transform = CATransform3DMakeScale(scale,scale, 1.0);	
	[controller.view layer].transform = transform;	
	[UIView commitAnimations];
	
}


-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context   	{

	
	UIViewController * controller = (UIViewController *)context;	
    float duration = 0.1f;
	if( currentScale == 11 )
		currentScale = 9;
	else if( currentScale == 9 )
		currentScale = 10;
	else if( currentScale == 99 )
		currentScale = 12;
	else if(currentScale == 12 ){
	    currentScale = 1;	
		duration = 0.5f;
	} else if(currentScale == 1) {
		[controller.view removeFromSuperview];
		[controller release];
		return;
	} else  {
		animating = NO;
		return;
		
	}
	
	float scale = currentScale / 10.0f;

	
	
	[UIView beginAnimations:@"foo" context:controller];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:duration];
	CATransform3D transform = CATransform3DMakeScale(scale,scale, 1.0);	
	[controller.view layer].transform = transform;		
	[UIView commitAnimations];
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	CGPoint prevPoint1 = [[[touches allObjects] objectAtIndex:0] previousLocationInView:self.view];
	CGPoint curPoint1 = [[[touches allObjects] objectAtIndex:0] locationInView:self.view];
	
	float curAngle = [self angleBetweenPoint1:curPoint1 andPoint2:prevPoint1];
	
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
	
	
	CGAffineTransform newTransform3 = CGAffineTransformRotate(hand.transform, curAngle);
	
	hand.transform = newTransform3;
	
	NSLog(@"Current angle %f count %i ",angle, revolutions);
	
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	double radiansPerSection = (((double)M_PI) / 60) * 2.0;
	
	double remainder = (double)angle;
	
	int count = 0;
	while( remainder > radiansPerSection ){
		remainder -= radiansPerSection;
	    count ++;	
	}
	
	if( remainder > radiansPerSection / 2)
		count ++;
	
	
	
	angle = radiansPerSection * count ;
	
	CGAffineTransform newTransform3 = CGAffineTransformMakeRotation(angle);
	
	hand.transform = newTransform3;
	
	
	
}



- (NSInteger)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
	
	CGFloat deltaX = fabsf(point1.x - point2.x);
	
	CGFloat deltaY = fabsf(point1.y - point2.y);
	
	CGFloat distance = sqrt((deltaY*deltaY)+(deltaX*deltaX));
	
	return distance;
	
}



- (CGFloat)angleBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2

{ 
	
	
	float cx = hand.center.x;
	float cy = hand.center.y;
		
	
	float dx = point1.x - cx;
	
	float dy = point1.y - cy;
	
	
	
	double oldangle = atan2(dy,dx);
	
	dx = point2.x - cx;
	
	dy = point2.y - cy;
	
	double newangle = atan2(dy, dx);
	

	
	return oldangle - newangle;
	
} 



	 
@end