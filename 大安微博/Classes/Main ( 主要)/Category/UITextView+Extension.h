//
//  UITextView+Extension.h
//  大安微博
//
//  Created by a on 15/11/21.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

/**
 *  插入一个图片 如表情等 可传block定义字体大小颜色等
 */
- (void)insertImage:(NSString *)image settingBlock:(void(^)(NSMutableAttributedString *attributedText))settingBlock;;
/**
 *  插入一个带属性的字符串 可传block定义字体大小颜色等
 */
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *attrbutedText))settingBlock;
@end
