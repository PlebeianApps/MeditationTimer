//
//  GraphiclyContext.m
//  Graphicly
//
//  Created by David Clements on 12/9/09.
//  Copyright 2009 Xcellent Creations, Inc. All rights reserved.
//

#import "BaseAppContext.h"
#import "AppContext.h"


@implementation BaseAppContext

@synthesize applicationName;
@synthesize applicationVersion;
@synthesize applicationBuild;
@synthesize applicationId;

@synthesize deviceModel;
@synthesize username;
@synthesize password;
@synthesize firstName;
@synthesize lastName;

@synthesize friends, user;

@synthesize currentStatus;

@synthesize isReady;

@synthesize isLoggedIn, logginIn;


- (void)initContext {
	if ( self = [super init]) {
		
		// Initialization...
		[self loadApplicationInformation];
		
	}
}

+(NSString *)GetUUID
{
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return [(NSString *)string autorelease];
}



















-(NSString *)howFarInWords:(NSTimeInterval )timeInterval{
	
	
	int secondsAgo = abs((int)timeInterval);
	
	if( secondsAgo == 0 )
		secondsAgo = 1;
	
	int minutesAgo = secondsAgo / 60 ;
	int hoursAgo = secondsAgo / 60 / 60;
	int daysAgo = secondsAgo/ 60 / 60 / 24;
	
	
	int hoursMinusDaysAgo = (hoursAgo - 24 * daysAgo);
	int minutesAgoMinusHoursAgo = ( minutesAgo - hoursAgo * 60 );
	
	NSString * result = @"";
	
	if( secondsAgo < 60 )
		result = [NSString stringWithFormat:@"%i second%@", (int)secondsAgo, (secondsAgo > 1 ) ? @"s" : @"" ];
	else{
		
		if( daysAgo > 0 )
			result = [result stringByAppendingFormat:@"%i day%@", daysAgo ,(daysAgo > 1 ) ? @"s" : @"" ];
		if(hoursAgo > 0 && daysAgo < 1)
			result = [result stringByAppendingFormat:@" %i hour%@", hoursMinusDaysAgo , (hoursMinusDaysAgo > 1 ) ? @"s" : @""];
		if(minutesAgo > 0 && daysAgo == 0 && hoursAgo == 0)
			result = [result stringByAppendingFormat:@" %i minute%@", minutesAgoMinusHoursAgo,(minutesAgoMinusHoursAgo > 1 ) ? @"s" : @"" ];
		
	}
	
	if( [result length] > 0 )
		result = [result stringByAppendingFormat:@""];
	else
		result = @"unknown";
	
	return result;
	
}


-(void)initStoredUserAndPassword;
{
	
	NSString * p = [AppSettings getSecureString:@"password"];
	NSString * email = [AppSettings getString:@"email"];
	
	if( p && email && p.length > 0 && email.length > 0 ){
		
		if( p )
			self.password = p;
		
		
		if( email )
			self.username = email;
	} else {
		[self logoutAndClearAll:NO];	
	}
	
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	
}


-(void)setStatusIfEmpty:(NSString *)message;
{
	if( self.currentStatus.length == 0 ){
		self.currentStatus = message;
	}		
}

-(void)resetStatusIfEqual:(NSString *)message;
{
	if( [self.currentStatus isEqual:message] ){
		self.currentStatus = @"";
	}
}

-(void)logout;
{
	[self logoutAndClearAll:YES];	
}

-(void)logoutAndClearAll:(BOOL)clearAll;
{
	[AppSettings storeString:nil forKey:@"email"];
	[AppSettings storeString:nil forKey:@"password"];
	
	self.password = nil;
	self.username = nil;
	
	if( clearAll ){
	}
	
	
	self.isLoggedIn = NO;
}



-(void)simpleAlertWithTitle:(NSString *)title andMessage:(NSString *)message;
{
	
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[alert show];
	[alert release];
}



- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain {
	return self;	
}

- (unsigned)retainCount {
	return UINT_MAX;  //denotes an object that cannot be released	
}

- (void)release {
	//do nothing
}

- (id)autorelease {
	return self;	
}

- (void)releaseMemory {
	@synchronized(self) {
		//	[self.imageCache purge];
	}
}


- (BOOL)isIPhone {
	return (NSOrderedSame ==  [deviceModel caseInsensitiveCompare:@"iPhone"]);
}


- (BOOL)isIPodTouch {
	return (NSOrderedSame ==  [deviceModel caseInsensitiveCompare:@"iPod Touch"]);
}


- (BOOL)isSimulator {
	return (NSOrderedSame ==  [deviceModel caseInsensitiveCompare:@"iPhone Simulator"]);
}


- (void)loadApplicationInformation {
	NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
	
	self.applicationName =  [infoDict objectForKey:@"CFBundleName"];
	self.applicationVersion = [infoDict objectForKey:@"CFBundleVersion"];
	self.applicationId = [infoDict objectForKey:@"CFBundleIdentifier"];
	self.applicationBuild = [infoDict objectForKey:@"CFBundleShortVersionString"];
	
	// Tap into the current device
	UIDevice *device = [UIDevice currentDevice];
	self.deviceModel = device.model;
}


-(NSString *)deviceId{
	return  [UIDevice currentDevice].uniqueIdentifier;
}

- (void)didReceiveMemoryWarning {
}

@end
