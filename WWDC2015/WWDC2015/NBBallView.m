#import "NBBallView.h"

@implementation NBBallView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 50;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
