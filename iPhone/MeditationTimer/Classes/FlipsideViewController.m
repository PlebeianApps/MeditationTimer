//
//  FlipsideViewController.m
//  MeditationTimer
//
//  Created by David Clements on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import "AFGetImageOperation.h"
#import "AboutViewController.h"

@implementation FlipsideViewController

@synthesize delegate;
@synthesize durationPicker, typePicker, secondaryTimePicker, soundPicker;

@synthesize firsts, seconds;


-(void)setupSecondaryLabel;
{
	if( [type.text isEqual:GOLDEN_BELLS] ){
		secondaryTimeLabel.text = @"Golden bells at end for";
		secondaryTime.enabled = YES;	
		mask.hidden = YES;
		secondaryTimeLabel.textColor = [UIColor whiteColor];
	} else if( [type.text isEqual:REPEATING_BELLS] ){
		secondaryTimeLabel.text = @"Bells every";
		secondaryTime.enabled = YES;	
		mask.hidden = YES;
		
		secondaryTimeLabel.textColor = [UIColor whiteColor];

	} else {
		secondaryTime.enabled = NO;	
		mask.hidden = NO;
		secondaryTimeLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.3f];
	}	
	
	secondaryTime.textColor = secondaryTimeLabel.textColor;

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
	
	 if( textField == duration ){
	    [self showDurationPicker];
		return NO;
	} else if( textField == type ){
		[self showTypeSelector];
		return NO;
	} else if( textField == secondaryTime ){
	    [self showSecondaryTimePicker];
		return NO;
	} else if ( textField == sound ){
		[self showSoundPicker];
		return NO;
	}
	
	return YES;
}

-(void)showTypeSelector;
{
	if( self.typePicker == nil ){
		self.typePicker = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, 90, 320, 216)] autorelease];
		self.typePicker.showsSelectionIndicator = YES;
		self.typePicker.delegate = self;
		
		self.firsts = [NSMutableArray array]; 
		self.seconds = nil;
		
		
	
		[firsts addObject:GOLDEN_BELLS];
		[firsts addObject:REPEATING_BELLS];
		[firsts addObject:START_AND_END_BELLS];

		int index = [self.firsts indexOfObject:type.text];
		[self.typePicker selectRow:index inComponent:0 animated:YES];

		UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Bell Type" 
														  delegate:self
												 cancelButtonTitle:@"Done"
											destructiveButtonTitle:nil
												 otherButtonTitles:nil];
		
		// Add the picker
		[menu addSubview:typePicker];
		[menu showInView:self.view];        
		[menu setBounds:CGRectMake(0,0,320, 500)];
		
		[menu release];
		
	}
}

-(void)showSoundPicker;
{
	if( self.soundPicker == nil ){
		self.soundPicker = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, 90, 320, 216)] autorelease];
		self.soundPicker.showsSelectionIndicator = YES;
		self.soundPicker.delegate = self;
		
		self.seconds = nil;
		
		self.firsts = [AppContext sharedContext].sounds;
		
		int index = [self.firsts indexOfObject:sound.text];
		
		[self.soundPicker selectRow:index inComponent:0 animated:YES];
		
		UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Sound" 
														  delegate:self
												 cancelButtonTitle:@"Done"
											destructiveButtonTitle:nil
												 otherButtonTitles:nil];
		
		// Add the picker
		[menu addSubview:soundPicker];
		[menu showInView:self.view];        
		[menu setBounds:CGRectMake(0,0,320, 500)];
		
		[menu release];
		
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
	if( self.soundPicker != nil ){
		NSString * s = [self.firsts objectAtIndex:row];
		[[AppContext sharedContext] playSound:s];
	}
}





-(void)showDurationPicker;
{
	if( self.durationPicker == nil ){
		self.durationPicker = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, 90, 320, 216)] autorelease];
		self.durationPicker.showsSelectionIndicator = YES;
		self.durationPicker.delegate = self;
		
		self.firsts = [NSMutableArray array]; 
		self.seconds = [NSMutableArray array];
		
		for( int i = 1; i <= 120 ; i++ ){
			[firsts addObject:[NSString stringWithFormat:@"%i",i]];	
		}
		
		
		[seconds addObject:@"minutes"];
		[seconds addObject:@"hours"];
		
		NSArray * parts = [duration.text componentsSeparatedByString:@" "];
		NSString * first = [parts objectAtIndex:0];
		NSString * second = [parts objectAtIndex:1];
		
		[self.durationPicker selectRow:[self.firsts indexOfObject:first] inComponent:0 animated:YES];
		[self.durationPicker selectRow:[self.seconds indexOfObject:second] inComponent:1 animated:YES];

		
		UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Duration" 
														  delegate:self
												 cancelButtonTitle:@"Done"
											destructiveButtonTitle:nil
												 otherButtonTitles:nil];
		
		// Add the picker
		[menu addSubview:durationPicker];
		[menu showInView:self.view];        
		[menu setBounds:CGRectMake(0,0,320, 500)];
		
		[menu release];
		
	}
}



