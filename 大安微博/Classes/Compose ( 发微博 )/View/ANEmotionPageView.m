//
//  ANEmotionPageView.m
//  黑马微博2期
//
//  Created by apple on 14-10-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ANEmotionPageView.h"
#import "ANEmotions.h"
#import "ANEmotionPopView.h"
#import "ANEmotionButton.h"
#import "ANEmotionTool.h"
@interface ANEmotionPageView()
/** 点击表情后弹出的放大镜 */
@property (nonatomic, strong) ANEmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation ANEmotionPageView

- (ANEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [ANEmotionPopView popView];
    }
    return _popView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 2.添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

/**
 *  根据手指位置所在的表情按钮
 */
- (ANEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotionsInPage.count;
    for (int i = 0; i<count; i++) {
        ANEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            
            // 已经找到手指所在的表情按钮了，就没必要再往下遍历
            return btn;
        }
    }
    return nil;
}

/**
 *  在这个方法中处理长按手势
 */
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    // 获得手指所在的位置\所在的表情按钮
    ANEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: // 手指已经不再触摸pageView
            // 移除popView
            [self.popView removeFromSuperview];
            
            // 如果手指还在表情按钮上
            if (btn) {
                // 发出通知
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[ANSelectEmotionKey] = btn.emotion;
                [ANNotificationCenter postNotificationName:ANEmotionDidSelectNotification object:nil userInfo:userInfo];
            }
            break;
            
        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
        case UIGestureRecognizerStateChanged: { // 手势改变（手指的位置改变）
            [self.popView showFromBtn:btn];
            break;
        }
            
        default:
            break;
    }
}

- (void)setEmotionsInPage:(NSArray *)emotionsInPage
{
    _emotionsInPage = emotionsInPage;
    
    NSUInteger count = emotionsInPage.count;
    for (int i = 0; i<count; i++) {
        ANEmotionButton *btn = [[ANEmotionButton alloc] init];
        [self addSubview:btn];
        
        // 设置表情数据
        btn.emotion = emotionsInPage[i];
        
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

// CUICatalog: Invalid asset name supplied: (null), or invalid scale factor: 2.000000
// 警告原因：尝试去加载的图片不存在

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 内边距(四周)
    CGFloat inset = 20;
    NSUInteger count = self.emotionsInPage.count;
    CGFloat btnW = (self.width - 2 * inset) / ANEmotionsMaxCols;
    CGFloat btnH = (self.height - inset) / ANEmotionsMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%ANEmotionsMaxCols) * btnW;
        btn.y = inset + (i/ANEmotionsMaxCols) * btnH;
    }
    
    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.x = self.width - inset - btnW;
}

/**
 *  监听删除按钮点击
 */
- (void)deleteClick
{
    [ANNotificationCenter postNotificationName:ANEmotionDidClickDeleteButtonNotification object:nil];
}

/**
 *  监听表情按钮点击
 *
 *  @param btn 被点击的表情按钮
 */
- (void)btnClick:(ANEmotionButton *)btn
{
    // 显示popView
    [self.popView showFromBtn:btn];
    
    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    [self selecteEmotion:btn.emotion];
}
/**
 *  选中某个表情 发出通知
 *
 *  @param emotion 被选中的表情模型
 */
- (void)selecteEmotion:(ANEmotions *)emotion
{
    // 存进沙盒
    [ANEmotionTool addRecentEmotion:emotion];
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[ANSelectEmotionKey] = emotion;
    [ANNotificationCenter postNotificationName:ANEmotionDidSelectNotification object:nil userInfo:userInfo];
}
@end
