//
//  YLDialKeyContainerView.m
//  YLTestDemo1
//
//  Created by linms on 16/9/7.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLDialKeyContainerView.h"
@interface YLDialKeyView : NSView
@property (nonatomic, strong) NSTextField *numLabel;
@property (nonatomic, strong) NSTextField *keyLabel;
@end

@implementation YLDialKeyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _numLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _numLabel.bordered = NO;
        _numLabel.editable = NO;
        _numLabel.font = [NSFont systemFontOfSize:25.f];
        _numLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        _numLabel.backgroundColor = [NSColor clearColor];
        _numLabel.alignment = NSTextAlignmentCenter;
        [self addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(5);
            make.leading.greaterThanOrEqualTo(self.mas_leading).with.offset(0);
            make.trailing.greaterThanOrEqualTo(self.mas_trailing).with.offset(0);
        }];
        HUG_V(_numLabel, NSLayoutPriorityRequired);
        
        _keyLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _keyLabel.bordered = NO;
        _keyLabel.editable = NO;
        _keyLabel.backgroundColor = [NSColor clearColor];
        _keyLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        _keyLabel.font = [NSFont systemFontOfSize:10];
        _keyLabel.alignment = NSTextAlignmentCenter;
        [self addSubview:_keyLabel];
        [_keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.lessThanOrEqualTo(self.numLabel.mas_bottom).with.offset(6);
            make.leading.greaterThanOrEqualTo(self.mas_leading).with.offset(0);
            make.trailing.greaterThanOrEqualTo(self.mas_trailing).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        HUG_V(_keyLabel, NSLayoutPriorityRequired);
        
    }
    return self;
}

@end
@implementation YLDialKeyContainerView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor whiteColor].CGColor;
        
        NSMutableArray *group = nil;
        NSMutableArray *groups = [NSMutableArray new];
        NSArray *numberArr = [numberTable componentsSeparatedByString:@","];
        NSArray *keyArr = [keyTable componentsSeparatedByString:@","];
        
        for (int i = 0; i < 12; i++) {
            YLDialKeyView *dialKeyView = [[YLDialKeyView alloc] initWithFrame:CGRectZero];
            
            /* *号键需要单独设置*/
            if (i == 9) {
                NSTextField * numLabel = dialKeyView.numLabel;
                NSTextField *keyLabel = dialKeyView.keyLabel;
                [numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(dialKeyView.mas_centerX);
                    make.centerY.equalTo(dialKeyView.mas_centerY).with.offset(-3);
                }];
                [keyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(dialKeyView.mas_bottom).with.offset(-7);
                    make.centerX.equalTo(dialKeyView.mas_centerX);
                }];
                keyLabel.font = [NSFont systemFontOfSize:28];
            }
            if (i == 0 || i == 10 | i == 11) {
                NSTextField * numLabel = dialKeyView.numLabel;
                NSTextField *keyLabel = dialKeyView.keyLabel;
                [numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(dialKeyView);
                }];
                [keyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(dialKeyView.mas_bottom).with.offset(-7);
                    make.centerX.equalTo(dialKeyView.mas_centerX);
                }];
                keyLabel.font = [NSFont systemFontOfSize:28];
            }
            
            dialKeyView.numLabel.stringValue = numberArr[i];
            dialKeyView.keyLabel.stringValue = keyArr[i];
            
            NSButton *btn = [[NSButton alloc] initWithFrame:CGRectZero];
            dialKeyView.wantsLayer = YES;
            dialKeyView.layer.backgroundColor = [NSColor clearColor].CGColor;
            [btn setImage:[NSImage imageNamed:@"numBtn_hover.png"]];
            [btn setImagePosition:NSImageOnly];
            btn.bordered = NO;
            btn.tag = i;
            // 检测按键弹起做为按键消息会存在快速按键消息遗漏情况，将消息检测机制改成按键按下即发送按键消息
            [btn addSubview:dialKeyView];
            
            [dialKeyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(btn);
            }];
            
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(52, 52));
            }];
            
            /*把视图按行分组,共四组*/
            if ((i%3) == 0) {
                group = [NSMutableArray new];
                [groups addObject:group];
            }
            [group addObject:btn];
        }
        /*定义第一个按扭视图的位置*/
        NSView *firstView = groups[0][0];
        [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading);
            make.top.equalTo(self.mas_top);
        }];
        /*定义最后一个按扭视图的位置*/
        NSView *lastView = [groups.lastObject lastObject];
        [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing);
            make.bottom.equalTo(self.mas_bottom);
        }];
        NSMutableArray *headViews = [NSMutableArray new];
        /*每个行视图组,视图间横向排列,间距15pt*/
        for (int i = 0; i < groups.count; i++) {
            NSArray *group = groups[i];
            //每组视图宽度相等,高度也相等
            [NSView equalHeightForViews:group];
            [NSView equalWidthForViews:group];
            //每组视图上下边缘对齐
            [NSView alignTopAndBottomEdgesOfViews:group];
            //三个视图每个间隔15pt
            [NSView spaceOutViewsHorizontally:group predicate:@"20"];
            [headViews addObject:[group firstObject]];
        }
        /*每行视图的第一个视图组成视图组，视图组间垂直方向首尾相间15pt排列*/
        [NSView spaceOutViewsVertically:headViews predicate:@"12"];
        [NSView alignLeadingAndTrailingEdgesOfViews:headViews];
    }
    return self;
}

@end
