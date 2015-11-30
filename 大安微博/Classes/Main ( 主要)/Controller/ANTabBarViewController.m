//
//  ANTabBarViewController.m
//  大安微博
//
//  Created by a on 15/10/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTabBarViewController.h"
#import "ANProfileViewController.h"
#import "ANDiscoverViewController.h"
#import "ANHomeViewController.h"
#import "ANMessageCenterViewController.h"
#import "ANNavigationController.h"
#import "ANTabBar.h"
#import "ANComposeViewController.h"

@interface ANTabBarViewController () <ANTabBarDelegate>

@end

@implementation ANTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置子控制器
    ANHomeViewController *home = [[ANHomeViewController alloc] init];
    [self addChildVc:home WithTitle:@"主页" AndImageName:@"tabbar_home" AndSelectedImageName:@"tabbar_home_selected"];
    
    ANMessageCenterViewController *messageCenter = [[ANMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter WithTitle:@"消息" AndImageName:@"tabbar_message_center" AndSelectedImageName:@"tabbar_message_center_selected"];
    
    ANDiscoverViewController *discover = [[ANDiscoverViewController alloc] init];
    [self addChildVc:discover WithTitle:@"发现" AndImageName:@"tabbar_discover" AndSelectedImageName:@"tabbar_discover_selected"];
    
    ANProfileViewController *profile = [[ANProfileViewController alloc] init];
    [self addChildVc:profile WithTitle:@"我" AndImageName:@"tabbar_profile" AndSelectedImageName:@"tabbar_profile_selected"];
    
    // 更换系统自带的tabbar
//    self.tabBar = [[ANTabBar alloc] init]; // readOnly
    ANTabBar *tabBar = [[ANTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}



/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 高亮图片
 */
- (void)addChildVc:(UIViewController *)childVc WithTitle:(NSString *)title AndImageName:(NSString *)imageName AndSelectedImageName:(NSString *)selectedImageName
{
    // 设置文字
//    childVc.navigationItem.title = title;
//    childVc.tabBarItem.title = title;
    childVc.title = title;
    // 设置文字样式
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = ANColor(255, 111, 0, 1);
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    // 设置选中文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ANColor(123, 123, 123, 1);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    // 设置图片和图片保持原样不被渲染
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    在这里设置每个view的随机颜色的话, 刚打开所有view就会被创建, 耗性能;
//    childVc.view.backgroundColor = ANRandomColor;
    // 先给外面传进来的小控制器包装一个导航控制器
    ANNavigationController *nav = [[ANNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
    
}

#pragma mark ANTabBarDelegate 代理方法
- (void)tabBarDidClickPlusBtn:(ANTabBar *)tabbar
{
    ANComposeViewController *vc = [[ANComposeViewController alloc] init];
    ANNavigationController *nav = [[ANNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];

}
@end
