//
//  YLContactCell.h
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class YLContactCell;

@protocol YLContactCellDelegate <NSObject>
- (void)YLContactCell:(YLContactCell *)cell isShowOrHidden:(BOOL)isShow ExitPoint:(NSPoint)exitPoint;
@end
@interface YLContactCell : NSTableCellView
@property (nonatomic, weak) IBOutlet NSTextField *nameLabel;
@property (nonatomic,weak) IBOutlet NSImageView *iconImageView;
@property (nonatomic, weak) IBOutlet NSTextField *numberLabel;
@property (nonatomic, weak) id <YLContactCellDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isEnterCell;
@end
