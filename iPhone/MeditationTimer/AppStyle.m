//
//  AppStyle.m
//  Panic
//
//  Created by David Clements on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppStyle.h"


@implementation AppStyle


+(UIColor *)highlightedNormalButtonColor;
{
   	return [UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:1.0f];
}

+(UIColor *)normalButtonColor;
{
	return [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
}

+(UIColor *)canceButtonColor;
{
	return [UIColor colorWithRed:0.9f green:0.0f blue:0.0f alpha:1.0f];
}

+(UIColor *)highlightedCancelButtonColor;
{
	return [UIColor colorWithRed:153.0/255.0f green:5.0/255.0f blue:5.0/255.0f alpha:1.0f];
}

+(UIColor *)yellowColor;
{
    return [UIColor colorWithHexString:@"f6f600"];	
}

+(UIColor *)whiteColor;
{
    return [UIColor colorWithHexString:@"FFFFFF"];	
}

+(UIColor *)grayColor;
{
    return [UIColor colorWithHexString:@"c5c5c5"];	
}

+(UIColor *)darkGrayColor;
{
	return [UIColor colorWithHexString:@"424242"];	

}

+(UIColor *)blackColor;
{
    return [UIColor colorWithHexString:@"000000"];	
}



@end
