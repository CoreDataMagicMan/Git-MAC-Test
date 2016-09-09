//
//  YLCallLogInfoElementView.m
//  YLTestDemo1
//
//  Created by linms on 16/9/1.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLCallLogInfoElementView.h"

@implementation YLCallLogInfoElementView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        //包含一个title 和 subtitle
        _titleLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        _titleLabel.editable = NO;
        _titleLabel.bordered = NO;
        _titleLabel.backgroundColor = [NSColor whiteColor];
        _titleLabel.font = [NSFont systemFontOfSize:16.f];
        [self addSubview:_titleLabel];
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(82);
        }];
        
        _subTitleLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        _subTitleLabel.editable = NO;
        _subTitleLabel.bordered = NO;
        _subTitleLabel.backgroundColor = [NSColor whiteColor];
        _subTitleLabel.font = [NSFont systemFontOfSize:16.f];
        [self addSubview:_subTitleLabel];
        [_subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_right);
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
@end
