//
//  ANStatusPhotoView.m
//  大安微博
//
//  Created by a on 15/11/15.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "ANPhoto.h"

@interface ANStatusPhotoView ()

@property (weak, nonatomic) UIImageView *gifView;


@end
@implementation ANStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        UIViewContentModeScaleToFill,
//        UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
//        UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//        UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
//        UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
//        UIViewContentModeTop,
//        UIViewContentModeBottom,
//        UIViewContentModeLeft,
//        UIViewContentModeRight,
//        UIViewContentModeTopLeft,
//        UIViewContentModeTopRight,
//        UIViewContentModeBottomLeft,
//        UIViewContentModeBottomRight,
        
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        self.clipsToBounds = YES;
    }
    return self;
}
/**
 *  懒加载
 */
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        
        self.gifView = gifView;
        
    }
    return _gifView;
}

- (void)setPhoto:(ANPhoto *)photo
{
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
