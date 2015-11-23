//
//  ANComposePhotosView.m
//  大安微博
//
//  Created by a on 15/11/17.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANComposePhotosView.h"

@implementation ANComposePhotosView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建一个photos
        _photos = [NSMutableArray array];
         
        self.y = 100;
        self.height = ANScreenHeight;
        self.width = ANScreenWidth;
    }
    return self;
}

- (void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    
    [self addSubview:photoView];
    
    // 存储图片
    [self.photos addObject:photo];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger photoCount = self.subviews.count;
    CGFloat photoWH = 70;
    CGFloat photoMargin = 10;
    NSUInteger maxCol = 3;
    
    for (int i = 0; i<photoCount; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        int row = i / maxCol;
        
        CGFloat photoY = row * (photoWH + photoMargin);
        CGFloat photoX = col * (photoWH + photoMargin);
        
        photoView.frame = CGRectMake(photoX, photoY, photoWH, photoWH);
    }
    
}
@end
