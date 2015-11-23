//
//  ANComposeToolbar.h
//  大安微博
//
//  Created by a on 15/11/17.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ANComposeToolbarButtonTypeCamera,  //相机
    ANComposeToolbarButtonTypePicture, //图片
    ANComposeToolbarButtonTypeMention, //@
    ANComposeToolbarButtonTypeTrend,   // #
    ANComposeToolbarButtonTypeEmotion  //表情

}ANComposeToolbarButtonType;

@class ANComposeToolbar;
@protocol ANComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(ANComposeToolbar *)toolbar didClickButton:(ANComposeToolbarButtonType)buttonType;

@end

@interface ANComposeToolbar : UIView

@property (weak, nonatomic)id<ANComposeToolbarDelegate>delegate;

@property (nonatomic, assign) BOOL showKeyboardBtn;
@end
