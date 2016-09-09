//
//  YLContactDataSource.h
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLContactDataSource : NSObject
+ (NSMutableArray *)searchContact;
+ (NSMutableArray *)synContactName:(NSString *)name AndContactNumber:(NSString *)number;
@end
