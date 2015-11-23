//
//  ANEmotionTextView.m
//  大安微博
//
//  Created by a on 15/11/21.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANEmotionTextView.h"
#import "ANEmotions.h" 
#import "ANEmotionAttachment.h"

@implementation ANEmotionTextView

- (void)insertEmotion:(ANEmotions *)emotions
{
    
    if (emotions.code) {
        [self insertText:emotions.code.emoji];
    } else if (emotions.png){
         // 插入一个图片表情
//        [self insertImage:emotions.png settingBlock:^(NSMutableAttributedString *attributedText) {
//            [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, attributedText.length)];
//        }];
        
         //加载图片附件
        ANEmotionAttachment *imgAttach = [[ANEmotionAttachment alloc] init];
        // 传递表情模型
        imgAttach.emotion = emotions;
        // 设置图片尺寸
        CGFloat imgAttchWH = self.font.lineHeight;
        imgAttach.bounds = CGRectMake(0, -4, imgAttchWH, imgAttchWH);
        
        // 根据附件创建一个属性文字
        NSAttributedString *imgString = [NSAttributedString attributedStringWithAttachment:imgAttach];
        
        // 把这个带属性的文字插入到光标处
        [self insertAttributedText:imgString settingBlock:^(NSMutableAttributedString *attrbutedText) {
            // 设置字体
            [attrbutedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attrbutedText.length)];
        }];
        
        
//         设置字体
//        NSMutableAttributedString *text = (NSMutableAttributedString *)self.attributedText;
//        [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    }
}


- (NSString *)fullText
{

    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        ANEmotionAttachment *attachment = attrs[@"NSAttachment"];
        
        if (attachment) { // 有表情
            [fullText appendString:attachment.emotion.chs];
        } else { // 没有表情
            NSAttributedString *attrStr = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:attrStr.string];
        }
    }];
    
    return fullText;
}
/*
 selectedRange:
 1.本来是用来控制textView的文字选中范围
 2.如果selectedRange.length为0, selectedrange.location就是textView的光标位置
 
 关于textView文字的字体
 1.如果是普通文字 (text), 文字大小有textView.font控制
 2.如果是属性文字 (attrbutedText), 文字大小不受textView.font控制, 应该利用NSMutableAttributedString的 - (void)addAttrbute:(NSString *)name value:(id)value range:(NSRange)range; 方法设置字体;
 
 */

@end



















