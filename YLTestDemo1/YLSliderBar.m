//
//  YLSliderBar.m
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLSliderBar.h"

@implementation YLSliderBar

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        //初始化
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor colorFromHexString:@"#04aaa0"].CGColor;
        //添加四个主要功能按钮
        NSButton *callBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        NSImage *callImage = [NSImage imageNamed:@"call_nor.png"];
        [callBtn setImage:callImage];
        [callBtn setImagePosition:NSImageOnly];
        callBtn.bordered = NO;
        callBtn.toolTip = @"呼叫";
        callBtn.tag = 0;
        [callBtn setTarget:self];
        [callBtn setAction:@selector(sliderBtnClicked:)];
        [self addSubview:callBtn];
        [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(76);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(callImage.size);
            
        }];
        
        NSButton *contactBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        NSImage *contactImage = [NSImage imageNamed:@"contact_nor.png"];
        [contactBtn setImage:contactImage];
        [contactBtn setImagePosition:NSImageOnly];
        contactBtn.bordered = NO;
        contactBtn.toolTip = @"联系人";
        contactBtn.tag = 1;
        [contactBtn setTarget:self];
        [contactBtn setAction:@selector(sliderBtnClicked:)];
        [self addSubview:contactBtn];
        [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(callBtn.mas_bottom).offset(76);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(contactImage.size);
        }];
        
        NSButton *recordBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        NSImage *recordImage = [NSImage imageNamed:@"callRec_nor.png"];
        [recordBtn setImage:recordImage];
        [recordBtn setImagePosition:NSImageOnly];
        recordBtn.bordered = NO;
        recordBtn.toolTip = @"记录";
        recordBtn.tag = 2;
        [recordBtn setTarget:self];
        [recordBtn setAction:@selector(sliderBtnClicked:)];
        [self addSubview:recordBtn];
        [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contactBtn.mas_bottom).offset(76);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(recordImage.size);
        }];
        
        NSButton *settingBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        settingBtn.toolTip = @"设置";
        NSImage *settingImage = [NSImage imageNamed:@"setting_nor.png"];
        [settingBtn setImage:settingImage];
        [settingBtn setImagePosition:NSImageOnly];
        settingBtn.bordered = NO;
        settingBtn.tag = 3;
        [self addSubview:settingBtn];
        [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-76);
            make.size.mas_equalTo(settingImage.size);
        }];
        
        
    }
    return self;
}
- (void)sliderBtnClicked:(NSButton *)button{
    if ([self.delegate respondsToSelector:@selector(YLSliderBar:sliderBtnClicked:)]) {
        [self.delegate YLSliderBar:self sliderBtnClicked:button];
    }
    
}
@end
