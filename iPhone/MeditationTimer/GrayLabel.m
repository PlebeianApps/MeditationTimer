//
//  ButtonLabel.m
//  Splickit
//
//  Created by David Clements on 8/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GrayLabel.h"


@implementation GrayLabel

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
	}
	[self setup];
	
	    return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self setup];
}

-(id)init;
{
	self = [super init];
	[self setup];
	return self;
}

-(void)setupTextWithKey:(NSString *)key;
{
	self.text =	NSLocalizedString(key, @"");
	self.textColor = [UIColor whiteColor];
	[self resizeToCurrentText];
	
}

-(void)setup;
{
	self.backgroundColor = [UIColor clearColor];
	self.numberOfLines = 0;
	self.adjustsFontSizeToFitWidth = NO;
}

@end
