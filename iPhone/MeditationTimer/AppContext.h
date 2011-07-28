//
//  AppContext.h
//  BlipSnipsFacebook
//
//  Created by David Clements on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAppContext.h"

#import "MobileCoreServices/UTCoreTypes.h"

#import <AVFoundation/AVFoundation.h>


#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AppContext : BaseAppContext {

	float playBackSpeed;
	NSMutableArray * sounds;
	
	NSMutableArray * images;
	AVAudioPlayer * player;

}


@property(nonatomic,retain) AVAudioPlayer * player;
@property(nonatomic,retain) NSMutableArray * sounds;
@property(nonatomic,retain) NSMutableArray * images;
@property(nonatomic,assign) float playBackSpeed;

+ (AppContext *)sharedContext;
-(UIImage *)getCurrentImage;
-(NSTimeInterval)getCurrentDurationSeconds;
-(NSTimeInterval)getSecondaryTimeSeconds;
-(void)playSound;
-(void)stopSound;
-(void)playSound:(NSString *)sound;

@end
