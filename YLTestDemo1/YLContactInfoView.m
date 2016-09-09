//
//  YLDetailInfoView.m
//  YLTestDemo1
//
//  Created by linms on 16/8/24.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLContactInfoView.h"
@interface YLContactInfoView (){

}
@property (nonatomic, strong) NSTextField *nameLabel;
@property (nonatomic, strong) NSButton *editBtn;
@property (nonatomic, strong) NSButton *deleteBtn;
@end
@implementation YLContactInfoView


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
        topView.wantsLayer = YES;
        topView.layer.backgroundColor = RGBA(0, 0, 0, 0.1).CGColor;
        [self addSubview:topView];
        [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(42);
        }];
        //名字
        _nameLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor  = [NSColor colorFromHexString:@"#3a3a3a"];
        _nameLabel.font = [NSFont systemFontOfSize:20.f];
        _nameLabel.backgroundColor = [NSColor clearColor];
        //设置textfield无边框
        _nameLabel.bordered = NO;
        //设置textfield不可编辑
        _nameLabel.editable = NO;
        [topView addSubview:_nameLabel];
        [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topView.mas_left).offset(14);
            make.centerY.equalTo(topView.mas_centerY);
        }];
        //删除按钮
        _deleteBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        NSImage *deleteImage = [NSImage imageNamed:@"delete_nor.png"];
        [_deleteBtn setImage:deleteImage];
        [_deleteBtn setImagePosition:NSImageOnly];
        _deleteBtn.bordered = NO;
        [_deleteBtn setTarget:self];
        [_deleteBtn setAction:@selector(detailInfoTopViewDeleteBtnClicked:)];
        [topView addSubview:_deleteBtn];
        [_deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topView.mas_right).offset(-14);
            make.centerY.equalTo(topView.mas_centerY);
            make.size.mas_equalTo(deleteImage.size);
        }];
        //编辑按钮
        _editBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        NSImage *editImage = [NSImage imageNamed:@"edit_nor.png"];
        [_editBtn setImage:editImage];
        [_editBtn setImagePosition:NSImageOnly];
        _editBtn.bordered = NO;
        [_editBtn setTarget:self];
        [_editBtn setAction:@selector(detailInfoTopViewEditBtnClicked:)];
        [topView addSubview:_editBtn];
        [_editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_deleteBtn.mas_left).offset(-4);
            make.centerY.equalTo(topView.mas_centerY);
            make.size.mas_equalTo(editImage.size);
        }];
        
        //每一条显示的信息
        _detailElementView = [[YLContactInfoElementView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_detailElementView];
        [_detailElementView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(topView.mas_bottom);
        }];
    }
    return self;
}

- (void)detailInfoTopViewEditBtnClicked:(NSButton *)btn{
    if ([self.delegate respondsToSelector:@selector(YLContactInfoView:topViewEditBtnClicked:)]) {
        [self.delegate YLContactInfoView:self topViewEditBtnClicked:btn];
    }
}

- (void)detailInfoTopViewDeleteBtnClicked:(NSButton *)btn{
    if ([self.delegate respondsToSelector:@selector(YLContactInfoView:topViewDeleteBtnClicked:)]) {
        [self.delegate YLContactInfoView:self topViewDeleteBtnClicked:btn];
    }
}

-(void)updateTrackingAreas{
    
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveInKeyWindow;
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                                options:options
                                                                  owner:self
                                                               userInfo:nil];
    [self addTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent{
    
}
- (void)mouseExited:(NSEvent *)theEvent{
    NSPoint location = [theEvent locationInWindow];
    NSPoint newPoint = [self.window.contentView convertPoint:location fromView:nil];
    if ([self.delegate respondsToSelector:@selector(YLContactInfoView:ExitPoint:)]) {
        [self.delegate YLContactInfoView:self ExitPoint:newPoint];
    }
}
//设置topView标题栏
- (void)setContactInfoTopViewTitle:(NSString *)title{
    if (title) {
        _nameLabel.stringValue = title;
    }
}
//配置每一条显示信息
- (void)setContactInfoElementViewTitle:(NSString *)title andSubTitle:(NSString *)subTitle{
    _detailElementView.titleLabel.stringValue = title;
    _detailElementView.numLabel.stringValue = subTitle;
}
@end
