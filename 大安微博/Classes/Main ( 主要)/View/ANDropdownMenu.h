//
//  ANDropdownMenu.h
//  大安微博
//
//  Created by a on 15/10/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANDropdownMenu;
@protocol ANDropdownMenuDelegate <NSObject>

@optional
- (void)dropDownMenuDidDismiss:(ANDropdownMenu *)dropdownMenu;
- (void)dropDownMenuDidShow:(ANDropdownMenu *)dropdownMenu;


@end

@interface ANDropdownMenu : UIView
@property (weak, nonatomic)id<ANDropdownMenuDelegate>delegate;

/**
 *  内容
 */
@property (nonatomic, strong)UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong)UIViewController *contentController;

+ (instancetype)menu;
/**
 *  显示
 *
 *  @param from 点击谁/ 哪里需要下拉菜单
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;
@end
