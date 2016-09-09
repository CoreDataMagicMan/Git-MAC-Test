//
//  YLTextField.m
//  YLTestDemo1
//
//  Created by lms on 16/9/8.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLTextField.h"

@interface YLTextField ()
@end
@implementation YLTextField
- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        [self setUsesSingleLineMode:YES];
        [self.cell setScrollable:YES];
        self.focusRingType = NSFocusRingTypeNone;
    }
    return self;
}
- (BOOL)becomeFirstResponder
{
    NSView *bgView = self.superview;
    bgView.wantsLayer = YES;
    bgView.layer.borderWidth = 1.5;
    bgView.layer.borderColor = _selectedBorderColor.CGColor;
    return YES;
}
- (void)textDidEndEditing:(NSNotification *)notification{
    NSView *bgView = self.superview;
    bgView.wantsLayer = YES;
    bgView.layer.borderWidth = 1.5;
    bgView.layer.borderColor = _normalBorderColor.CGColor;
}
@end
