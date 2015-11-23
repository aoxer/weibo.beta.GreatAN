//
//  ANDropdownMenu.m
//  大安微博
//
//  Created by a on 15/10/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANDropdownMenu.h"
#import "ANHomeViewController.h"

@interface ANDropdownMenu ()
/**
 *  用来显示具体内容的容器
 */
@property (nonatomic, strong) UIImageView *containerView;

@end

@implementation ANDropdownMenu
 
+ (instancetype)menu
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景色为透明
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
/**
 *  懒加载创建内容控制器View
 */
- (UIImageView *)containerView
{
    if (_containerView == nil) {
        UIImageView *containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_background"]];
    
        containerView.userInteractionEnabled = YES;
        
         self.containerView = containerView;

        [self addSubview:containerView];
    }
    
    return _containerView;
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    content.x = 10;
    content.y = 15; 

//    content.width = self.containerView.width - _content.x * 2;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}

- (void)showFrom:(UIView *)from;
{
    // 获取最上层窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 设置尺寸
    self.frame = window.frame;
    // 添加自己得到窗口上
    [window addSubview:self];
    // 调整灰色图片的位置
    
    // 转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame) + 10;
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.delegate dropDownMenuDidShow:self];
    }
}

- (void)dismiss
{
    [self removeFromSuperview];
    // 通知代理我被别人点了 你快帮我做事情 坐我不会做的事 怎么做我不用管
    // 同志代理我要被销毁了, 把箭头朝下
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
