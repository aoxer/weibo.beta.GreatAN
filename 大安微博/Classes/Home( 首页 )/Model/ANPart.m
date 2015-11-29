//
//  ANPart.m
//  大安微博
//
//  Created by a on 15/11/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANPart.h"

@implementation ANPart

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", NSStringFromRange(self.range), self.text];
}
@end
