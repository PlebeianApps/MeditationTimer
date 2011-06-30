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

@interface AppContext : BaseAppContext {

	float playBackSpeed;
	
	}



@property(nonatomic,assign) float playBackSpeed;

+ (AppContext *)sharedContext;

@end
