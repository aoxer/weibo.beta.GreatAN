//
//  ANItemTool.m
//  大安微博
//
//  Created by a on 15/10/27.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANItemTool.h"

@implementation ANItemTool
/**
 *  创建一个item
 *
 *  @param action             点击item后调用的方法
 *  @param imageName          图片名称
 *  @param imageNameHighlight 高亮图片名称
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action andImageName:(NSString *)imageName andImageNameHighlight:(NSString *)imageNameHighlight
{
    // 设置右边按钮
    UIButton *btn = [[UIButton alloc] init];
    // 监听点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置右边按钮图片
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageNameHighlight] forState:UIControlStateHighlighted];
    // 设置右边
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



@end
