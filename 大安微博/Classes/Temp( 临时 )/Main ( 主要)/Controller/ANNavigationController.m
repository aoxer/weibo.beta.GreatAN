//
//  ANNavigationController.m
//  大安微博
//
//  Created by a on 15/10/26.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANNavigationController.h"

@interface ANNavigationController ()

@end

@implementation ANNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  重写这个方法的目的: 能够拦截push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController, 不是第一个控制器 (不是根控制器)
        
        
        // 自动系显示/隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航栏上的内容
        // 设置左边按钮
        UIButton *backBtn = [[UIButton alloc] init];
        // 监听点击
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 设置左边按钮图片
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        // 设置按钮尺寸
        backBtn.size = backBtn.currentBackgroundImage.size;
        // 定义左上角按钮为自定义view
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        // 设置右边按钮
        UIButton *MoreBtn = [[UIButton alloc] init];
        // 监听点击
        [MoreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        // 设置右边按钮图片
        [MoreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [MoreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        // 设置右边
        MoreBtn.size = MoreBtn.currentBackgroundImage.size;
        
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:MoreBtn];
    }
    
    [super pushViewController:viewController animated:animated];
    
}


- (void)back
{
#warning 这里要用self, 不是self.navigationController
    // 因为self本身就是一个导航控制器,self.navigationController是空的
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
