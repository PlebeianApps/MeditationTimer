//
//  Settings.m
//  Elias
//
//  Created by David Clements on 2/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "SFHFKeychainUtils.h"
#import "AppSettings.h"

#define SECURE_SETTING_KEY @"Athoc"

@implementation AppSettings

@synthesize defaults;

+(NSString *)valueInPlist:(NSString *)plist withKey:(NSString *)key{
	NSString * value = [[self dictForPlist:plist]	objectForKey:key];
	return value;
}

+ (NSObject *)infoKey:(NSString *)key{
	return [[self dictForPlist:@"Info"] objectForKey:key];	
}


+ (NSDictionary *) dictForPlist:(NSString *)name{
	NSDictionary * plistDict;
	if( [name compare:@"Info"] == NSOrderedSame)
		plistDict = [[NSBundle mainBundle] infoDictionary];
	else {	
		NSString *errorDesc = nil;
		NSPropertyListFormat format;	
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
		NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];	
		plistDict = (NSMutableDictionary *)[NSPropertyListSerialization
											propertyListFromData:plistXML																 
											mutabilityOption:NSPropertyListMutableContainersAndLeaves														
											format:&format errorDescription:&errorDesc];	
	}
	return plistDict;
	
}

+(NSArray *) arrayForPlist:(NSString *)name{
	
	NSArray * plistArray;
	
	NSString *errorDesc = nil;
	NSPropertyListFormat format;	
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];	
	plistArray = (NSArray *)[NSPropertyListSerialization
										propertyListFromData:plistXML																 
										mutabilityOption:NSPropertyListMutableContainersAndLeaves														
										format:&format errorDescription:&errorDesc];
	
	return plistArray;

	
}





+ (AppSettings *)sharedSingleton
{
	static AppSettings *sharedSingleton;
	
	@synchronized(self)
	{
		if (!sharedSingleton)
			sharedSingleton = [[AppSettings alloc] init];
		
		return sharedSingleton;
	}
	return sharedSingleton; //  Not really needed right?
}

-(id)init{
	[super init];
	self.defaults = [NSUserDefaults standardUserDefaults]; 
	[self performSelector:@selector(setupStringDefaults) withObject:nil afterDelay:0];
	return self;
}
	 
	 -(void)setupStringDefaults;
	 {
		 NSDictionary * strings = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"]];
		 
		 for( NSString * key in [strings allKeys] ){
			 NSString * value = [strings objectForKey:key];
			 [AppSettings storeStringDefault:value forKey:key];
		 }
	 }


#pragma mark STRING
+(void)storeStringDefault:(NSString *)value forKey:(NSString *)forKey{
	NSString * currentValue = [[self sharedSingleton].defaults stringForKey:forKey];
	
    if(currentValue == NULL )
		[[self sharedSingleton] storeObject:value forKey:forKey];	
}

+(void)storeString:(NSString *)value forKey:(NSString *)forKey{
	[[self sharedSingleton] storeObject:value forKey:forKey];	
}

+(NSString *)getString:(NSString *)forKey{
	return [[self sharedSingleton] getString:forKey] ;
}

-(void)storeString:(NSString *)value forKey:(NSString *)forKey{
	[self.defaults setObject:value forKey: forKey];	
	[self sync];
}

-(NSString *)getString:(NSString *)forKey{
	NSString * value = [self.defaults stringForKey:forKey];
	return value;
}

#pragma mark STRING
+(void)storeSecureStringDefault:(NSString *)value forKey:(NSString *)forKey{
	NSString * currentValue = [[self sharedSingleton] getSecureString:forKey];
	
    if(currentValue == NULL )
		[[self sharedSingleton] storeSecureString:value forKey:forKey];	
}

+(void)storeSecureString:(NSString *)value forKey:(NSString *)forKey{
	[[self sharedSingleton] storeSecureString:value forKey:forKey];	
}

+(NSString *)getSecureString:(NSString *)forKey{
	return  [[self sharedSingleton] getSecureString:forKey];
}

-(void)storeSecureString:(NSString *)value forKey:(NSString *)forKey{
	NSError * error;
	[SFHFKeychainUtils storeUsername:forKey andPassword:value forServiceName:SECURE_SETTING_KEY updateExisting:YES error:&error];
}

