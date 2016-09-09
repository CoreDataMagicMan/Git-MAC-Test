//
//  NSButton+Extension.m
//  YLTestDemo1
//
//  Created by linms on 16/9/2.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "NSButton+Extension.h"

@implementation NSButton (Extension)
- (void)setAttributedTitleWithColor:(NSColor *)color{
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc]
                                            initWithAttributedString:self.attributedTitle];
    NSInteger len = [attrTitle length];
    NSRange range = NSMakeRange(0, len);
    [attrTitle addAttribute:NSForegroundColorAttributeName
                      value:color
                      range:range];
    [attrTitle fixAttributesInRange:range];
    self.attributedTitle = attrTitle;
}
- (void)setBackgroundColor:(NSColor *)color{
    self.wantsLayer = YES;
    self.layer.backgroundColor = color.CGColor;
}

@end
