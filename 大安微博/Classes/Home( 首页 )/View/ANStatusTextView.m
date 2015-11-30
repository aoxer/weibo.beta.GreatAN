//
//  ANStatusTextView.m
//  大安微博
//
//  Created by a on 15/11/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANStatusTextView.h"
#import "ANSpecial.h" 
#define ANStatusTextViewCoverTag 999
@interface ANStatusTextView ()
@property (weak, nonatomic)UIButton *coverBtn;
@end
@implementation ANStatusTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.editable = NO;
        // 禁止滚动 让文字完全显示出来
        self.scrollEnabled = NO;
        
    }
    return self;
}

/**
 *  初始化矩形框
 */
- (void)setupSpecialRects
{
    // 获取特殊文字Range的数组
    NSArray *specialRanges = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    // 遍历特殊文字Range数组
    for (ANSpecial *special in specialRanges) {
        // specialRages里的range取出来赋值给selectedRage 用来改变self.selectedTextRange
        self.selectedRange = special.range;
        // 用special.range 获取range所在的矩形框的数组
        NSArray *specialRects = [self selectionRectsForRange:self.selectedTextRange];
        // 把selectedRange归0
        self.selectedRange = NSMakeRange(0, 0);
        
        // 创建一个存放特殊文字rect的数组
        NSMutableArray *rects = [NSMutableArray array];
        // 遍历获取到的特殊文字所在的矩形框数组 里面存的是UITextSelectionRect, UITextSelectionRect里面有所需rect
        for (UITextSelectionRect *selectionRect in specialRects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.height == 0 || rect.size.width == 0) continue;
            
            // 把UITextSelectionRect里的rect取出来放到存放特殊文字rect的数组
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        // 把存放特殊文字rect的数组传给special模型里的rects
        special.rects = rects;
    }
 
}

- (ANSpecial *)touchingSpecialWithPoint:(CGPoint)point
{
    // 获取特殊文字Range的数组
    NSArray *specialRanges = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    for (ANSpecial *special in specialRanges) {
        for (NSValue *rectValue in special.rects) {
            if (CGRectContainsPoint(rectValue.CGRectValue, point)) { // 点中了某个特殊的字符串
                return special;
            }
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 触摸对象
    UITouch *touch = [touches anyObject];
    // 触摸点
    CGPoint point = [touch locationInView:self];
    
    // 初始化矩形框
    [self setupSpecialRects];
    
    // 根据被触摸点获得被触摸的特殊字符串
    ANSpecial *special = [self touchingSpecialWithPoint:point];
    
    
    for (NSValue *rectValue in special.rects) {
            
        UIView *coverBtn = [[UIView alloc] init];
        coverBtn.backgroundColor = ANColor(100, 200, 250, 0.5);
        coverBtn.frame = rectValue.CGRectValue;
        coverBtn.tag = ANStatusTextViewCoverTag;
        coverBtn.layer.cornerRadius = 5;
        [self insertSubview:coverBtn atIndex:0];
 
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *lightView in self.subviews) {
        // 去掉特殊字符串后面的高亮背景
        if (lightView.tag == ANStatusTextViewCoverTag) [lightView removeFromSuperview];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // 初始化矩形框
    [self setupSpecialRects];
    
    ANSpecial *special = [self touchingSpecialWithPoint:point];
    
    if (special) {
        return YES;
    } else {
        return NO;
    }
}


@end
