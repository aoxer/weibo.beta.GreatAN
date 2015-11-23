//
//  ANUser.h
//  大安微博
//
//  Created by a on 15/11/6.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    ANUserVerifiedTypeNone = -1, // 没有任何认证
    
    ANUserVerifiedTypePersonal = 0,  // 个人认证
    
    ANUserVerifiedTypeOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    ANUserVerifiedTypeOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    ANUserVerifiedTypeOrgWebsite = 5, // 网站官方：猫扑
    
    ANUserVerifiedTypeDaren = 220 // 微博达人
    
} ANUserVerifiedType;

@interface ANUser : NSObject

/**string	字符串型的用户UID */
@property (nonatomic, copy) NSString *idstr;
/**	string	友好显示名称 */
@property (nonatomic, copy) NSString *name;
/**	string	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;
/**	会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/**	会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter=isVip) BOOL vip;

/** 认证类型*/
@property (nonatomic, assign) ANUserVerifiedType verified_type;



@end
