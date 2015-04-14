#import <MapKit/MapKit.h>

#import "NBItemObject.h"
#import "NBItemView.h"
#import "NBMapViewAnnotation.h"

@interface NBItemView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation NBItemView

- (instancetype)initWithFrame:(CGRect)frame itemObject:(NBItemObject *)item {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self options:nil] firstObject];
    if (self) {
        self.frame = frame;
        self.backgroundColor = item.color;
        self.titleLabel.text = item.name;
        self.descriptionLabel.text = item.itemDescription;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.05;
        MKCoordinateRegion region = MKCoordinateRegionMake(item.coordinate, span);
        [self.mapView setRegion:region animated:NO];
        NBMapViewAnnotation *annotation = [[NBMapViewAnnotation alloc] initWithCoordinate:item.coordinate
                                                                                     name:item.mapTitle];
        [self.mapView addAnnotation:annotation];
        [self.mapView selectAnnotation:annotation animated:YES];
        self.mapView.layer.cornerRadius = 5;
    }
    return self;
}

- (IBAction)close:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
        self.closeBlock = nil;
    }
}

@end
