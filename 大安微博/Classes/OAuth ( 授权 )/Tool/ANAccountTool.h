//
//  ANAccountTool.h
//  大安微博
//
//  Created by a on 15/11/4.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAccount.h"
@interface ANAccountTool : NSObject
/**
 *  存数账号信息
 *
 *  @return 账号模型
 */
+ (void)saveAccount:(ANAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (ANAccount *)account;
@end
