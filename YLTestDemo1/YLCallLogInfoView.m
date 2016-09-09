//
//  YLCallLogInfoView.m
//  YLTestDemo1
//
//  Created by linms on 16/9/1.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLCallLogInfoView.h"
#import "YLCallLogInfoElementView.h"
@interface YLCallLogInfoView ()
@property (nonatomic, strong) YLCallLogInfoElementView *numberElement;
@property (nonatomic, strong) YLCallLogInfoElementView *durationElement;
@property (nonatomic, strong) YLCallLogInfoElementView *timeElement;
@end
@implementation YLCallLogInfoView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.f;
}
- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        NSView *topView = [[NSView alloc] initWithFrame:CGRectZero];
        topView.wantsLayer = YES;
        topView.layer.backgroundColor = [NSColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
        [self addSubview:topView];
        [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(42);
        }];
        //添加topview上的控件
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
        
        //添加删除、添加按钮
        NSButton *deleteBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        deleteBtn.bordered = NO;
        NSImage *deleteImage = [NSImage imageNamed:@"delete_nor.png"];
        [deleteBtn setImage:deleteImage];
        [deleteBtn setImagePosition:NSImageOnly];
        [topView addSubview:deleteBtn];
        [deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topView.mas_right).offset(-14);
            make.centerY.equalTo(topView.mas_centerY);
            make.size.mas_equalTo(deleteImage.size);
        }];
        
        NSButton *addContactBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        addContactBtn.bordered = NO;
        NSImage *addContactImage = [NSImage imageNamed:@"addlogcontact_nor.png"];
        [addContactBtn setImage:addContactImage];
        [addContactBtn setImagePosition:NSImageOnly];
        [addContactBtn setTarget:self];
        [addContactBtn setAction:@selector(addContactBtnClicked:)];
        [topView addSubview:addContactBtn];
        [addContactBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(deleteBtn.mas_left).offset(-4);
            make.centerY.equalTo(topView.mas_centerY);
            make.size.mas_equalTo(addContactImage.size);
        }];
        
        //添加号码、持续时间、时间
        _numberElement = [[YLCallLogInfoElementView alloc] initWithFrame:CGRectZero];
        _numberElement.titleLabel.stringValue = @"号码:";
        _numberElement.subTitleLabel.textColor = [NSColor colorFromHexString:@"#00a9f0"];
        [self addSubview:_numberElement];
        [_numberElement mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(topView.mas_bottom);
            make.height.mas_equalTo(36);
        }];
        
        _durationElement = [[YLCallLogInfoElementView alloc] initWithFrame:CGRectZero];
        _durationElement.titleLabel.stringValue = @"持续时间:";
        [self addSubview:_durationElement];
        [_durationElement mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(_numberElement.mas_bottom);
            make.height.mas_equalTo(36);
        }];
        
        _timeElement = [[YLCallLogInfoElementView alloc] initWithFrame:CGRectZero];
        _timeElement.titleLabel.stringValue = @"时间:";
        [self addSubview:_timeElement];
        [_timeElement mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(_durationElement.mas_bottom);
            make.height.mas_equalTo(36);
        }];
    }
   
    return self;
}
- (void)addContactBtnClicked:(NSButton *)btn{
    if ([self.delegate respondsToSelector:@selector(YLCallLogInfoView:didTopViewAddBtnClicked:)]) {
        [self.delegate YLCallLogInfoView:self didTopViewAddBtnClicked:btn];
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
    if ([self.delegate respondsToSelector:@selector(YLCallLogInfoView:mouseExitPoint:)]) {
        [self.delegate YLCallLogInfoView:self mouseExitPoint:newPoint];
    }
}
- (void)setCallLogInfoViewWithRecord:(NSDictionary *)dic{
    _numberElement.subTitleLabel.stringValue = [dic objectForKey:@"Number"];
    _durationElement.subTitleLabel.stringValue = [dic objectForKey:@"Duration"];
    _timeElement.subTitleLabel.stringValue = [dic objectForKey:@"Time"];
}
@end
