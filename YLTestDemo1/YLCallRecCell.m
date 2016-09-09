//
//  YLCallRecCell.m
//  YLTestDemo1
//
//  Created by linms on 16/9/1.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLCallRecCell.h"
@interface YLCallRecCell (){
    BOOL _disableTracking;
}
@property (nonatomic, assign) BOOL isEnterCell;
@end
@implementation YLCallRecCell
- (void)dealloc{
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
    _callLogLabel.font = [NSFont systemFontOfSize:16];
    _callLogLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
    _dateLabel.font = [NSFont systemFontOfSize:13];
    _dateLabel.textColor = [NSColor colorFromHexString:@"#777777"];
    // Drawing code here.
}
- (void)mouseEntered:(NSEvent *)theEvent{
    //
    if (_disableTracking) return;
    if (!self.isEnterCell) {
        self.layer.backgroundColor = [NSColor colorWithRed:0 green:0 blue:0 alpha:0.2f].CGColor;
        self.callLogLabel.textColor = [NSColor whiteColor];
        self.dateLabel.textColor = [NSColor whiteColor];
        self.isEnterCell = YES;
        NSPoint location = [theEvent locationInWindow];
        NSPoint newPoint = [self.window.contentView convertPoint:location fromView:nil];
        if ([self.delegate respondsToSelector:@selector(YLCallRecCell:mouseExitPoint: isShowOrHidden:)]) {
            [self.delegate YLCallRecCell:self mouseExitPoint:newPoint isShowOrHidden:YES];
        }
    }
}
- (void)mouseExited:(NSEvent *)theEvent{
    if (_disableTracking) return;
    if (self.isEnterCell) {
        self.accessibilitySelected = NO;
        self.layer.backgroundColor = [NSColor clearColor].CGColor;
        self.callLogLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        self.dateLabel.textColor = [NSColor colorFromHexString:@"#777777"];
        self.isEnterCell = NO;
        NSPoint location = [theEvent locationInWindow];
        NSPoint newPoint = [self.window.contentView convertPoint:location fromView:nil];
        if ([self.delegate respondsToSelector:@selector(YLCallRecCell:mouseExitPoint: isShowOrHidden:)]) {
            [self.delegate YLCallRecCell:self mouseExitPoint:newPoint isShowOrHidden:NO];
        }
    }
}
- (void)handleMaskViewNotification:(NSNotification*)note
{
    BOOL boolValue = [note.object boolValue];
    _disableTracking = boolValue;
}

@end
