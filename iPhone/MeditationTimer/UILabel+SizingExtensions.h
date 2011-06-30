#import <Foundation/Foundation.h>

@interface UILabel ( SizingExtensions ) 
- (CGFloat)heightForCurrentWidthWithText;

-(void)resizeToCurrentText;


- (CGFloat)widthForCurrentHeightWithText;
-(void)resizeWidthToCurrentText;

- (CGFloat)heightForCurrentWidthWithText:(NSString *)text;

-(void)moveToRightOfLabel:(UILabel *)otherLabel;
@end
