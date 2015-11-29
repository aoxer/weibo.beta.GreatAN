//
//  ANPart.h
//  大安微博
//
//  Created by a on 15/11/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANPart : NSObject
/**
 *  这段内容的文字
 */
@property (copy, nonatomic)NSString *text;
/**
 *  这段内容的位置
 */
@property (assign, nonatomic)NSRange range;
/**
 *  这段内容是否为特殊文字
 */
@property (assign, nonatomic, getter=isSpecial)BOOL special;
/**
 *  这段内容是否为表情
 */
@property (assign, nonatomic, getter=isEmotion)BOOL emotion;
@end
