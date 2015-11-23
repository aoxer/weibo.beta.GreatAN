//
//  ANAccount.m
//  大安微博
//
//  Created by a on 15/11/4.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANAccount.h"

@implementation ANAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    ANAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.name = dict[@"name"];
    account.created_time = [NSDate date];
    
    // 获得账号存储的时间(accessToken的产生时间)
    account.created_time = [NSDate date];
    
    
    return account;
}
/**
 *  当一个对象要归档进沙盒就要调用
 *  目的:在这个方法中说明这个对象的哪些属性要存进沙盒
 *
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}
/**
 *  当从沙盒中解档一个对象时(从沙河中加载一个对象时), 就会调用这个方法
 *  目的:在这个方法中说明沙河中的属性该怎么解析(需要取出哪些属性)
 */ 
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
