//
//  ANComposeToolbar.m
//  大安微博
//
//  Created by a on 15/11/17.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANComposeToolbar.h"

@interface ANComposeToolbar ()


/**
 *  表情 键盘 按钮
 */
@property (weak, nonatomic) UIButton *emotionButton;

@end

@implementation ANComposeToolbar

- (void)setShowKeyboardBtn:(BOOL)showKeyboardBtn
{
    _showKeyboardBtn = showKeyboardBtn;
    
    // 默认图片名
    
//    NSString *image = @"compose_keyboardbutton_background";
//    NSString *highImage = @"compose_keyboardbutton_background_highlighted";
//    
//    // 显示键盘图标
//    if (!showKeyboardBtn) { //键盘按钮
//        
//        image = @"compose_emoticonbutton_background";
//        highImage = @"compose_emoticonbutton_background_highlighted";
//    }
//    //设置图片
//    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    if (showKeyboardBtn) { //键盘按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        
    } else { // 表情按钮        
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
   
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.height = 44;
        self.width = ANScreenWidth;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setupBtnWithImageName:@"compose_camerabutton_background" highlightImageName:@"compose_camerabutton_background_highlighted" btnType:ANComposeToolbarButtonTypeCamera];
        
        [self setupBtnWithImageName:@"compose_toolbar_picture" highlightImageName:@"compose_toolbar_picture_highlighted" btnType:ANComposeToolbarButtonTypePicture];
        
        [self setupBtnWithImageName:@"compose_mentionbutton_background" highlightImageName:@"compose_mentionbutton_background_highlighted" btnType:ANComposeToolbarButtonTypeMention];
        
        [self setupBtnWithImageName:@"compose_trendbutton_background" highlightImageName:@"compose_trendbutton_background_highlighted" btnType:ANComposeToolbarButtonTypeTrend];
        
       self.emotionButton = [self setupBtnWithImageName:@"compose_emoticonbutton_background" highlightImageName:@"compose_emoticonbutton_background_highlighted" btnType:ANComposeToolbarButtonTypeEmotion];
        
    }
    return self;
}

- (UIButton *)setupBtnWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName btnType:(ANComposeToolbarButtonType)btnType
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    btn.tag =  btnType;
    // 监听btn点击
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置所有按钮的frame;
    NSUInteger count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
//        btn.backgroundColor = ANRandomColor;
        btn.height = self.height;
        btn.width = ANScreenWidth / count;
        btn.x = i * btn.width;
        btn.y = 0;
    }
}

/**
 *  点击按钮
 */
- (void)btnClick:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        
        [self.delegate composeToolbar:self didClickButton:(ANComposeToolbarButtonType)btn.tag];
    }
}


@end
