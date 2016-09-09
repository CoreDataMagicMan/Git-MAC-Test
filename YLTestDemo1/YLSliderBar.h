//
//  YLSliderBar.h
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class YLSliderBar;
@protocol YLSliderBarDelegate <NSObject>
- (void)YLSliderBar:(YLSliderBar *)sliderBar sliderBtnClicked:(NSButton *)btn;
@end
@interface YLSliderBar : NSView
@property (nonatomic, weak) id <YLSliderBarDelegate> delegate;
@end
