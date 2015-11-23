//
//  ANStatus.h
//  大安微博
//
//  Created by a on 15/11/6.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ANUser;
@interface ANStatus : NSObject

/** idstr	string	字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;

/** text	string	微博信息内容 */
@property (nonatomic, copy) NSString *text;

/** user	object	微博作者的用户信息字段 详细 */
@property (nonatomic, strong) ANUser *user;

/**	string	微博创建时间 */
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源 */
@property (nonatomic, copy) NSString *source;

/** 微博配图地址, 多图是返回多图链接 无配图返回[]*/
@property (nonatomic, strong)NSArray *pic_urls;

/** object	被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong)ANStatus *retweeted_status;

/** int	转发数*/
@property (nonatomic, assign) NSUInteger reposts_count;

/** 	int	评论数*/
@property (nonatomic, assign) NSUInteger comments_count;

/** 	int	表态数*/
@property (nonatomic, assign) NSUInteger attitudes_count;
@end
