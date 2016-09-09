//
// Created by Florian on 20.07.13.
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

@interface FLK_VIEW (FLKAutoLayoutDebug)

@property (nonatomic, strong) NSString *flk_nameTag;
- (void)flk_hasAmbiguousLayoutLayoutTrace:(BOOL)recursive;
- (void)flk_exerciseAmbiguityInLayout:(BOOL)recursive;
- (NSString *)flk_autolayoutTrace;

@end