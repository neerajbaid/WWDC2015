#import <UIKit/UIKit.h>

@interface NBItemView : UIView

- (instancetype)initWithFrame:(CGRect)frame itemObject:(NBItemObject *)item;

@property (nonatomic, copy) void (^closeBlock)(void);

@end
