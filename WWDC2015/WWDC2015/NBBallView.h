#import <UIKit/UIKit.h>

#define NBBallViewWidth 100

@class NBItemObject;
@interface NBBallView : UIView

- (instancetype)initWithFrame:(CGRect)frame item:(NBItemObject *)item;

@end
