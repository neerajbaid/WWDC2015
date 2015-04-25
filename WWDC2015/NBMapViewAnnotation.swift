import MapKit
import Foundation

@objc class NBMapViewAnnotation : NSObject, MKAnnotation {
    var title: String
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D, name:NSString) {
        self.title = name as String;
        self.coordinate = coordinate;
    }
}