//
//  ANSpecial.m
//  大安微博
//
//  Created by a on 15/11/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANSpecial.h"

@implementation ANSpecial
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
