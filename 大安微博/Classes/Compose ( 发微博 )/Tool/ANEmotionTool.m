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
#import "MJExtension.h"

@implementation ANEmotionTool

static NSMutableArray *_recentEmotions, *_defaultEmotions, *_lxhEmotions, *_emojiEmotions;

+ (void)initialize
{
    // 加载沙盒中的表情数据
    _recentEmotions = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:ANRecentEmotionPath];
    
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
    
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *emotionArray = [NSArray arrayWithContentsOfFile:path];
        _defaultEmotions = [ANEmotions objectArrayWithKeyValuesArray:emotionArray];
    }
    
    if (_lxhEmotions == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *emotionArray = [NSArray arrayWithContentsOfFile:path];
        _lxhEmotions =  [ANEmotions objectArrayWithKeyValuesArray:emotionArray];
    }
    
    if (_emojiEmotions == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emotionArray = [NSArray arrayWithContentsOfFile:path];
        _emojiEmotions = [ANEmotions objectArrayWithKeyValuesArray:emotionArray];
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
 *  返回装着默认表情的数组
 */
+ (NSArray *)defaultEmotions
{
    return _defaultEmotions;
}
/**
 *  返回装着浪小花表情的数组
 */
+ (NSArray *)lxhEmotions
{
    return _lxhEmotions;
}
/**
 *  返回装着emoji表情的数组
 */
+ (NSArray *)emojiEmotions
{
    return _emojiEmotions;
}
/**
 *  返回装着最近表情的数组
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}

+ (ANEmotions *)emotionWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmotions];
    for (ANEmotions *e in defaults) {
        if ([e.chs isEqualToString:chs]) return e;
    }
    
    NSArray *lxh = [self lxhEmotions];
    for (ANEmotions *e in lxh) {
        if ([e.chs isEqualToString:chs]) return e;
    }
    
    return nil;
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
