//
//  ANTextView.h
//  大安微博
//
//  Created by a on 15/11/16.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANTextView : UITextView

/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  占位文字颜色
 */
@property (nonatomic, strong)UIColor *placeholderColor;

@end
