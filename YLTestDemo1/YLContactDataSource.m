//
//  YLContactDataSource.m
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLContactDataSource.h"

@implementation YLContactDataSource
+ (NSMutableArray *)searchContact{
    NSMutableArray *dataArray = [self synContactName:nil AndContactNumber:nil];
    return dataArray;
}
+ (NSArray *)getContact{
    return @[@"lms",
             @"lyc",
             @"lzj",
             @"yq",
             @"lyz"];
    
}
+ (NSMutableArray *)synContactName:(NSString *)name AndContactNumber:(NSString *)number{
    NSMutableArray *tempArray = [NSMutableArray new];
    NSArray *contactArr = [self getContact];
    for (NSString *contact in contactArr) {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:contact,@"Name",@"192.168.1.1",@"Number", nil];
        [tempArray addObject:dic];
    }
    if (!name && !number) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:tempArray] forKey:@"dataSource"];
        return tempArray;
    }else{
        tempArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"dataSource"]];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"Name",number,@"Number", nil];
        [tempArray addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:tempArray] forKey:@"dataSource"];
    }
    return tempArray;
}
@end
