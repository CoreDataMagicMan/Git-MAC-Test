//
//  YLNewContactInfoElementView.h
//  YLTestDemo1
//
//  Created by linms on 16/8/26.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
typedef void(^NewContactElementViewDeleteBtnHandle)();
@interface YLNewContactInfoElementView : NSView
@property (nonatomic, strong) NSTextField *inputTextField;
@property (nonatomic, strong) NSButton *deleteBtn;
@property (nonatomic, assign) BOOL isShowDeleBtn;
- (void)setIsShowDeleBtn:(BOOL)isShowDeleBtn;
- (void)newContactElementViewDeleteBtnClickedHandle:(NewContactElementViewDeleteBtnHandle)handle;
- (void)setTitle:(NSString *)title;
@end
