#import <CoreText/CoreText.h>
#import <MapKit/MapKit.h>

#import "Neeraj_Baid-Swift.h"
#import "NBItemView.h"
#import "NBMapViewAnnotation.h"
#import "UIColor+WWDC2015.h"

@interface NBItemView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *coolButton;
@property (weak, nonatomic) IBOutlet UIView *closeView;

@end

@implementation NBItemView

- (instancetype)initWithFrame:(CGRect)frame itemObject:(NBItemObject *)item {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self options:nil] firstObject];
    if (self) {
        self.layer.cornerRadius = 8;
        self.frame = frame;
        self.backgroundColor = item.color;
        self.mapView.userInteractionEnabled = NO;
        UIColor *textColor = [UIColor blackOrWhiteFromColor:item.color];
        self.titleLabel.text = item.name;
        self.descriptionLabel.text = item.itemDescription;
        [self.titleLabel setTextColor:textColor];
        [self.descriptionLabel setTextColor:textColor];
        CGRect expectedLabelSize = [item.itemDescription boundingRectWithSize:CGSizeMake(self.descriptionLabel.frame.size.width, 10000.0)
                                                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                                   attributes:@{NSFontAttributeName:self.descriptionLabel.font}
                                                                      context:nil];
        CGRect newFrame = self.descriptionLabel.frame;
        newFrame.size.height = expectedLabelSize.size.height;
        newFrame.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8;
        self.descriptionLabel.frame = newFrame;
        CGRect newMapFrame = self.mapView.frame;
        newMapFrame.origin.y = newFrame.origin.y + newFrame.size.height + 8;
        self.mapView.frame = newMapFrame;
        CGRect newCoolFrame = self.coolButton.frame;
        newCoolFrame.origin.y = newMapFrame.origin.y + newMapFrame.size.height + 8;
        self.coolButton.frame = newCoolFrame;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.05;
        MKCoordinateRegion region = MKCoordinateRegionMake(item.coordinate, span);
        [self.mapView setRegion:region animated:NO];
        NBMapViewAnnotation *annotation = [[NBMapViewAnnotation alloc] initWithCoordinate:item.coordinate
                                                                                     name:item.mapTitle];
        [self.mapView addAnnotation:annotation];
        [self.mapView selectAnnotation:annotation animated:YES];
        self.mapView.layer.cornerRadius = 5;
        [self.coolButton setTitleColor:textColor forState:UIControlStateNormal];
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                  action:@selector(longPressClose:)];
        longPressGR.minimumPressDuration = 0.001;
        [self.closeView addGestureRecognizer:longPressGR];
    }
    return self;
}

#pragma mark - Actions

- (void)longPressClose:(UILongPressGestureRecognizer *)longPressGR {
    if (longPressGR.state == UIGestureRecognizerStateBegan) {
        [self close:nil];
    }
}

- (IBAction)close:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
        self.closeBlock = nil;
    }
}

@end

