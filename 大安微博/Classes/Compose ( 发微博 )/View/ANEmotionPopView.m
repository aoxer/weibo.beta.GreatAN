//
//  ANEmotionPopView.m
//  大安微博
//
//  Created by a on 15/11/21.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANEmotionPopView.h"
#import "ANEmotionButton.h"
@interface ANEmotionPopView ()
@property (weak, nonatomic) IBOutlet ANEmotionButton *emotionButton;

@end

@implementation ANEmotionPopView
- (void)showFromBtn:(ANEmotionButton *)button
{
    if (button == nil) return;
    
    // 给popView传递数据
    self.emotionButton.emotion = button.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算被点击的按钮在window中的frame
    CGRect btnFrameInWindow = [button convertRect:button.bounds toView:nil];
    self.centerX = CGRectGetMidX(btnFrameInWindow);
    self.y = CGRectGetMidY(btnFrameInWindow) - self.height;

}
+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANEmotionPopView" owner:nil options:nil] lastObject];
}















@end
