//
//  YLCallRecDataSource.m
//  YLTestDemo1
//
//  Created by linms on 16/9/1.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLCallRecDataSource.h"

@implementation YLCallRecDataSource
+ (NSMutableArray *)searchCallRecLog{
    NSMutableArray *dataArray = [NSMutableArray new];
    NSArray *callLogArr = @[@"7576",
                         @"7233",
                         @"7455",
                         @"7899",
                         @"2354"];
    for (NSString *callLog in callLogArr) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:callLog,@"CallLog",@"2016/09/01",@"Date", nil];
        [dataArray addObject:dic];
    }
    return dataArray;
}
@end
