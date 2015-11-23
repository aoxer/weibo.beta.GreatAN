//
//  ANEmotionTabBar.h
//  大安微博
//
//  Created by a on 15/11/18.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ANEmotionTabBarTypeRecent,  // 最近
    ANEmotionTabBarTypeDefault, // 默认
    ANEmotionTabBarTypeEmoji,   // emoji
    ANEmotionTabBarTypeLxh      // 浪小花
    
}ANEmotionTabBarType;

@class ANEmotionTabBar;

@protocol ANEmotionTabBarDelegate <NSObject>

- (void)emotionTabBar:(ANEmotionTabBar *)emotionTabBar didSelectedButton:(ANEmotionTabBarType)tabBarType;

@end

@interface ANEmotionTabBar : UIView
@property (weak, nonatomic)id<ANEmotionTabBarDelegate>delegate;

@end
