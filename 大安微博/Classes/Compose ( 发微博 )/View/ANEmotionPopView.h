//
//  ANEmotionPopView.h
//  大安微博
//
//  Created by a on 15/11/21.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANEmotions, ANEmotionButton;
@interface ANEmotionPopView : UIView
/**
 *  从button处弹出放大镜
 */
- (void)showFromBtn:(ANEmotionButton *)button;

+ (instancetype)popView;
@end
