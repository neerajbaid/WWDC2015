#import <CoreMotion/CoreMotion.h>

#import "NBBallView.h"
#import "NBItemObject.h"
#import "NBItemView.h"
#import "NBViewController.h"
#import "UIView+MaterialDesign.h"

#define NBBallViewSpacing 16

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupAnimators];
}

- (void)setupViews {
    self.view.layer.cornerRadius = 8;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"json"];
    NSArray *rawData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath]
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
    NSInteger numCols = (self.view.bounds.size.width + NBBallViewSpacing) / (NBBallViewWidth + NBBallViewSpacing);
    for (NSInteger i = 0; i < rawData.count; i++) {
        NSDictionary *datum = rawData[i];
        NSInteger x = i % numCols;
        NSInteger y = i / numCols;
        CGRect frame = CGRectMake(x*(NBBallViewWidth + NBBallViewSpacing),
                                  y*(NBBallViewWidth + NBBallViewSpacing),
                                  NBBallViewWidth, NBBallViewWidth);
        CGFloat shift = (y % 2) > 0 ? 0 : (NBBallViewWidth + NBBallViewSpacing)/2.0;
        frame.origin.x += shift;
        NBItemObject *item = [[NBItemObject alloc] initWithJSON:datum];
        NBBallView *ballView = [[NBBallView alloc] initWithFrame:frame item:item];
        ballView.delegate = self;
        [self.view addSubview:ballView];
        self.views = [self.views arrayByAddingObject:ballView];
    }
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
    NSArray *behaviors = self.animator.behaviors;
    itemView.closeBlock = ^{
        [UIView mdDeflateTransitionFromView:itemView
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
    [UIView mdInflateTransitionFromView:self.view
                                 toView:itemView
                          originalPoint:ballView.center
                               duration:0.4
                             completion:nil];
}

@end
