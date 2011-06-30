//
//  Settings.h
//  Elias
//
//  Created by David Clements on 2/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppSettings : NSObject {
	NSUserDefaults * defaults;
}



@property (nonatomic,retain) NSUserDefaults * defaults;


+ (NSObject *)infoKey:(NSString *)key;
+ (NSDictionary *) dictForPlist:(NSString *)name;
+(NSString *)valueInPlist:(NSString *)plist withKey:(NSString *)key;
+(NSArray *) arrayForPlist:(NSString *)name;


+(void)storeStringDefault:(NSString *)value forKey:(NSString *)forKey;
+(void)storeString:(NSString *)value forKey:(NSString *)forKey;
+(NSString *)getString:(NSString *)forKey;
-(void)storeString:(NSString *)value forKey:(NSString *)forKey;
-(NSString *)getString:(NSString *)forKey;

+(void)storeSecureStringDefault:(NSString *)value forKey:(NSString *)forKey;
+(void)storeSecureString:(NSString *)value forKey:(NSString *)forKey;
+(NSString *)getSecureString:(NSString *)forKey;
-(void)storeSecureString:(NSString *)value forKey:(NSString *)forKey;
-(NSString *)getSecureString:(NSString *)forKey;

+ (AppSettings *)sharedSingleton;
+(void)storeBool:(BOOL)value forKey:(NSString *)forKey;
+(BOOL)getBool:(NSString *)forKey;
+(void)storeBooleanDefault:(BOOL)value forKey:(NSString *)forKey;
-(BOOL)getBool:(NSString *)forKey;
-(void)storeBool:(BOOL)value forKey:(NSString *)forKey;


-(float)getFloat:(NSString *)forKey;
-(void)storeFloat:(float)value forKey:(NSString *)forKey;
+(float)getFloat:(NSString *)forKey;
+(void)storeFloat:(float)value forKey:(NSString *)forKey;
+(void)storeFloatDefault:(float)value forKey:(NSString *)forKey;

-(int)getInt:(NSString *)forKey;
-(void)storeInt:(int)value forKey:(NSString *)forKey;
+(int)getInt:(NSString *)forKey;
+(void)storeInt:(int)value forKey:(NSString *)forKey;
+(void)storeIntDefault:(int)value forKey:(NSString *)forKey;


-(NSArray *)getArray:(NSString *)forKey;
+(void)storeObject:(NSObject *)value forKey:(NSString *)forKey;

+(NSArray *)getArray:(NSString *)forKey;
-(void)storeObject:(NSObject *)value forKey:(NSString *)forKey;
+(void)storeArrayDefault:(NSArray *)value forKey:(NSString *)forKey;


-(void)sendNotification:(NSString *)forKey;
-(void)sync;



@end


