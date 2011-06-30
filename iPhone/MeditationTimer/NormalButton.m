//
//  NormalButton.m
//  Splickit
//
//  Created by David Clements on 8/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NormalButton.h"


@implementation NormalButton

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

-(void)setup;
{
	self.backgroundColor = [AppStyle normalButtonColor];

	self.layer.cornerRadius = 8.0f;
	self.layer.borderColor = [[UIColor colorWithHexString:@"444444"] CGColor];
	self.layer.borderWidth = 1.0f;
	self.clipsToBounds = YES;
	
	[self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	
	[self setTitleColor:[self titleColorForState:UIControlStateNormal] forState:UIControlStateHighlighted];
}

-(void)setHighlighted:(BOOL)highlighted;
{
	if( highlighted )
		self.backgroundColor = [AppStyle highlightedNormalButtonColor];
	else 
		self.backgroundColor = [AppStyle normalButtonColor];
	
	[super setHighlighted:highlighted];

}

- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	
	CGFloat colors[] =
	{
		0.0, 0, 0.0, 0.0,
		0.0, 0, 0.0, 0.40
	};
	size_t num_locations = 2;
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, num_locations);
	CGColorSpaceRelease(rgb);
	
	CGPoint start, end;
	start = CGPointMake(self.frame.size.width /2 ,0);
	end = CGPointMake(self.frame.size.width /2, self.frame.size.height );
	CGContextDrawLinearGradient(context, gradient, start, end, 0);
	
	CFRelease(gradient);
	CFRelease(rgb);
	
	//rgb = CGColorSpaceCreateDeviceRGB();
//	
//	if( YES ){
//		CGFloat colors[] =
//		{
//			0.1, 0.1, 0.1, 0.7,
//			0.5, 0.5,0.5, 0.2 
//		};
//		size_t num_locations = 2;
//		CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, num_locations);
//		CGColorSpaceRelease(rgb);
//		
//		start = CGPointMake(160, end.y - 1 );
//		end = CGPointMake(160,end.y );
//		CGContextDrawLinearGradient(context, gradient, start, end, 0);
//		
//		CFRelease(gradient);
//		CFRelease(rgb);
//	}
	
	
	
	//if( last ){
//		rgb = CGColorSpaceCreateDeviceRGB();
//		
//		CGFloat colors[] =
//		{
//			0.1, 0.1, 0.1, 0.7,
//			0.5, 0.5,0.5, 0.2 
//		};
//		size_t num_locations = 2;
//		CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, num_locations);
//		CGColorSpaceRelease(rgb);
//		
//		start = CGPointMake(160, end.y );
//		end = CGPointMake(160,end.y + 5);
//		CGContextDrawLinearGradient(context, gradient, start, end, 0);
//		
//		CFRelease(gradient);
//		CFRelease(rgb);
//		
//		
//	}
	
	
}




@end
