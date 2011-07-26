//
//  AppContext.m
//  BlipSnipsFacebook
//
//  Created by David Clements on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppContext.h"
#import "AppSettings.h"
@implementation AppContext


@synthesize playBackSpeed;

@synthesize sounds,images;

static AppContext *sharedGContext = nil;


- (void) initializeRepeatingAlarmTimes{
	//	[alarmTimes addObject:alarmStartDate];	
	//	float totalNumberOfSecondsToRunAlarm = [AlarmClockAppDelegate timerSetting];
	//	
	//	NSDate * finalDate = [AlarmClockAppDelegate completionDate];
	//	float nextSeconds = [AlarmClockAppDelegate wakeLengthSeconds];
	//	float secondsLeft = totalNumberOfSecondsToRunAlarm - nextSeconds;
	//	NSLog(@"Alarm set for a total of %f seconds and a bell will go off at %f seconds and there are %f seconds left",totalNumberOfSecondsToRunAlarm,nextSeconds,secondsLeft);
	//	
	//	while(secondsLeft > 8.0){
	//		NSDate * date = [alarmTimes lastObject];
	//		NSDate * nextDate = [date addTimeInterval:nextSeconds];
	//		
	//		if( [nextDate compare:finalDate] == NSOrderedDescending )
	//			nextDate = finalDate; 
	//		
	//		[alarmTimes addObject:nextDate];
	//		nextSeconds = [AlarmClockAppDelegate wakeLengthSeconds];
	//		secondsLeft = secondsLeft - nextSeconds;
	//		NSLog(@"Alarm set for a total of %f seconds and a bell will go off at %f seconds and there are %f seconds left",totalNumberOfSecondsToRunAlarm,nextSeconds,secondsLeft);
	//	}
	
}

- (void) initializeGoldenAlarmTimes{
	//	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	//	[alarmTimes addObject:alarmStartDate];	
	//	float totalNumberOfSecondsToRunAlarm = [[defaults objectForKey:kWakeLengthKey] intValue] * 60.0;
	//	float nextSeconds = totalNumberOfSecondsToRunAlarm * 0.625f;
	//	float secondsLeft = totalNumberOfSecondsToRunAlarm - nextSeconds;
	//	NSLog(@"Alarm set for a total of %f seconds and a bell will go off at %f seconds and there are %f seconds left",totalNumberOfSecondsToRunAlarm,nextSeconds,secondsLeft);
	//	
	//	while(nextSeconds > 8.0){
	//		NSDate * date = [alarmTimes lastObject];
	//		NSDate * nextDate = [date addTimeInterval:nextSeconds];
	//		[alarmTimes addObject:nextDate];
	//		nextSeconds = secondsLeft * 0.625f;
	//		secondsLeft = secondsLeft - nextSeconds;
	//		NSLog(@"Alarm set for a total of %f seconds and a bell will go off at %f seconds and there are %f seconds left",totalNumberOfSecondsToRunAlarm,nextSeconds,secondsLeft);
	//	}
	
}



+ (AppContext *)sharedContext
{
	@synchronized(self) {
		if (sharedGContext == nil) {
			[[AppContext alloc] initContext]; // assignment not done here
		}
	}
	
	return sharedGContext;
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self) {		
		if (sharedGContext == nil) {
			sharedGContext = [super allocWithZone:zone];
			
			return sharedGContext;  // assignment and return on first allocation
		}
	}
	
	return nil; //on subsequent allocation attempts return nil
}


- (void)initContext {
	[super initContext];
	self.sounds = [NSMutableArray array];
	NSArray * homeDirectory = [[NSFileManager defaultManager] directoryContentsAtPath: [[NSBundle mainBundle] resourcePath]];

	for( NSString * file in homeDirectory ){
		if( [file rangeOfString:@".caf"].length > 0 ){
			NSArray * parts = [file componentsSeparatedByString:@"."];
			
			[self.sounds addObject:[parts objectAtIndex:0]];	
		}
	}
	
	
	[AppSettings storeStringDefault:@"20 minutes" forKey:@"duration"];
	[AppSettings storeStringDefault:@"start and end bells" forKey:@"type"];
	[AppSettings storeStringDefault:@"none" forKey:@"secondaryTime"];
	[AppSettings storeStringDefault:[[AppContext sharedContext].sounds objectAtIndex:0] forKey:@"sound"];
	[AppSettings storeFloatDefault:0.5f forKey:@"volume"];
	
	NSString * directoryPath = [[NSBundle mainBundle] pathForResource:@"icons" ofType:@""];
	
	NSLog(@"%@",directoryPath);
		
	self.images = [[[[NSFileManager defaultManager] directoryContentsAtPath:directoryPath] mutableCopy] autorelease];
	
	//[AppSettings storeStringDefault: forKey:@"image"];
	
	[AppSettings storeIntDefault:2 forKey:@"image"];
	
}




@end
