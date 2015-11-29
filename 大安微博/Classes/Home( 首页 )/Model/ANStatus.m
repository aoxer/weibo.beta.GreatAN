//
//  ANStatus.m
//  大安微博
//
//  Created by a on 15/11/6.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANStatus.h"
#import "MJExtension.h"
#import "ANPhoto.h"
#import "RegexKitLite.h"
#import "ANUser.h"
#import "ANPart.h"
#import "ANEmotionTool.h"
#import "ANEmotions.h"

@implementation ANStatus

/**
 *  把普通文字转换成属性文字
 */
- (NSMutableAttributedString *)attributedStringWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    // 存放分段的数组
    NSMutableArray *parts = [NSMutableArray array];
    
    // 遍历所有特殊的字符串
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        if ((*capturedRanges).length == 0)  return ;
        
        ANPart *part = [[ANPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        
        [parts addObject:part];
        
    }];
    
    // 遍历所有非特殊的字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        if ((*capturedRanges).length == 0)  return ; 
        
        ANPart *part = [[ANPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        
        [parts addObject:part];
        
    }];
    
    // 排序
    // 系统是从小到大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(ANPart *part1, ANPart *part2) {
        //{NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};

        if (part1.range.location > part2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
        
    }];
//    ANLog(@"%@", parts);
    
    UIFont *font = [UIFont systemFontOfSize:15];
    // 按顺序拼接每一段文字
    for (ANPart *part in parts) {
        
        // 等下要拼接的字符串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            NSTextAttachment *attrStr = [[NSTextAttachment alloc] init];
            
            NSString *imgName = [ANEmotionTool emotionWithChs:part.text].png;
            if (imgName){
                attrStr.image = [UIImage imageNamed:imgName];
                attrStr.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attrStr];
            } else {
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.isSpecial){ // 非表情的特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        
        [attributedText appendAttributedString:substr];
    }
    
//    ANLog(@"%@", parts);
 
#pragma warning attributedText 一定要设置字体 否则会显示不准确
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:(NSRange){0, attributedText.length}];
    
    return attributedText;
}


- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    self.attributedText = [self attributedStringWithText:text];
}

- (void)setRetweeted_status:(ANStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status.user.name, retweeted_status.text];

    self.retweetedAttributedText = [self attributedStringWithText:retweetContent];
}


+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [ANPhoto class]};
}

//- (void)setCreated_at:(NSString *)created_at
//{
//    _created_at = created_at;
//}

- (NSString *)created_at
{
    // Fri Nov 13 16:40:48 +0800 2015
    // dateFormat = EEE MMM dd HH:mm:ss Z yyyy
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    
    //    _created_at = @"Tue Sep 30 17:06:25 +0800 2014";
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 微博的创建时间
    NSDate *creatDate = [fmt dateFromString:_created_at];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 创建日历对象, 方便比较两个日期之间的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:creatDate toDate:now options:0];
    
    if ([creatDate isThisYear]) { // 今年
        
        if ([creatDate isYesterday]) { // 昨天
            
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:creatDate];
            
        } else if ([creatDate isToday]) { // 今天
            
            if (cmps.hour>=1) { // 几小时前
                
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
                
            } else if (cmps.minute>=1) { // 几分钟前
                
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
                
            } else { // 刚刚
                
                return @"刚刚";
            }
            
        } else { // 今年的其他情况
            
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
            
        }
    } else { // 非今年
        
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:creatDate];
        
    }
    
}

- (void)setSource:(NSString *)source
{
    if (source.length != 0) {
    // <a href="http://app.weibo.com/t/feed/1GEU4g" rel="nofollow">Smartisan T1</a>,
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
//    range.length = [source rangeOfString:@"</"].location - range.location;
    range.length = [source rangeOfString:@"<" options:NSBackwardsSearch].location - range.location;
    
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
//    ANLog(@"%@", _source);
    }
 }
@end






















