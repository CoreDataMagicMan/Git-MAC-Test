//
// Created by florian on 26.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#ifndef FLK_VIEW
#define FLK_VIEW UIView
#endif
#ifndef FLK_COLOR
#define FLK_COLOR UIColor
#endif
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#ifndef FLK_VIEW
#define FLK_VIEW NSView
#endif
#ifndef FLK_COLOR
#define FLK_COLOR NSColor
#endif
#endif

typedef struct {
    NSLayoutRelation relation;
    CGFloat multiplier;
    CGFloat constant;
    NSLayoutPriority priority;
} FLKAutoLayoutPredicate;

FOUNDATION_EXTERN FLKAutoLayoutPredicate FLKAutoLayoutPredicateMake(NSLayoutRelation relation, CGFloat multiplier, CGFloat constant, NSLayoutPriority priority);

@interface FLK_VIEW (FLKAutoLayoutPredicate)

- (NSLayoutConstraint*)applyPredicate:(FLKAutoLayoutPredicate)predicate toView:(NSView*)toView attribute:(NSLayoutAttribute)attribute;
- (NSLayoutConstraint*)applyPredicate:(FLKAutoLayoutPredicate)predicate toView:(NSView*)view fromAttribute:(NSLayoutAttribute)fromAttribute toAttribute:(NSLayoutAttribute)toAttribute;

@end
