//
//  YLNewContactElementView.m
//  YLTestDemo1
//
//  Created by linms on 16/8/26.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLNewContactInfoElementView.h"
@interface YLNewContactInfoElementView (){
    NewContactElementViewDeleteBtnHandle elementViewDeleteBtnHandle;
}
@property (nonatomic, strong) NSTextField *titleLabel;
@end
@implementation YLNewContactInfoElementView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor whiteColor].CGColor;
        _titleLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _titleLabel.bordered = NO;
        _titleLabel.editable= NO;
        _titleLabel.backgroundColor = [NSColor clearColor];
        _titleLabel.font = [NSFont systemFontOfSize:12];
        _titleLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        [self addSubview:_titleLabel];
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(40);
            make.right.equalTo(self.mas_right).offset(-40);
            make.top.equalTo(self.mas_top);
            make.height.mas_equalTo(14);
        }];
        
        _inputTextField = [[NSTextField alloc] initWithFrame:CGRectZero];
        [_inputTextField.cell setUsesSingleLineMode:YES];
        [_inputTextField.cell setScrollable:YES];
        _inputTextField.font = [NSFont systemFontOfSize:14.f];
        _inputTextField.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        [self addSubview:_inputTextField];
        [_inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(40);
            make.right.equalTo(self.mas_right).offset(-40);
            make.height.mas_equalTo(26);
        }];
        
        NSView *deleteView = [[NSView alloc] initWithFrame:CGRectZero];
        [self addSubview:deleteView];
        [deleteView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inputTextField.mas_right).offset(7);
            make.right.equalTo(self).offset(-7);
            make.top.bottom.equalTo(_inputTextField);
        }];
        
        _deleteBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        _deleteBtn.bordered = NO;
        NSImage *deNumberImage = [NSImage imageNamed:@"denumber_btn.png"];
        [_deleteBtn setImage:deNumberImage];
        [_deleteBtn setTarget:self];
        [_deleteBtn setAction:@selector(deleteBtnClicked:)];
        [deleteView addSubview:_deleteBtn];
        [_deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(deleteView.mas_centerX);
            make.centerY.equalTo(deleteView.mas_centerY);
            make.size.mas_equalTo(deNumberImage.size);
        }];
        _deleteBtn.hidden = _isShowDeleBtn ? NO : YES;
    }
    return self;
}
- (void)setIsShowDeleBtn:(BOOL)isShowDeleBtn{
    _deleteBtn.hidden = isShowDeleBtn ? NO : YES;
}
- (void)newContactElementViewDeleteBtnClickedHandle:(NewContactElementViewDeleteBtnHandle)handle{
    elementViewDeleteBtnHandle = handle;
}
- (void)deleteBtnClicked:(NSButton *)btn{
    if (elementViewDeleteBtnHandle) {
        elementViewDeleteBtnHandle();
    }
}
- (void)setTitle:(NSString *)title{
    _titleLabel.stringValue = title;
}
@end
