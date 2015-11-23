//
//  ANStatusPhotosView.m
//  大安微博
//
//  Created by a on 15/11/14.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANStatusPhotosView.h"
#import "ANPhoto.h"
#import "ANStatusPhotoView.h"

#define ANStatusPhotosMaxCol(count) ((count==4)?2:3)
// 图片的宽高
#define ANStatusPhotoWH 75
// 图片的间距
#define ANStatusPhotoMargin 10

@implementation ANStatusPhotosView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
//        self.backgroundColor = ANRandomColor;
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    NSUInteger photosCount = photos.count;
    // 创建足够数量的图片控件
    while (self.subviews.count < photosCount) {
        ANStatusPhotoView *photoView = [[ANStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有图片控件为其设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        ANStatusPhotoView *photoView = self.subviews[i];
        
        if (i<photosCount) { // 显示
            photoView.photo = photos[i];
            
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

/**
 *  设置图片的尺寸和位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSUInteger photosCount = self.photos.count;
    NSUInteger maxCol = ANStatusPhotosMaxCol(photosCount);
    
    for (int i  = 0; i<self.photos.count; i++) {
        
        ANStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        int row = i / maxCol;
        photoView.x = col * (ANStatusPhotoWH + ANStatusPhotoMargin);
        photoView.y = row * (ANStatusPhotoWH + ANStatusPhotoMargin);
        photoView.width = ANStatusPhotoWH;
        photoView.height = ANStatusPhotoWH;
        
    }
    
    
}


+ (CGSize)sizeWithCount:(NSUInteger)count
{
    NSInteger maxCols = ANStatusPhotosMaxCol(count);
    
    // 列数
    NSInteger clos = (count >= maxCols) ? maxCols : count;
    CGFloat photosW = clos * ANStatusPhotoWH + (clos - 1) * ANStatusPhotoMargin;
    
    // 行数
    NSInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * ANStatusPhotoWH + (rows - 1) * ANStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    
}
@end
