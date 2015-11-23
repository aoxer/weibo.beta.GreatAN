//
//  ANEmotionKeyboard.m
//  大安微博
//
//  Created by a on 15/11/18.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANEmotionKeyboard.h"
#import "ANEmotionListView.h"
#import "ANEmotionTabBar.h"
#import "ANEmotions.h"
#import "MJExtension.h"
#import "ANEmotionTool.h"

@interface ANEmotionKeyboard () <ANEmotionTabBarDelegate>
/**
 *  正在显示的view
 */
@property (nonatomic, strong)ANEmotionListView *showingListView;
/**
 *  表情列表
 */
@property (nonatomic, strong)ANEmotionListView *recentListView;
@property (nonatomic, strong)ANEmotionListView *defaultListView;
@property (nonatomic, strong)ANEmotionListView *emojiListView;
@property (nonatomic, strong)ANEmotionListView *lxhListView;
/**
 *  tabBar
 */
@property (nonatomic, strong)ANEmotionTabBar *tabBar;
@end
@implementation ANEmotionKeyboard

#pragma mark 懒加载
/**
 *  懒加载
 */
- (ANEmotionListView *)recentListView
{
    if (!_recentListView) {
        _recentListView = [[ANEmotionListView alloc] init];
        
        self.recentListView.emotions = [ANEmotionTool recentEmotions];
        
    }
    return _recentListView;
}

- (ANEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        _defaultListView = [[ANEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        self.defaultListView.emotions = [ANEmotions objectArrayWithKeyValuesArray:dictArray];
    }
    return _defaultListView;
}

- (ANEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        _emojiListView = [[ANEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        self.emojiListView.emotions = [ANEmotions objectArrayWithKeyValuesArray:dictArray];
    }
    return _emojiListView;
}

- (ANEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        _lxhListView = [[ANEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        self.lxhListView.emotions = [ANEmotions objectArrayWithKeyValuesArray:dictArray];
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ANEmotionListView *showingListView = [[ANEmotionListView alloc] init];
        [self addSubview:showingListView];
        self.showingListView = showingListView;
        
        ANEmotionTabBar *tabBar = [[ANEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 监听表情选中的通知
        [ANNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:ANEmotionDidSelectNotification object:nil];
         
    }
    return self;
}
/**
 *  监听表情被点击的方法
 */
- (void)emotionDidSelect
{
//    self.recentListView.emotions = [ANEmotionTool recentEmotions];
}

- (void)dealloc
{
    [ANNotificationCenter removeObserver:self];
}

- (void)layoutSubviews
{
    self.tabBar.height = 37;
    self.tabBar.width = ANScreenWidth;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    self.showingListView.height = self.height - self.tabBar.height;
    self.showingListView.width = ANScreenWidth;
    self.showingListView.x = 0;
    self.showingListView.y = 0;
}


#pragma mark ANEmotionTabBarDelegate 
- (void)emotionTabBar:(ANEmotionTabBar *)emotionTabBar didSelectedButton:(ANEmotionTabBarType)tabBarType
{
    [self.showingListView removeFromSuperview];
    
    switch (tabBarType) {
        case ANEmotionTabBarTypeRecent: // 最近
            [self addSubview:self.recentListView];
            self.recentListView.emotions = [ANEmotionTool recentEmotions];
            
            break;
            
        case ANEmotionTabBarTypeDefault: // 默认
            [self addSubview:self.defaultListView];
//            self.showingListView = self.defaultListView;
            break;
            
        case ANEmotionTabBarTypeEmoji: // emoji
            [self addSubview:self.emojiListView];
//            self.showingListView = self.emojiListView;
            break;
            
        case ANEmotionTabBarTypeLxh: // 浪小花
            [self addSubview:self.lxhListView];
//            self.showingListView = self.lxhListView;
            break;
            
    }
    self.showingListView = [self.subviews lastObject];
    
    [self setNeedsLayout];
    
    
}




@end
