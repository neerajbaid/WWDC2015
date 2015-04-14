#import "UIColor+WWDC2015.h"

@implementation UIColor (WWDC2015)

- (double)perceptiveLuminance {
    CGColorRef color = [self CGColor];
    const CGFloat *components = CGColorGetComponents(color);
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    return 1 - (0.299 * red + 0.587 * green + 0.114 * blue);
}

+ (UIColor *)blackOrWhiteFromColor:(UIColor *)color {
    float perceptiveLuminance = [color perceptiveLuminance];
    if (perceptiveLuminance > 0.5) {
        return [UIColor whiteColor];
    } else {
        return [UIColor blackColor];
    }
}

@end
