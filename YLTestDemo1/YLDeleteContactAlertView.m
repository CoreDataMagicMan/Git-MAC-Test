//
//  YLDeleteContactAlertView.m
//  YLTestDemo1
//
//  Created by linms on 16/9/6.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLDeleteContactAlertView.h"
@interface YLDeleteContactAlertView (){
    AlertViewReturnBtnHandle returnBtnHandle;
}
@property (nonatomic, strong) NSButton *confirmBtn;
@property (nonatomic, strong) NSButton *cancelBtn;
@end
@implementation YLDeleteContactAlertView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.f;
    // Drawing code here.
}
- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        NSView *topView = [[NSView alloc] initWithFrame:CGRectZero];
        [self addSubview:topView];
        [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(90);
        }];
        
        NSTextField *titleLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        titleLabel.bordered = NO;
        titleLabel.backgroundColor = [NSColor clearColor];
        titleLabel.editable = NO;
        titleLabel.font = [NSFont systemFontOfSize:16];
        titleLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        titleLabel.stringValue = @"Delete the contact?";
        [topView addSubview:titleLabel];
        [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(topView.mas_centerX);
            make.centerY.equalTo(topView.mas_centerY);
        }];
        
        //确定、取消按钮
        _confirmBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        _confirmBtn.wantsLayer = YES;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.cornerRadius = 4.f;
        _confirmBtn.bordered = NO;
        [_confirmBtn setBackgroundColor:[NSColor colorFromHexString:@"#42b49a"]];
        [_confirmBtn setTitle:@"Yes"];
        [_confirmBtn setAttributedTitleWithColor:[NSColor whiteColor]];
        [_confirmBtn setTarget:self];
        [_confirmBtn setAction:@selector(confirmBtnClicked:)];
        [self addSubview:_confirmBtn];
        [_confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(40);
            make.top.equalTo(topView.mas_bottom);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(106);
        }];
        
        _cancelBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        _cancelBtn.wantsLayer = YES;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 4.f;
        _cancelBtn.bordered = NO;
        [_cancelBtn setBackgroundColor:[NSColor colorFromHexString:@"#b5b5b5"]];
        [_cancelBtn setTitle:@"No"];
        [_cancelBtn setAttributedTitleWithColor:[NSColor whiteColor]];
        [_cancelBtn setTarget:self];
        [_cancelBtn setAction:@selector(cancelBtnClicked:)];
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_confirmBtn.mas_right).offset(18);
            make.top.equalTo(topView.mas_bottom);
            make.height.equalTo(_confirmBtn.mas_height);
            make.width.equalTo(_confirmBtn.mas_width);
        }];
        
    }
    return self;
}
- (void)confirmBtnClicked:(NSButton *)btn{
    [btn setBackgroundColor:[NSColor colorFromHexString:@"#42b49a"]];
    [_cancelBtn setBackgroundColor:[NSColor colorFromHexString:@"#b5b5b5"]];
    if (returnBtnHandle) {
        returnBtnHandle(YLAlertViewReturnConfirmButtonType);
    }
}
- (void)cancelBtnClicked:(NSButton *)btn{
    [btn setBackgroundColor:[NSColor colorFromHexString:@"#42b49a"]];
    [_confirmBtn setBackgroundColor:[NSColor colorFromHexString:@"#b5b5b5"]];
    if (returnBtnHandle) {
        returnBtnHandle(YLAlertViewReturnCancelButtonType);
    }
}
- (void)alertViewReturnBtnClickedHandle:(AlertViewReturnBtnHandle)handle{
    returnBtnHandle = handle;
}
@end
