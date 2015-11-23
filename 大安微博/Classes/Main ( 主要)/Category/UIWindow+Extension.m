//
//  UIWindow+Extension.m
//  大安微博
//
//  Created by a on 15/11/5.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "ANNewFeatureViewController.h"
#import "ANTabBarViewController.h"

@implementation UIWindow (Extension)


- (void)switchRootViewController
{
    // 判断版本号
    // 读取沙盒里的版本号
    NSString *versionKey = @"CFBundleVersion";
    // 上一次使用的版本(存在沙盒中的版本号)
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    // 当前版本号
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][versionKey];
    
    // 获取主窗口
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [[ANTabBarViewController alloc] init];
    } else {
        self.rootViewController = [[ANNewFeatureViewController alloc] init];
        
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end

