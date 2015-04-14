#import "NBItemObject.h"

@implementation NBItemObject

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        self.color = [UIColor colorWithRed:[json[@"red"] integerValue]/255.0
                                     green:[json[@"green"] integerValue]/255.0
                                      blue:[json[@"blue"] integerValue]/255.0
                                     alpha:1];
    }
    return self;
}

@end
