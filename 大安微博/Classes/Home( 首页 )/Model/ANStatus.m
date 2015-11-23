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
@implementation ANStatus

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






