-(NSString *)getSecureString:(NSString *)forKey{
	NSError * error;
	NSString * value = [SFHFKeychainUtils getPasswordForUsername:forKey andServiceName:SECURE_SETTING_KEY error:&error];
	return value;
}



#pragma mark BOOL
+(void)storeBooleanDefault:(BOOL)value forKey:(NSString *)forKey{
	NSNumber * currentValue = [[self sharedSingleton].defaults objectForKey:forKey];
	
    if(currentValue == NULL )
		[[self sharedSingleton] storeBool:value forKey:forKey];	
}

+(void)storeBool:(BOOL)value forKey:(NSString *)forKey{
	[[self sharedSingleton] storeBool:value forKey:forKey];	
}

+(BOOL)getBool:(NSString *)forKey{
	return [[self sharedSingleton] getBool:forKey] ;
}

-(void)storeBool:(BOOL)value forKey:(NSString *)forKey{
	[self.defaults setBool:value forKey: forKey];	
	[self sendNotification:forKey];
	[self sync];
}

-(BOOL)getBool:(NSString *)forKey{
	NSNumber * value = [self.defaults objectForKey:forKey];
	return [value boolValue];	
}



#pragma mark FLOAT
+(void)storeFloatDefault:(float)value forKey:(NSString *)forKey{
	NSNumber * currentValue = [[self sharedSingleton].defaults objectForKey:forKey];
	
    if(currentValue == NULL )
		[[self sharedSingleton] storeFloat:value forKey:forKey];	
}

+(void)storeFloat:(float)value forKey:(NSString *)forKey{
	[[self sharedSingleton] storeFloat:value forKey:forKey];	
}

+(float)getFloat:(NSString *)forKey{
	return [[self sharedSingleton] getFloat:forKey] ;
}

-(void)storeFloat:(float)value forKey:(NSString *)forKey{
	[self.defaults setFloat:value forKey: forKey];	
	[self sync];
}

-(float)getFloat:(NSString *)forKey{
	NSNumber * value = [self.defaults objectForKey:forKey];
	return [value floatValue];	
}


#pragma mark ARRAY
+(void)storeArrayDefault:(NSArray *)value forKey:(NSString *)forKey{
	NSArray * currentValue = [[self sharedSingleton].defaults arrayForKey:forKey];
	
    if(currentValue == NULL )
		[[self sharedSingleton] storeObject:value forKey:forKey];	
}

+(void)storeObject:(NSObject *)value forKey:(NSString *)forKey{
	[[self sharedSingleton] storeObject:value forKey:forKey];	
}

+(NSArray *)getArray:(NSString *)forKey{
	return [[self sharedSingleton] getArray:forKey] ;
}

-(void)storeObject:(NSObject *)value forKey:(NSString *)forKey{
	[self.defaults setObject:value forKey: forKey];	
	[self sync];
}

-(NSArray *)getArray:(NSString *)forKey{
	NSArray * value = [self.defaults arrayForKey:forKey];
	return value;
}


#pragma mark INT 
+(void)storeIntDefault:(int)value forKey:(NSString *)forKey{
	NSNumber * currentValue = [[self sharedSingleton].defaults objectForKey:forKey];
	
    if(currentValue == NULL )
		[[self sharedSingleton] storeInt:value forKey:forKey];	
}

+(void)storeInt:(int)value forKey:(NSString *)forKey{
	[[self sharedSingleton] storeInt:value forKey:forKey];	
}

+(int)getInt:(NSString *)forKey{
	return [[self sharedSingleton] getInt:forKey] ;
}

-(void)storeInt:(int)value forKey:(NSString *)forKey{
	[self.defaults setInteger:value forKey: forKey];	
	[self sync];
}

-(int)getInt:(NSString *)forKey{
	NSNumber * value = [self.defaults objectForKey:forKey];
	return [value intValue];	
}



-(void)sendNotification:(NSString *)forKey{
//	[[NSNotificationCenter defaultCenter] postNotificationName:forKey object:self];

}

-(void)sync{
	[self.defaults synchronize];	
}



@end
