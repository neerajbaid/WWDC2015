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
        self.layer.masksToBounds = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                               self.frame.size.width,
                                                                               self.frame.size.height)];
        [self addSubview:imageView];
        if (self.item.imageName) {
            imageView.image = [UIImage imageNamed:self.item.imageName];
        }
    }
    return self;
}

- (void)tapped:(id)sender {
    [self.delegate ballView:self
  wasSelectedWithItemObject:self.item];
}

@end
