#import "NBBallView.h"
#import "NBItemObject.h"

@implementation NBBallView

- (instancetype)initWithFrame:(CGRect)frame item:(NBItemObject *)item {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 50;
        self.backgroundColor = item.color;
    }
    return self;
}

@end
