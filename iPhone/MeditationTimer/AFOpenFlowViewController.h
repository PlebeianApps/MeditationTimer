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
#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"
#import <AVFoundation/AVFoundation.h>

@interface AFOpenFlowViewController : UIViewController <AFOpenFlowViewDataSource, AFOpenFlowViewDelegate > {
	NSArray *coverImageData;

	NSDictionary *interestingPhotosDictionary;
	NSOperationQueue *loadImagesOperationQueue;
	
	int currentScale;
	
	BOOL animating;
	
    AVAudioPlayer *audioPlayer;
	
	IBOutlet UILabel * titleLabel;
	
    IBOutlet AFOpenFlowView * openFlowView;
	
	IBOutlet UIImageView * hand;
	
	float angle;

	int revolutions;
	
	int currentIndex;
	
	IBOutlet UIButton * goButton;

	
	BOOL running;
	
	NSTimer *stopWatchViewUpdateTimer;
	
	
}


- (void)imageDidLoad:(NSArray *)arguments;
- (IBAction)infoButtonPressed:(id)sender;


- (CGFloat)angleBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;
- (NSInteger)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 ;



@end