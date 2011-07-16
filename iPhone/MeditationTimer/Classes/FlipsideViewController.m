//
//  FlipsideViewController.m
//  MeditationTimer
//
//  Created by David Clements on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;
@synthesize durationPicker, typePicker, secondaryTimePicker;

@synthesize firsts, seconds;

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
		
		
		
		
		[firsts addObject:@"golden bells"];
		[firsts addObject:@"repeating bells"];
		[firsts addObject:@"start and end bells"];

		
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
		
		[AppSettings storeString:duration.text forKey:@"duration"];
		
		
	} else if ( self.typePicker ){
		NSString * month = [self.firsts objectAtIndex:[typePicker selectedRowInComponent:0]];
		type.text = [NSString stringWithFormat:@"%@", month];		
		self.typePicker = nil;
		[AppSettings storeString:type.text forKey:@"type"];
		
	} else if( self.secondaryTimePicker ){
		
		NSString * month = [self.firsts objectAtIndex:[secondaryTimePicker selectedRowInComponent:0]];
		NSString * year = [self.seconds objectAtIndex:[secondaryTimePicker selectedRowInComponent:1]];
		secondaryTime.text = [NSString stringWithFormat:@"%@ %@", month, year];	
		self.secondaryTimePicker = nil;
		
		[AppSettings storeString:secondaryTime.text forKey:@"secondaryTime"];
		
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
}


- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
