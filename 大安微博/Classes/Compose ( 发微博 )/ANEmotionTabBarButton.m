//
//  ANEmotionTabBarButton.m
//  大安微博
//
//  Created by a on 15/11/18.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANEmotionTabBarButton.h"

@implementation ANEmotionTabBarButton

- (void)setHighlighted:(BOOL)highlighted
{
    //按钮高亮所做的一切都不存在了
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置按钮颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];

        // 设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
@end
