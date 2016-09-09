//
//  YLRootWindowController.m
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLRootWindowController.h"
#import "YLSliderBar.h"
#import "YLContactViewController.h"
#import "YLCallLogViewController.h"
#import "YLRecentCallViewController.h"
@interface YLRootWindowController ()<YLSliderBarDelegate>
@property (nonatomic,strong) YLSliderBar *sliderBar;
@property (nonatomic, strong) YLContactViewController *contactVC;
@property (nonatomic, strong) YLCallLogViewController *callLogVC;
@property (nonatomic, strong) YLRecentCallViewController *recentCallVC;
@property (nonatomic, strong) NSView *rightView;
@end

@implementation YLRootWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    self.window.titlebarAppearsTransparent = YES;
    self.window.title = @"VCD For Mac";
    self.window.contentView.layer.contents = (id)[NSImage imageNamed:@"bg.png"];
    NSView *bgView = [[NSView alloc] initWithFrame:CGRectZero];
    bgView.wantsLayer = YES;
    bgView.layer.contents = (id)[NSImage imageNamed:@"bg.png"];
    [self.window.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.window.contentView);
        make.top.equalTo(self.window.contentView).offset(38);
    }];
    _sliderBar = [[YLSliderBar alloc] initWithFrame:CGRectZero];
    _sliderBar.delegate = self;
    [bgView addSubview:_sliderBar];
    [_sliderBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(bgView);
        make.width.mas_equalTo(55);
        make.bottom.equalTo(bgView.mas_bottom);
    }];
    //添加右侧的视图
    _rightView = [[NSView alloc] initWithFrame:CGRectZero];
    _rightView.wantsLayer = YES;
    _rightView.layer.backgroundColor = [NSColor clearColor].CGColor;
    [bgView addSubview:_rightView];
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sliderBar.mas_right);
        make.top.bottom.equalTo(_sliderBar);
        make.width.mas_equalTo(240);
    }];
}
- (void)YLSliderBar:(YLSliderBar *)sliderBar sliderBtnClicked:(NSButton *)btn{
    NSInteger index = btn.tag;
    switch (index) {
        case 0:{
            if (_contactVC) {
                [_contactVC.view removeFromSuperview];
                _contactVC = nil;
            }
            if (_callLogVC) {
                [_callLogVC.view removeFromSuperview];
                _callLogVC = nil;
            }
            if (_recentCallVC) {
                [_recentCallVC.view removeFromSuperview];
                _recentCallVC = nil;
            }else{
                _recentCallVC = [[YLRecentCallViewController alloc] initWithNibName:@"YLRecentCallViewController" bundle:[NSBundle mainBundle]];
                _recentCallVC.view.wantsLayer = YES;
                _recentCallVC.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
                [_rightView addSubview:_recentCallVC.view];
                [_recentCallVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(_rightView);
                }];
            }
            
        }
            break;
        case 1:{
            //            联系人
            if (_callLogVC) {
                [_callLogVC.view removeFromSuperview];
                _callLogVC = nil;
            }
            if (_recentCallVC) {
                [_recentCallVC.view removeFromSuperview];
                _recentCallVC = nil;
            }
            if (_contactVC) {
                [_contactVC.view removeFromSuperview];
                _contactVC = nil;
            }else{
                _contactVC = [[YLContactViewController alloc] initWithNibName:@"YLContactViewController" bundle:[NSBundle mainBundle]];
                _contactVC.view.wantsLayer = YES;
                _contactVC.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
                [_rightView addSubview:_contactVC.view];
                [_contactVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(_rightView);
                }];
            }
        }
            break;
        case 2:{
            //通话记录
            if (_contactVC) {
                [_contactVC.view removeFromSuperview];
                _contactVC = nil;
            }
            if (_recentCallVC) {
                [_recentCallVC.view removeFromSuperview];
                _recentCallVC = nil;
            }
            if (_callLogVC) {
                [_callLogVC.view removeFromSuperview];
                _callLogVC = nil;
            }else{
                _callLogVC = [[YLCallLogViewController alloc] initWithNibName:@"YLCallLogViewController" bundle:[NSBundle mainBundle]];
                _callLogVC.view.wantsLayer = YES;
                _callLogVC.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
                [_rightView addSubview:_callLogVC.view];
                [_callLogVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(_rightView);
                }];
            }
        }
            break;
        case 3:{
            //设置
        }
            break;
        default:
            break;
    }
}
@end
