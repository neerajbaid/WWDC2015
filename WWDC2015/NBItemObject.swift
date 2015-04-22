import Foundation
import UIKit
import CoreLocation

@objc class NBItemObject : NSObject {
    var bodyLinks: NSArray
    var category: NSString
    var color: UIColor
    var coordinate: CLLocationCoordinate2D
    var itemDescription: NSString
    var imageName: NSString
    var mapTitle: NSString
    var name: NSString
    var titleLinks: NSArray
    var textForBodyLinks: NSArray
    var textForTitleLinks: NSArray
    
    init(json: NSDictionary) {
        if (json["body_links"] != nil) {
            self.bodyLinks = json["body_links"] as! NSArray
        } else {
            self.bodyLinks = []
        }
        self.category = (json["category"] as! NSString)
        self.color = UIColor(
            red: CGFloat(json["red"]!.floatValue/255),
            green: CGFloat(json["green"]!.floatValue/255),
            blue: CGFloat(json["blue"]!.floatValue/255),
            alpha: CGFloat(1))
        self.coordinate = CLLocationCoordinate2DMake(json["latitude"]!.doubleValue, json["longitude"]!.doubleValue)
        self.itemDescription = json["description"] as! NSString
        if (json["image"] != nil) {
        self.imageName = json["image"] as! NSString
        } else {
            self.imageName = ""
        }
        if (json["map_title"] != nil) {
            self.mapTitle = json["map_title"] as! NSString
        } else {
            self.mapTitle = ""
        }
        self.name = (json["name"] as! NSString)
        if (json["title_links"] != nil) {
            self.titleLinks = (json["title_links"] as! NSArray)
        } else {
            self.titleLinks = []
        }
        if (json["text_for_body_links"] != nil) {
            self.textForBodyLinks = json["text_for_body_links"] as! NSArray
        } else {
            self.textForBodyLinks = []
        }
        if (json["text_for_title_links"] != nil) {
            self.textForTitleLinks = json["text_for_title_links"] as! NSArray
        } else {
            self.textForTitleLinks = []
        }
    }
}