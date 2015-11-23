//
//  ANAccountTool.m
//  大安微博
//
//  Created by a on 15/11/4.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#define ANAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "ANAccountTool.h"

@implementation ANAccountTool



+ (void)saveAccount:(ANAccount *)account
{
    // 自定义对象的存储 必须要用KeyedArchiver
    [NSKeyedArchiver archiveRootObject:account toFile:ANAccountPath];
}

/**
 *  返回账号信息
 */
+ (ANAccount *)account
{
    // 加载模型
    ANAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ANAccountPath];
 
    // 验证账号是否过期
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    // 获得过期时间
    NSDate *expriesTime = [account.created_time dateByAddingTimeInterval:expires_in];
    // 获得当前时间
    NSDate *now = [NSDate date];
    // 如果now>=expiresTime, 过期
    // 如果expiresTime< now, 没有过期
    /**
     NSOrderedAscending = -1L, // 升序
     NSOrderedSame, 
     NSOrderedDescending // 降序
     */
    NSComparisonResult result = [expriesTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    return account;
}

@end
