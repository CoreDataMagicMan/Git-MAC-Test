//
//  YLDialPadView.h
//  YLTestDemo1
//
//  Created by linms on 16/9/7.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "YLTextField.h"
@interface YLDialPadView : NSView
@property (nonatomic, strong) YLTextField *inputTextField;
@property (nonatomic, strong) NSButton *inputBackBtn;
@property (nonatomic, strong) NSButton *callBtn;
@end
