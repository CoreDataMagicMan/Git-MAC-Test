//
//  YLDialPadView.m
//  YLTestDemo1
//
//  Created by linms on 16/9/7.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLDialPadView.h"
#import "YLDialKeyContainerView.h"
@interface YLDialPadView ()
@property (nonatomic, strong) YLDialKeyContainerView *dialKeyContainerView;
@end
@implementation YLDialPadView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    [self createSubView];
}
- (void)createSubView{
    NSView *topView = [[NSView alloc] initWithFrame:CGRectZero];
    topView.wantsLayer = YES;
    topView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [self addSubview:topView];
    [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    //删除键
    _inputBackBtn = [[NSButton alloc] initWithFrame:CGRectZero];
    _inputBackBtn.bordered = NO;
    NSImage *inputBackImage = [NSImage imageNamed:@"backInputBtn_nor.png"];
    [_inputBackBtn setImage:inputBackImage];
    [_inputBackBtn setImagePosition:NSImageOnly];
    [topView addSubview:_inputBackBtn];
    [_inputBackBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-10);
        make.centerY.equalTo(topView.mas_centerY);
        make.size.mas_equalTo(inputBackImage.size);
    }];
    //输入框
    NSView *textFieldView = [[NSView alloc] initWithFrame:CGRectZero];
    textFieldView.wantsLayer = YES;
    textFieldView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    textFieldView.layer.borderWidth = 1.5;
    textFieldView.layer.borderColor = [NSColor clearColor].CGColor;
    textFieldView.layer.cornerRadius = 4.f;
    textFieldView.layer.masksToBounds = YES;
    [self addSubview:textFieldView];
    [textFieldView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView);
        make.top.equalTo(topView.mas_top).offset(5);
        make.bottom.equalTo(topView.mas_bottom).offset(-5);
        make.right.equalTo(_inputBackBtn.mas_left).offset(-2);
    }];
    
    _inputTextField = [[YLTextField alloc] initWithFrame:CGRectZero];
    _inputTextField.bordered = NO;
    _inputTextField.placeholderString = @"Enter Number";
    _inputTextField.normalBorderColor = [NSColor clearColor];
    _inputTextField.selectedBorderColor = [NSColor clearColor];
    _inputTextField.font = [NSFont systemFontOfSize:20.f];
    _inputTextField.textColor = [NSColor colorFromHexString:@"#c0c0c0"];
    [textFieldView addSubview:_inputTextField];
    [_inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(textFieldView);
        make.left.equalTo(textFieldView.mas_left).offset(18);
        make.right.equalTo(textFieldView.mas_right).offset(-5);
    }];
    //分割线
    NSView *spliteLine = [[NSView alloc] initWithFrame:CGRectZero];
    spliteLine.wantsLayer = YES;
    spliteLine.layer.backgroundColor = RGBA(0, 0, 0, 0.25).CGColor;
    [topView addSubview:spliteLine];
    [spliteLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(1);
    }];
    //拨号面板
    _dialKeyContainerView = [[YLDialKeyContainerView alloc] initWithFrame:CGRectZero];
    [self addSubview:_dialKeyContainerView];
    [_dialKeyContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).with.offset(18);
        make.leading.equalTo(self.mas_leading).with.offset(22);
        make.trailing.equalTo(self.mas_trailing).with.offset(-22);
    }];
    HUG_V(_dialKeyContainerView,NSLayoutPriorityRequired);
    RESIST_V(_dialKeyContainerView,NSLayoutPriorityDefaultLow);
    //呼叫按钮
    _callBtn = [[NSButton alloc] initWithFrame:CGRectZero];
    _callBtn.bordered = NO;
    NSImage *callBtnImage = [NSImage imageNamed:@"callBtn_nor.png"];
    [_callBtn setImage:callBtnImage];
    [_callBtn setImagePosition:NSImageOnly];
    [self addSubview:_callBtn];
    [_callBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.greaterThanOrEqualTo(self.mas_bottom).with.offset(-20);
        make.top.equalTo(_dialKeyContainerView.mas_bottom).with.offset(16).priorityLow();
    }];
    [_callBtn constrainAspectRatio:[@"*" stringByAppendingString:[@(callBtnImage.size.width/callBtnImage.size.height) stringValue]]];
    HUG_V(_callBtn,NSLayoutPriorityRequired);
    RESIST_V(_callBtn, NSLayoutPriorityRequired);
    
}


@end
