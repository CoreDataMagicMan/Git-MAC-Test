//
//  YLSearchBar.h
//  YLTestDemo1
//
//  Created by linms on 16/8/30.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class YLSearchBar;
@protocol YLSearchBarDelegate <NSObject>
@optional
- (void)YLSearchBar:(YLSearchBar *)searchTextField didChangeString:(NSString *)string;
@end
@interface YLSearchBar : NSSearchField
@property (nonatomic, weak) id <YLSearchBarDelegate> searchDelegate;
@end
