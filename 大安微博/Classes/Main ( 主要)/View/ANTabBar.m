//
//  ANTabBar.m
//  大安微博
//
//  Created by a on 15/10/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTabBar.h"

@interface ANTabBar ()

@property (weak, nonatomic) UIButton *plusBtn;


@end

@implementation ANTabBar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *plusBtn = [[UIButton alloc] init];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
       
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
        // 监听按钮点击
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    
}

- (void)plusBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusBtn:)]) {
        [self.delegate tabBarDidClickPlusBtn:self];
    }
}
 

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    // 2.设置其他tabbarButton的位置和尺寸
    NSUInteger tabbarButtonIndex = 0;
    CGFloat tabbarButtonW = self.width / 5;
    
    for (UIView *child in self.subviews) {
        Class tabBarButtonClass = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:tabBarButtonClass]) {
            // 设置宽度
            child.width = tabbarButtonW;
            // 设置x
            child.x = tabbarButtonIndex * tabbarButtonW;
            // 增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }

    }
    
}


@end
