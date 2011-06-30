//
//  AppContext.h
//  splickit
//
//  Created by David Clements on 2/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>




@class AppContext;

@interface BaseAppContext : NSObject < UIAlertViewDelegate> {
	// Version Information
	NSString *applicationName;
	NSString *applicationId;

	NSString *applicationVersion;
	NSString *applicationBuild;
	NSString *deviceModel;
	
	
	NSOperationQueue * queue;
	
	NSArray * friends;
	
	NSString * username;
	NSString * password;
	NSString * firstName;
	NSString * lastName;	
	
	BOOL isReady;
	
	NSString * currentStatus;
		
	BOOL isLoggedIn;
	BOOL logginIn;
	

	NSDictionary * user;
	


}


@property(nonatomic,assign) BOOL isLoggedIn;
@property(nonatomic,assign) BOOL logginIn;
@property(nonatomic,assign) BOOL isReady;
@property(nonatomic,retain) NSString * currentStatus;

@property(nonatomic,retain) NSArray * friends;
@property(nonatomic,retain) NSDictionary * user;
//
// Application Information
//
@property (nonatomic, retain) NSString *applicationVersion;
@property (nonatomic, retain) NSString *applicationId;
@property (nonatomic, retain) NSString *applicationName;
@property (nonatomic, retain) NSString *applicationBuild;
@property (nonatomic, retain) NSString *deviceModel;
-(NSString *)deviceId;

// Facebook
//@property (nonatomic,retain) FBSession * fbSession;

@property(nonatomic,retain) NSString * username;
@property(nonatomic,retain) NSString * password;
@property(nonatomic,retain) NSString * firstName;
@property(nonatomic,retain) NSString * lastName;



- (void)releaseMemory;


- (BOOL)isIPodTouch;
- (BOOL)isIPhone;
- (BOOL)isSimulator;
//- (BOOL)isAccounted;



-(BOOL)isLoggedIn;
-(void)logout;
- (void)initContext;

-(void)initStoredUserAndPassword;

-(void)resetStatusIfEqual:(NSString *)message;
-(void)setStatusIfEmpty:(NSString *)message;

-(void)simpleAlertWithTitle:(NSString *)title andMessage:(NSString *)message;


-(NSString *)howFarInWords:(NSTimeInterval )timeInterval;


-(void)logoutAndClearAll:(BOOL)clearAll;

- (void)loadApplicationInformation;

@end
