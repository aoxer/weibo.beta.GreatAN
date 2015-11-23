//
//  ANEmotions.h
//  大安微博
//
//  Created by a on 15/11/20.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANEmotions : NSObject
/**
 *  中文标签
 */
@property (nonatomic, copy) NSString *chs;
/**
 *  图片名
 */
@property (nonatomic, copy) NSString *png;
/**
 *  emoji编码
 */
@property (nonatomic, copy) NSString *code;
@end
