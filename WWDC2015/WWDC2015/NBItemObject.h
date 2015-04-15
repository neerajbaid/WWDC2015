#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NBItemObject : NSObject

- (instancetype)initWithJSON:(NSDictionary *)json;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *category;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSArray *titleLinks;
@property (nonatomic, strong) NSArray *textForTitleLinks;
@property (nonatomic, strong) NSArray *bodyLinks;
@property (nonatomic, strong) NSArray *textForBodyLinks;
@property (nonatomic, strong) NSString *mapTitle;
@property (nonatomic, strong) NSString *imageName;

@end
