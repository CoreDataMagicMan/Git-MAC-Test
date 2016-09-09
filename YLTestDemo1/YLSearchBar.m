//
//  YLSearchBar.m
//  YLTestDemo1
//
//  Created by linms on 16/8/30.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLSearchBar.h"

@implementation YLSearchBar

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.wantsLayer = YES;
    self.layer.contents = (id)[NSImage imageNamed:@"searchBar.png"];
    // Drawing code here.
}
- (BOOL)textShouldBeginEditing:(NSText *)textObject{

    return YES;
}
- (void)textDidBeginEditing:(NSNotification *)notification{
    NSLog(@"begin");
        self.highlighted = YES;
}
- (void)textDidEndEditing:(NSNotification *)notification{
    NSLog(@"end");
        self.highlighted = NO;
}
- (void)textDidChange:(NSNotification *)notification{
    NSLog(@"change userinfo:%@",self.stringValue);
    if ([self.searchDelegate respondsToSelector:@selector(YLSearchBar:didChangeString:)]) {
        [self.searchDelegate YLSearchBar:self didChangeString:self.stringValue];
    }
}
@end
