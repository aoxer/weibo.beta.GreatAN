//
//  ANEmotions.m
//  大安微博
//
//  Created by a on 15/11/20.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANEmotions.h"
#import "MJExtension.h"

@interface ANEmotions ()<NSCoding>

@end
@implementation ANEmotions

MJCodingImplementation
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    if (self = [super init]) {
//        self.png = [decoder decodeObjectForKey:@"png"];
//        self.chs = [decoder decodeObjectForKey:@"chs"];
//        self.code = [decoder decodeObjectForKey:@"code"];
//    
//    }
//    return self;
//}
//
//-(void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.png forKey:@"png"];
//    [encoder encodeObject:self.chs forKey:@"chs"];
//    [encoder encodeObject:self.code forKey:@"code"];
//
//}

- (BOOL)isEqual:(ANEmotions *)other
{
    return ([self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code]);
}
@end
