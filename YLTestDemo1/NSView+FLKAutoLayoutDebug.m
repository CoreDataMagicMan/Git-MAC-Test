//
// Created by Florian on 20.07.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSView+FLKAutoLayoutDebug.h"
#import <objc/runtime.h>

static const CGFloat ExerciseAmbiguityInterval = .5;
static char *const NameTagKey = "flk_nameTag";


@implementation FLK_VIEW (FLKAutoLayoutDebug)

- (void)flk_exerciseAmbiguityInLayout:(BOOL)recursive
{
#ifdef DEBUG
    if (self.hasAmbiguousLayout) {
        [NSTimer scheduledTimerWithTimeInterval:ExerciseAmbiguityInterval target:self selector:@selector(flk_changeAmbiguousLayout) userInfo:nil repeats:YES];
    }
    if (recursive) {
        for (FLK_VIEW *subview in self.subviews) {
            [subview flk_exerciseAmbiguityInLayout:recursive];
        }
    }
#endif
}

- (void)flk_hasAmbiguousLayoutLayoutTrace:(BOOL)recursive
{
#ifdef DEBUG
    if (self.hasAmbiguousLayout) {
        [NSTimer scheduledTimerWithTimeInterval:ExerciseAmbiguityInterval target:self selector:@selector(flk_changeBgColorRandom) userInfo:nil repeats:YES];
    }
    if (recursive) {
        for (FLK_VIEW *subview in self.subviews) {
            [subview flk_hasAmbiguousLayoutLayoutTrace:recursive];
        }
    }
#endif
}

- (void)flk_changeBgColorRandom
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 );
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    NSColor *color = [NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    self.wantsLayer = YES;
    self.layer.backgroundColor = color.CGColor;
}

- (void)flk_changeAmbiguousLayout
{
#ifdef DEBUG
    [self exerciseAmbiguityInLayout];
#endif
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (NSString *)flk_autolayoutTrace
{
#ifdef DEBUG
    // appstore
#if 1
    if ([self respondsToSelector:@selector(_autolayoutTrace)]) {
        return [self performSelector:@selector(_autolayoutTrace)];
    }
#endif
#endif
    return nil;
}
#pragma clang diagnostic pop

- (void)setFlk_nameTag:(NSString *)nameTag
{
    objc_setAssociatedObject(self, NameTagKey, nameTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)flk_nameTag
{
    return objc_getAssociatedObject(self, NameTagKey);
}

@end