//
//  YLDeleteContactAlertView.h
//  YLTestDemo1
//
//  Created by linms on 16/9/6.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
typedef NS_ENUM(NSInteger,YLAlertViewReturnButtonType){
    YLAlertViewReturnConfirmButtonType = 0,
    YLAlertViewReturnCancelButtonType
};
typedef void(^AlertViewReturnBtnHandle)(YLAlertViewReturnButtonType buttonType);
@interface YLDeleteContactAlertView : NSView
- (void)alertViewReturnBtnClickedHandle:(AlertViewReturnBtnHandle)handle;
@end
