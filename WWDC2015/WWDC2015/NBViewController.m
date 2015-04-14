#import "NBBallView.h"
#import "NBViewController.h"

@interface NBViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation NBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    NBBallView *view = [[NBBallView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:view];
    NBBallView *view2 = [[NBBallView alloc] initWithFrame:CGRectMake(0, 200, 100, 100)];
    [self.view addSubview:view2];
    NSArray *views = @[view, view2];
    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:views];
    elasticityBehavior.elasticity = 0.6f;
    [self.animator addBehavior:elasticityBehavior];
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:views];
    [self.animator addBehavior:gravity];
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:views];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
}

@end
