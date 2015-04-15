#import "NBItemObject.h"

@implementation NBItemObject

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        self.coordinate = CLLocationCoordinate2DMake([json[@"latitude"] doubleValue],
                                                     [json[@"longitude"] doubleValue]);
        self.itemDescription = json[@"description"];
        self.category = json[@"category"];
        self.name = json[@"name"];
        self.color = [UIColor colorWithRed:[json[@"red"] integerValue]/255.0
                                     green:[json[@"green"] integerValue]/255.0
                                      blue:[json[@"blue"] integerValue]/255.0
                                     alpha:1];
        self.titleLinks = json[@"title_links"];
        self.textForTitleLinks = json[@"text_for_title_links"];
        self.bodyLinks = json[@"body_links"];
        self.textForBodyLinks = json[@"text_for_body_links"];
        self.mapTitle = json[@"map_title"];
        self.imageName = json[@"image"];
    }
    return self;
}

@end