-(void)showSecondaryTimePicker;
{
	if( self.secondaryTimePicker == nil ){
		self.secondaryTimePicker = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, 90, 320, 216)] autorelease];
		self.secondaryTimePicker.showsSelectionIndicator = YES;
		self.secondaryTimePicker.delegate = self;
		
		self.firsts = [NSMutableArray array]; 
		self.seconds = [NSMutableArray array];
		
		for( int i = 1; i <= 120 ; i++ ){
			[firsts addObject:[NSString stringWithFormat:@"%i",i]];	
		}
		
		
		[seconds addObject:@"minutes"];
		[seconds addObject:@"hours"];
		
		NSArray * parts = [secondaryTime.text componentsSeparatedByString:@" "];
		NSString * first = [parts objectAtIndex:0];
		
		
		[self.secondaryTimePicker selectRow:[self.firsts indexOfObject:first] inComponent:0 animated:YES];
		
		if( parts.count > 1 ){
			NSString * second = [parts objectAtIndex:1];
			[self.secondaryTimePicker selectRow:[self.seconds indexOfObject:second] inComponent:1 animated:YES];
		}
		
		
		UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Duration" 
														  delegate:self
												 cancelButtonTitle:@"Done"
											destructiveButtonTitle:nil
												 otherButtonTitles:nil];
		
		// Add the picker
		[menu addSubview:secondaryTimePicker];
		[menu showInView:self.view];        
		[menu setBounds:CGRectMake(0,0,320, 500)];
		
		[menu release];
		
	}
}



- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation
{
	if( self.durationPicker ){
		
		NSString * month = [self.firsts objectAtIndex:[durationPicker selectedRowInComponent:0]];
		NSString * year = [self.seconds objectAtIndex:[durationPicker selectedRowInComponent:1]];
		duration.text = [NSString stringWithFormat:@"%@ %@", month, year];	
		self.durationPicker = nil;
		
		
		
	} else if ( self.typePicker ){
		NSString * month = [self.firsts objectAtIndex:[typePicker selectedRowInComponent:0]];
		type.text = [NSString stringWithFormat:@"%@", month];		
		self.typePicker = nil;

		[self setupSecondaryLabel];
		
	} else if( self.secondaryTimePicker ){
		
		NSString * month = [self.firsts objectAtIndex:[secondaryTimePicker selectedRowInComponent:0]];
		NSString * year = [self.seconds objectAtIndex:[secondaryTimePicker selectedRowInComponent:1]];
		secondaryTime.text = [NSString stringWithFormat:@"%@ %@", month, year];	
		self.secondaryTimePicker = nil;
		
		
	} else if ( self.soundPicker ){
		NSString * month = [self.firsts objectAtIndex:[soundPicker selectedRowInComponent:0]];
		sound.text = [NSString stringWithFormat:@"%@", month];		
		self.soundPicker = nil;
	}
	
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return ( self.seconds.count > 0 ) ? 2 : 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{	
	return ( component == 0 ) ? self.firsts.count : self.seconds.count;
}

// returns width of column and height of row for each component. 
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
	return 100 * (3 - [self numberOfComponentsInPickerView:pickerView] );
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
	return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{	
	NSArray * array = (component == 0 ) ? self.firsts : self.seconds;
	return [array objectAtIndex:row];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];   
	

	
    [self setField:sound withKey:@"sound"];
	[self setField:duration withKey:@"duration"];
	[self setField:secondaryTime withKey:@"secondaryTime"];
	[self setField:type withKey:@"type"];
	
	volumeSlider.value = [AppSettings getFloat:@"volume"];
	

	[self setupSecondaryLabel];
	
	loadImagesOperationQueue = [[NSOperationQueue alloc] init];
	
	NSString * directoryPath = [[NSBundle mainBundle] pathForResource:@"icons" ofType:@""];
	
	NSLog(@"%@",directoryPath);
	
	int i = 0;
	
	for( NSString * file in [AppContext sharedContext].images ) {				
		UIImage * image = [UIImage imageWithContentsOfFile:[directoryPath stringByAppendingPathComponent:file]];
		
		[(AFOpenFlowView *)openFlowView setImage:image forIndex:i];
		i++;
	}
	
	[(AFOpenFlowView *)openFlowView setNumberOfImages:i]; 
	
	[openFlowView setSelectedCover:[AppSettings getInt:@"image"]];
	[openFlowView centerOnSelectedCover:NO];
	currentIndex = [AppSettings getInt:@"image"];
}



- (void)imageDidLoad:(NSArray *)arguments {
	UIImage *loadedImage = (UIImage *)[arguments objectAtIndex:0];
	NSNumber *imageIndex = (NSNumber *)[arguments objectAtIndex:1];
	[(AFOpenFlowView *)openFlowView setImage:loadedImage forIndex:[imageIndex intValue]];
}

-(void)setField:(UITextField *)field withKey:(NSString *)key;
{
    field.text = [AppSettings getString:key];	
}


- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}


-(void)saveTouched;
{
	[AppSettings storeString:sound.text forKey:@"sound"];	
	[AppSettings storeString:secondaryTime.text forKey:@"secondaryTime"];
	[AppSettings storeString:duration.text forKey:@"duration"];
	[AppSettings storeString:type.text forKey:@"type"];	
	
	[AppSettings storeFloat:volumeSlider.value forKey:@"volume"];
	
	[AppSettings storeInt:currentIndex  forKey:@"image"];
	
	[self.delegate flipsideViewControllerDidFinish:self];	
}

-(void)infoButtonTouched;
{
	AboutViewController * controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
	[self presentModalViewController:controller animated:YES];
	[controller release];
}



- (void)dealloc {
    [super dealloc];
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
	currentIndex = index;

	
}

-(void)openFlowView:(AFOpenFlowView *)openFlowView  didTapSelectedCoverView:(int)index{
}



@end
