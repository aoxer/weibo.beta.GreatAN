//
//  ANComposePhotosView.h
//  大安微博
//
//  Created by a on 15/11/17.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANComposePhotosView : UIView
- (void)addPhoto:(UIImage *)photo;
@property (nonatomic, strong, readonly)NSMutableArray *photos;
@end
