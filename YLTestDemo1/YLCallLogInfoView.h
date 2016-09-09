//
//  YLCallLogInfoView.h
//  YLTestDemo1
//
//  Created by linms on 16/9/1.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class YLCallLogInfoElementView;
@class YLCallLogInfoView;
@protocol YLCallLogInfoViewDelegate <NSObject>
- (void)YLCallLogInfoView:(YLCallLogInfoView *)view didTopViewAddBtnClicked:(NSButton *)btn;
- (void)YLCallLogInfoView:(YLCallLogInfoView *)view mouseExitPoint:(NSPoint)point;
@end
@interface YLCallLogInfoView : NSView
//属性
@property (nonatomic, strong) NSTextField *nameLabel;
@property (nonatomic, weak) id <YLCallLogInfoViewDelegate> delegate;
//方法
- (void)setCallLogInfoViewWithRecord:(NSDictionary *)dic;
@end
