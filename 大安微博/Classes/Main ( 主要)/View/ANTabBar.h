//
//  ANTabBar.h
//  大安微博
//
//  Created by a on 15/10/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANTabBar;
@protocol ANTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusBtn:(ANTabBar *)tabbar;
@end

@interface ANTabBar : UITabBar

@property (weak, nonatomic)id<ANTabBarDelegate>delegate;


@end
