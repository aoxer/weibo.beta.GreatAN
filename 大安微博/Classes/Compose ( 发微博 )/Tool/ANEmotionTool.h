//
//  ANEmotionTool.h
//  大安微博
//
//  Created by a on 15/11/22.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ANEmotions;
@interface ANEmotionTool : NSObject
+ (void)addRecentEmotion:(ANEmotions *)emotion;
+ (NSArray *)recentEmotions;
@end
