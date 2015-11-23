//
//  UITextView+Extension.m
//  大安微博
//
//  Created by a on 15/11/21.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    // 创建一个带属性的字符串
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字(图片和文字)
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接其他文字
    NSUInteger loc = self.selectedRange.location;
//    [attributedText insertAttributedString:text atIndex:loc];
    
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
   
    // 外面传进来的代码
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
    // 把上面的东西赋值给textView
    self.attributedText = attributedText;
    // 把光标移到属性文字后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}


- (void)insertImage:(NSString *)image settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的attrbutedText
    [attributedText appendAttributedString:self.attributedText];
    
    // 设置图片附件
    NSTextAttachment *imgAttach = [[NSTextAttachment alloc] init];
    imgAttach.image = [UIImage imageNamed:image];
    // 设置图片大小
    CGFloat imgAttchWH = self.font.lineHeight;
    imgAttach.bounds = CGRectMake(0, -4, imgAttchWH, imgAttchWH);
    
    // 根据附件创建一个图片属性文字
    NSAttributedString *imgString = [NSAttributedString attributedStringWithAttachment:imgAttach];
   
    // 获取光标位置
    NSUInteger loc = self.selectedRange.location;
    // 把这个带属性的图片插入到光标处
//    [attributedText insertAttributedString:imgString atIndex:loc];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:imgString];
    
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
    // 把上面的东西赋值给textView
    self.attributedText = attributedText;
    // 把光标移到属性文字后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
    
}

 

@end
