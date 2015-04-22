#import "NBMapViewAnnotation.h"

@interface NBMapViewAnnotation ()

@property (nonatomic) NSString *title;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation NBMapViewAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate name:(NSString *)name {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.title = name;
    }
    return self;
}

@end
