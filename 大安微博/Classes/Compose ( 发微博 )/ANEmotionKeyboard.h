//
//  ANEmotionKeyboard.h
//  大安微博
//
//  Created by a on 15/11/18.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANEmotionListView.h"
#import "ANEmotionTabBar.h"

@interface ANEmotionKeyboard : UIView

/**
 *  表情列表
 */
@property (nonatomic, strong)ANEmotionListView *emotionListView;
/**
 *  tabBar
 */
@property (nonatomic, strong)ANEmotionTabBar *emotionTabBar;
@end
