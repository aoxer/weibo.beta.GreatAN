//
//  ANStatusToolbar.m
//  大安微博
//
//  Created by a on 15/11/12.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANStatusToolbar.h"
#import "ANStatus.h"

@interface ANStatusToolbar ()
/**
 *  存放所有按钮的数组
 */
@property (strong, nonatomic)NSMutableArray *btns;
/**
 *  存放所有分割线
 */
@property (strong, nonatomic)NSMutableArray *dividers;


@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation ANStatusToolbar

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}
+ (instancetype)toolbar
{
    return [[self alloc] init];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        self.repostBtn = [self setupBtnWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" icon:@"timeline_icon_unlike"];
        
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}

/**
 *  添加分割线 
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}


/**
 *  初始化一个按钮
 *
 *  @param title 按钮文字
 *  @param icon  按钮图标
 */
- (UIButton *)setupBtnWithTitle:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置按钮的frame
    NSUInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
    
    // 设置分割线的frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i+1) *btnW;
        divider.y = 0;
    }
    
}

- (void)setStatus:(ANStatus *)status
{
    _status = status;
        status.reposts_count = 580456; // 58.7万
        status.comments_count = 100004; // 1万
        status.attitudes_count = 604; // 604
    
    // 转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    // 评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"转发"];
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
    
}

/**
 *  设置按钮数字
 *
 *  @param count 数
 *  @param btn   按钮
 *  @param title 标题
 */
- (void)setupBtnCount:(NSUInteger )count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) { // 数字不为0
        if (count<10000) { // 不足10000
            title = [NSString stringWithFormat:@"%ld", count];
        } else {
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%1f万", wan];
            // 将字符串里面的0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
    } else {
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end
