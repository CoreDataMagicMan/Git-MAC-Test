//
//  NSColor+Common.m
//  YLTestDemo1
//
//  Created by linms on 16/9/6.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "NSColor+Common.h"

@implementation NSColor (Common)
+ (NSColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // 过滤 '#' 字符
    [scanner scanHexInt:&rgbValue];
    return [NSColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end
