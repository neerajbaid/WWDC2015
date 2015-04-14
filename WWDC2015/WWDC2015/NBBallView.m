#import "NBBallView.h"
#import "NBItemObject.h"

@interface NBBallView ()

@property (nonatomic, strong) NBItemObject *item;

@end

@implementation NBBallView

- (instancetype)initWithFrame:(CGRect)frame item:(NBItemObject *)item {
    self = [super initWithFrame:frame];
    if (self) {
        self.item = item;
        self.layer.cornerRadius = NBBallViewWidth/2;
        self.backgroundColor = self.item.color;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
    }
    return self;
}

- (void)tapped:(id)sender {
    [self.delegate ballView:self
  wasSelectedWithItemObject:self.item];
}

@end
