//
//  NSString+Extension.h
//  大安微博
//
//  Created by a on 15/11/10.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
@end
