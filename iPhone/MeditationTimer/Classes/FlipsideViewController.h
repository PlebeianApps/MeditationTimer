//
//  FlipsideViewController.h
//  MeditationTimer
//
//  Created by David Clements on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"
@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController  <UIActionSheetDelegate, UIPickerViewDelegate,AFOpenFlowViewDataSource, AFOpenFlowViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;
	IBOutlet UITextField * duration;
	IBOutlet UITextField * type;
	IBOutlet UITextField * secondaryTime;
	IBOutlet UITextField * sound;
	
	IBOutlet UISlider * volumeSlider;
	
	UIPickerView * durationPicker;
	UIPickerView * typePicker;
	UIPickerView * secondaryTimePicker;
	UIPickerView * soundPicker;
	
	NSMutableArray * firsts;
	NSMutableArray * seconds;
	
	IBOutlet AFOpenFlowView * openFlowView;
	
	NSOperationQueue *loadImagesOperationQueue;
	int currentIndex;
	
	

}

@property(nonatomic,retain) NSMutableArray * firsts;
@property(nonatomic,retain) NSMutableArray * seconds;

@property(nonatomic,retain) UIPickerView * durationPicker;
@property(nonatomic,retain) UIPickerView * typePicker;
@property(nonatomic,retain) UIPickerView * secondaryTimePicker;
@property(nonatomic,retain) UIPickerView * soundPicker;



@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;

-(void)showDurationPicker;
-(void)showTypeSelector;
-(void)showSoundPicker;
-(void)showSecondaryTimePicker;
-(void)setField:(UITextField *)field withKey:(NSString *)key;

-(IBAction)saveTouched;

-(IBAction)infoButtonTouched;
-(IBAction)volumeChanged;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;


@end

