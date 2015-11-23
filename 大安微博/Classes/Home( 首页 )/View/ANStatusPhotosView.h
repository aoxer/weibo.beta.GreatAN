//
//  ANStatusPhotosView.h
//  大安微博
//
//  Created by a on 15/11/14.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANStatusPhotosView : UIView
@property (nonatomic, strong)NSArray *photos;

+ (CGSize)sizeWithCount:(NSUInteger)count;
@end
