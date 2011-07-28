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

@synthesize sounds,images,player;

static AppContext *sharedGContext = nil;





-(NSTimeInterval)getCurrentDurationSeconds;
{
	NSString * duration = [AppSettings getString:@"duration"];
	NSArray * parts = [duration componentsSeparatedByString:@" "];
	NSString * numberPart = [parts objectAtIndex:0];
	NSString * unitsPart = [parts objectAtIndex:1];
	
	int multiplier = ( [unitsPart isEqual:@"minutes"] ? 60 : 60 * 60 );
	return (NSTimeInterval)[numberPart floatValue] * multiplier;
}

-(NSTimeInterval)getSecondaryTimeSeconds;
{
	NSString * duration = [AppSettings getString:@"secondaryTime"];
	NSArray * parts = [duration componentsSeparatedByString:@" "];
	NSString * numberPart = [parts objectAtIndex:0];
	NSString * unitsPart = [parts objectAtIndex:1];
	
	int multiplier = ( [unitsPart isEqual:@"minutes"] ? 60 : 60 * 60 );
	return (NSTimeInterval)[numberPart floatValue] * multiplier;
}


-(void)stopSound;
{
	[self.player stop];	
}

-(void)playSound:(NSString *)sound;
{
	[self.player stop];
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] 
                                               pathForResource:sound
                                               ofType:@"caf"]];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
	self.player.volume = [AppSettings getFloat:@"volume"];
    [self.player play];
}

-(void)playSound
{	
	[self playSound:[AppSettings getString:@"sound"]];
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


-(UIImage *)getCurrentImage;
{
	NSString * directoryPath = [[NSBundle mainBundle] pathForResource:@"images" ofType:@""];
    int currentIndex = [AppSettings getInt:@"image"];
	NSString * image = [self.images objectAtIndex:currentIndex];
	return [UIImage imageWithContentsOfFile:[directoryPath stringByAppendingPathComponent:image]];
	
}



@end
