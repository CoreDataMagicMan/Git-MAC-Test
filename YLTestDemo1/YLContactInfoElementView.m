//
//  YLContactInfoElementView.m
//  YLTestDemo1
//
//  Created by linms on 16/8/25.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLContactInfoElementView.h"

@implementation YLContactInfoElementView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor clearColor].CGColor;
        
        _titleLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        _titleLabel.font = [NSFont systemFontOfSize:16.f];
        _titleLabel.backgroundColor = [NSColor clearColor];
        _titleLabel.bordered = NO;
        _titleLabel.editable = NO;
        [self addSubview:_titleLabel];
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(82);
        }];
        
        _numLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = [NSColor colorFromHexString:@"#00a9f0"];
        _numLabel.font = [NSFont systemFontOfSize:16.f];
        _numLabel.backgroundColor = [NSColor clearColor];
        _numLabel.bordered = NO;
        _numLabel.editable = NO;
        [self addSubview:_numLabel];
        [_numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
    }
    return self;
}
@end
