//
//  YLContactInfoView.h
//  YLTestDemo1
//
//  Created by linms on 16/8/24.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "YLContactInfoElementView.h"
@class YLContactInfoView;
@protocol YLContactInfoViewDelegate <NSObject>
- (void)YLContactInfoView:(YLContactInfoView *)view ExitPoint:(NSPoint)exitPoint;
- (void)YLContactInfoView:(YLContactInfoView *)view topViewEditBtnClicked:(NSButton *)btn;
- (void)YLContactInfoView:(YLContactInfoView *)view topViewDeleteBtnClicked:(NSButton *)btn;
@end
@interface YLContactInfoView : NSView
//属性
@property (nonatomic, strong) YLContactInfoElementView *detailElementView;
@property (nonatomic, weak) id <YLContactInfoViewDelegate> delegate;
//方法
- (void)setContactInfoTopViewTitle:(NSString *)title;
- (void)setContactInfoElementViewTitle:(NSString *)title andSubTitle:(NSString *)subTitle;
@end
