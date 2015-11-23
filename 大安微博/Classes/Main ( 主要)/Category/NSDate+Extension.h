//
//  NSDate+Extension.h
//  大安微博
//
//  Created by a on 15/11/13.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;

@end
