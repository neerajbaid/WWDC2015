#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface NBMapViewAnnotation : NSObject <MKAnnotation>

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate name:(NSString *)title;

@end
