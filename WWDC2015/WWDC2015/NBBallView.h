#import <UIKit/UIKit.h>

#define NBBallViewWidth 80

@class NBBallView;
@class NBItemObject;
@protocol NBBallViewDelegate <NSObject>

- (void)ballView:(NBBallView *)ballView wasSelectedWithItemObject:(NBItemObject *)itemObject;

@end

@interface NBBallView : UIView

- (instancetype)initWithFrame:(CGRect)frame item:(NBItemObject *)item;

@property (nonatomic, weak) id<NBBallViewDelegate> delegate;

@end
