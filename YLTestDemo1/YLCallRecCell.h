//
//  YLCallRecCell.h
//  YLTestDemo1
//
//  Created by linms on 16/9/1.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class YLCallRecCell;
@protocol YLCallRecCellDelegate <NSObject>
- (void)YLCallRecCell:(YLCallRecCell *)cell mouseExitPoint:(NSPoint)point isShowOrHidden:(BOOL)isShow;
@end
@interface YLCallRecCell : NSTableCellView
@property (weak) IBOutlet NSImageView *iconImageView;
@property (weak) IBOutlet NSTextField *callLogLabel;
@property (weak) IBOutlet NSTextField *dateLabel;
@property (nonatomic, weak) id <YLCallRecCellDelegate> delegate;
@end
