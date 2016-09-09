//
//  NSColor+Common.h
//  YLTestDemo1
//
//  Created by linms on 16/9/6.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (Common)
/**
 *  把一个十六进制字符串转为UIColor对象
 *
 *  @param hexString 十六进制字符串,以"#"开头
 *
 *  @return UIColor对象
 */
+ (NSColor *)colorFromHexString:(NSString *)hexString;
@end
