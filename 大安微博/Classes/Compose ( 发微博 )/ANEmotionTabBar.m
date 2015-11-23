//
//  ANEmotionTabBar.m
//  大安微博
//
//  Created by a on 15/11/18.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANEmotionTabBar.h"
#import "ANEmotionTabBarButton.h"

@interface ANEmotionTabBar ()

@property (nonatomic, strong)ANEmotionTabBarButton *seletedButton;

@end
@implementation ANEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupBtnWithTitle:@"最近" buttonType:ANEmotionTabBarTypeRecent];
        [self setupBtnWithTitle:@"默认" buttonType:ANEmotionTabBarTypeDefault];
        [self setupBtnWithTitle:@"emoj" buttonType:ANEmotionTabBarTypeEmoji];
        [self setupBtnWithTitle:@"浪小花" buttonType:ANEmotionTabBarTypeLxh];
        
    }
    return self;
}

/**
 *  设置按钮
 */
- (ANEmotionTabBarButton *)setupBtnWithTitle:(NSString *)title buttonType:(ANEmotionTabBarType)tabBarType
{
    ANEmotionTabBarButton *btn = [[ANEmotionTabBarButton alloc] init];
    btn.tag = tabBarType;
    // 监听按钮点击
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
    
    [btn setTitle:title forState:UIControlStateNormal];    
    [self addSubview:btn];
    
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectetdImage = @"compose_emotion_table_mid_selected";
    
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectetdImage =@"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4){
        image = @"compose_emotion_table_right_normal";
        selectetdImage = @"compose_emotion_table_right_selected";
    }
     
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectetdImage] forState:UIControlStateDisabled];

    return btn;
    
}

- (void)setDelegate:(id<ANEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    [self clickBtn:(ANEmotionTabBarButton *)[self viewWithTag:ANEmotionTabBarTypeDefault]];
}

/**
 *  设置子空间frame
 */
- (void)layoutSubviews
{
    NSUInteger count = self.subviews.count;
    
    CGFloat btnW = self.width / 4;
    CGFloat btnH = self.height;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
        btn.y = 0;
        
    }
}

/**
 *  按钮点击
 */
- (void)clickBtn:(ANEmotionTabBarButton *)btn
{
    self.seletedButton.enabled= YES;
    btn.enabled = NO;
    self.seletedButton = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectedButton:)]) {
        [self.delegate emotionTabBar:self didSelectedButton:(ANEmotionTabBarType)btn.tag];
    }
}



@end
