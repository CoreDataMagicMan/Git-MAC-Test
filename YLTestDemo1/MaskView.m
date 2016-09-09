//
//  MaskView.m
//  YLTestDemo1
//
//  Created by linms on 16/8/25.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView
- (void)dealloc
{
    //当该遮罩层被移除时发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MaskViewNotification" object:@NO];
    
}
- (instancetype)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor colorWithWhite:0 alpha:0.5].CGColor;
        [self becomeFirstResponder];
    }
    return self;
}

-(void)updateTrackingAreas{
    
//    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveInKeyWindow;
//    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
//                                                                options:options
//                                                                  owner:self
//                                                               userInfo:nil];
//    [self addTrackingArea:trackingArea];
}

- (void)viewDidMoveToSuperview
{
    //当遮罩层添加到window上，其父视图由nil->window发生改变，触发该方法调用
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MaskViewNotification" object:@YES];
    
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)theEvent
{
    
}

- (void)mouseUp:(NSEvent *)theEvent
{
    
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    
}

- (void)mouseMoved:(NSEvent *)theEvent
{
    
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    
}
- (void)mouseExited:(NSEvent *)theEvent
{
    
}


@end
