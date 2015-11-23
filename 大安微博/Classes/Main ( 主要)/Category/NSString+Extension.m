//
//  NSString+Extension.m
//  大安微博
//
//  Created by a on 15/11/10.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 *  计算文字的size 和最大宽度
 *
 *  @param text 需要计算size的文字
 *  @param font 该文字的字体
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

/**
 *  计算文字的size
 *
 *  @param text 需要计算size的文字
 *  @param font 该文字的字体
 */
- (CGSize)sizeWithFont:(UIFont *)font
{
    
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
@end
