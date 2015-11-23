//
//  ANEmotionTool.m
//  大安微博
//
//  Created by a on 15/11/22.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#define ANRecentEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.archive"]


#import "ANEmotionTool.h"
#import "ANEmotions.h"

@implementation ANEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    // 加载沙盒中的表情数据
    _recentEmotions = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:ANRecentEmotionPath];
    
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}
+ (void)addRecentEmotion:(ANEmotions *)emotion
{
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];
    // 插入传进来的表情到最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    //最近使用表情数控制在20(单页)
    if (_recentEmotions.count > ANEmotionPageSize) {
        
        [_recentEmotions removeLastObject];
    }
    
    // 将所有表情存储到沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:ANRecentEmotionPath];
}


/**
 *  返回装着表情的数组
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}

// 将表情插入到数组第一位
//    for (int i = 0; i<emotions.count; i++) { // 如果在数组里删数组元素 要实时监控count的数量 不可在外面定义count
//        ANEmotions *selectEmotion = emotions[i];
//        if ([emotion.chs isEqualToString:selectEmotion.chs] || [emotion.code isEqualToString:selectEmotion.code]) {
//            [emotions removeObject:selectEmotion];
//            break;
//        }
//    }

//    for (ANEmotions *selecteEmotion in emotions) {
//        if ([emotion.chs isEqualToString:selecteEmotion.chs] || [emotion.code isEqualToString:selecteEmotion.code]) {
//            [emotions removeObject:selecteEmotion];
//            break;
//        }
//    }


@end
