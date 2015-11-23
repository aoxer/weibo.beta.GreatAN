//
//  ANAccount.h
//  大安微博
//
//  Created by a on 15/11/4.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
/*<key>access_token</key>
	<string>2.00DUvkdB0EqPCFfb1a2c953anP2ytC</string>
	<key>expires_in</key>
	<integer>157679999</integer>
	<key>remind_in</key>
	<string>157679999</string>
	<key>uid</key>
	<string>1503593995</string>
 */

@interface ANAccount : NSObject <NSCoding>
/**
 *  accessToken
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  access_token的生命周期, 单位是秒
 */
@property (nonatomic, copy) NSNumber *expires_in;
/**
 *  UID
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  账号的创建时间
 */
@property (nonatomic, strong)NSDate *created_time;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
