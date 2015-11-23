//
//  ANLoadMoreFooter.m
//  大安微博
//
//  Created by a on 15/11/7.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANLoadMoreFooter.h"

@implementation ANLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
