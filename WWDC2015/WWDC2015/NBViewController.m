#import <CoreMotion/CoreMotion.h>

#import "NBBallView.h"
#import "Neeraj_Baid-Swift.h"
#import "NBItemView.h"
#import "NBViewController.h"
#import "UIView+MaterialDesign.h"

#define NBBallViewSpacing 0

@interface NBViewController () <NBBallViewDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) NSArray *views;

@end

@implementation NBViewController

- (NSArray *)views {
    if (!_views) {
        _views = [NSArray array];
    }
    return _views;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.views.count == 0) {
        [self setupViews];
    }
}

- (void)setupViews {
    self.view.layer.cornerRadius = 8;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"json"];
    NSArray *rawData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath]
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
    NSInteger numCols = (self.view.bounds.size.width + NBBallViewSpacing) / (NBBallViewWidth + NBBallViewSpacing) - 1;
    for (NSInteger i = 0; i < rawData.count; i++) {
        NSDictionary *datum = rawData[i];
        NSInteger x = i % numCols;
        NSInteger y = i / numCols;
        CGRect frame = CGRectMake(x*(NBBallViewWidth + NBBallViewSpacing),
                                  y*(NBBallViewWidth + NBBallViewSpacing),
                                  NBBallViewWidth, NBBallViewWidth);
        CGFloat shift = (y % 2) > 0 ? 0 : (NBBallViewWidth + NBBallViewSpacing)/2.0;
        frame.origin.x += shift;
        NBItemObject *item = [[NBItemObject alloc] initWithJson:datum];
        NBBallView *ballView = [[NBBallView alloc] initWithFrame:frame item:item];
        ballView.delegate = self;
        ballView.alpha = 0;
        [self.view addSubview:ballView];
        self.views = [self.views arrayByAddingObject:ballView];
    }
    [UIView animateWithDuration:0.2 animations:^{
        for (NBBallView *ballView in self.views) {
            ballView.alpha = 1;
        }
    } completion:^(BOOL finished) {
        [self setupAnimators];
    }];
}

- (void)setupAnimators {
    self.motionManager = [[CMMotionManager alloc] init];
    if (self.motionManager.accelerometerAvailable) {
        self.motionManager = [[CMMotionManager alloc] init];
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                                withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                    self.gravity.gravityDirection = CGVectorMake(motion.gravity.x, -motion.gravity.y);
                                                }];
    }
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.views];
    elasticityBehavior.elasticity = 0.6f;
    [self.animator addBehavior:elasticityBehavior];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:self.views];
    [self.animator addBehavior:self.gravity];
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.views];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
}

#pragma mark - NBBallViewDelegate

- (void)ballView:(NBBallView *)ballView wasSelectedWithItemObject:(NBItemObject *)itemObject {
    NBItemView *itemView = [[NBItemView alloc] initWithFrame:self.view.frame itemObject:itemObject];
    __weak NBItemView *weakItemView = itemView;
    NSArray *behaviors = self.animator.behaviors;
    itemView.closeBlock = ^{
        [UIView mdDeflateTransitionFromView:weakItemView
                                     toView:self.view
                              originalPoint:ballView.center
                                   duration:0.4
                                 completion:^{
                                     for (UIDynamicBehavior *behavior in behaviors) {
                                         [self.animator addBehavior:behavior];
                                     }
                                 }];
    };
    [self.animator removeAllBehaviors];
    self.view.userInteractionEnabled = NO;
    itemView.userInteractionEnabled = NO;
    [UIView mdInflateTransitionFromView:self.view
                                 toView:itemView
                          originalPoint:ballView.center
                               duration:0.4
                             completion:^{
                                 self.view.userInteractionEnabled = YES;
                                 itemView.userInteractionEnabled = YES;
                             }];
}

@end
