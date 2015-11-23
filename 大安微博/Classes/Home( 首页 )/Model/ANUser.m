//
//  ANUser.m
//  大安微博
//
//  Created by a on 15/11/6.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANUser.h"

@implementation ANUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

//- (BOOL)isVip
//{
//    return self.mbrank > 2;
//}

@end
