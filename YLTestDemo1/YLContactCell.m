//
//  YLContactCell.m
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLContactCell.h"
@interface YLContactCell(){
    BOOL _disableTracking;
   
}
@property (nonatomic, assign, readwrite) BOOL isEnterCell;
@end
@implementation YLContactCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)updateTrackingAreas{
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveInKeyWindow|NSTrackingActiveWhenFirstResponder;
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                                options:options
                                                                  owner:self
                                                               userInfo:nil];
    [self addTrackingArea:trackingArea];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMaskViewNotification:) name:@"MaskViewNotification" object:nil];
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.isEnterCell = NO;
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
    _nameLabel.font = [NSFont systemFontOfSize:16];
    _nameLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
    _numberLabel.font = [NSFont systemFontOfSize:13];
    _numberLabel.textColor = [NSColor colorFromHexString:@"#777777"];
    // Drawing code here.
}
- (void)mouseEntered:(NSEvent *)theEvent{
    
    if (_disableTracking) return;
    if (!self.isEnterCell) {
        self.layer.backgroundColor = [NSColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
        self.nameLabel.textColor = [NSColor whiteColor];
        self.numberLabel.textColor = [NSColor whiteColor];
        self.isEnterCell = YES;
        NSPoint location = [theEvent locationInWindow];
        NSPoint newPoint = [self.window.contentView convertPoint:location fromView:nil];
        if ([self.delegate respondsToSelector:@selector(YLContactCell:isShowOrHidden:ExitPoint:)]) {
            [self.delegate YLContactCell:self isShowOrHidden:YES ExitPoint:newPoint];
        }
    }
}
- (void)mouseExited:(NSEvent *)theEvent{
    if (_disableTracking) return;
    if (self.isEnterCell) {
        self.accessibilitySelected = NO;
        self.layer.backgroundColor = [NSColor clearColor].CGColor;
        self.nameLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        self.numberLabel.textColor = [NSColor colorFromHexString:@"#777777"];
        self.isEnterCell = NO;
        NSPoint location = [theEvent locationInWindow];
        NSPoint newPoint = [self.window.contentView convertPoint:location fromView:nil];
        if ([self.delegate respondsToSelector:@selector(YLContactCell:isShowOrHidden:ExitPoint:)]) {
            [self.delegate YLContactCell:self isShowOrHidden:NO ExitPoint:newPoint];
        }
    }
}

- (void)handleMaskViewNotification:(NSNotification*)note
{
    BOOL boolValue = [note.object boolValue];
    _disableTracking = boolValue;
}
@end
