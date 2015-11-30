//
//  ANSpecial.h
//  大安微博
//
//  Created by a on 15/11/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSpecial : NSObject
/**
 *  这段特殊内容的文字
 */
@property (copy, nonatomic)NSString *text;
/**
 *  这段特殊内容的位置
 */
@property (assign, nonatomic)NSRange range;
/**
 *  这段特殊内容文字的矩形框数组 要求数组里面存放CGRect
 */
@property (copy, nonatomic)NSArray *rects;
@end
