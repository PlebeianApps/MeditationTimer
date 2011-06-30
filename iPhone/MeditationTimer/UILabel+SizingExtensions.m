
#import "UILabel+SizingExtensions.h"


@implementation UILabel (SizingExtensions)

// numberOfLines must be greater than 1 (hopefully like 10 or something)
// wordWrapeMode must be on
- (CGFloat)heightForCurrentWidthWithText
{
	return [self heightForCurrentWidthWithText:self.text];
}


- (CGFloat)heightForCurrentWidthWithText:(NSString *)text{
	NSInteger maximumHeight = NSIntegerMax;
	CGSize maximumSize = CGSizeMake(self.frame.size.width, maximumHeight);
	return [text sizeWithFont:self.font constrainedToSize:maximumSize].height;	
}


-(void)resizeToCurrentText{
	CGRect frame = self.frame;
	
	frame.size.height = [self heightForCurrentWidthWithText];
    self.frame = frame;	
	
}
- (CGFloat)widthForCurrentHeightWithText
{
	NSInteger maximumWidth = NSIntegerMax;
	CGSize maximumSize = CGSizeMake( maximumWidth, self.frame.size.height);
	return [self.text sizeWithFont:self.font constrainedToSize:maximumSize].width;	
}

-(void)moveToRightOfLabel:(UILabel *)otherLabel{

	CGRect frame = otherLabel.frame;
	frame.origin.x = frame.origin.x + frame.size.width;
	self.frame = frame;
	
}

-(void)moveBelowView:(UIView *)otherView{
	
	CGRect frame = otherView.frame;
	frame.origin.y = frame.origin.y + frame.size.height;
	self.frame = frame;
}

-(void)resizeWidthToCurrentText{
	CGRect frame = self.frame;
	
	frame.size.width = [self widthForCurrentHeightWithText];
    self.frame = frame;	
	
}

@end
