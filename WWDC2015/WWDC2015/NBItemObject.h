#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NBItemObject : NSObject

- (instancetype)initWithJSON:(NSDictionary *)json;

@property (nonatomic, strong) UIColor *color;

@end
