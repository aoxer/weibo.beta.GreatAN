//
//  ANIconView.m
//  大安微博
//
//  Created by a on 15/11/15.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANIconView.h"
#import "ANUser.h"
#import "UIImageView+WebCache.h"

@interface ANIconView ()

@property (nonatomic, weak) UIImageView *verifiedView;

@end

@implementation ANIconView

/**
 *  懒加载
 */
- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        
        self.verifiedView = verifiedView;
    
    }
    return _verifiedView;
}

- (void)setUser:(ANUser *)user
{
    _user = user;
    
    // 加载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 设置加V图片
    switch (user.verified_type) {
        case ANUserVerifiedTypePersonal: // 个人认证
            self.verifiedView.hidden = NO;
            [self.verifiedView setImage:[UIImage imageNamed:@"avatar_vip"]];
            break;
            
        case ANUserVerifiedTypeOrgEnterprice:
        case ANUserVerifiedTypeOrgMedia:
        case ANUserVerifiedTypeOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            [self.verifiedView setImage:[UIImage imageNamed:@"avatar_enterprise_vip"]];
            break;
            
        case ANUserVerifiedTypeDaren: // 达人
            self.verifiedView.hidden = NO;
            [self.verifiedView setImage:[UIImage imageNamed:@"avatar_grassroot"]];
            break;
            
        default:
            self.verifiedView.hidden = YES; // 没有任何认证
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
    
}
@end
