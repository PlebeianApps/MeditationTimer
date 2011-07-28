//
//  AboutViewController.h
//  MeditationTimer
//
//  Created by David Clements on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"

@interface AboutViewController : UIViewController {

	IBOutlet UIScrollView * theScrollView;
	IBOutlet UIImageView * theImageView;
}
- (IBAction)done:(id)sender;

@end
