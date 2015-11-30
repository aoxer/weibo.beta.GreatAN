//
//  ANStatusCell.m
//  大安微博
//
//  Created by a on 15/11/10.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANUser.h"
#import "ANStatus.h"
#import "ANStatusCell.h"
#import "ANStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "ANPhoto.h"
#import "ANStatusToolbar.h"
#import "ANStatusPhotosView.h"
#import "ANIconView.h"
#import "ANStatusTextView.h"
@interface ANStatusCell ()
/* 原创微博 */
/** 原创微博整体 */
@property (weak, nonatomic) UIView *originalView;
/** 头像 */
@property (weak, nonatomic) ANIconView *iconView;
/** 会员图标 */
@property (weak, nonatomic) UIImageView *vipView;
/** 配图 */
@property (weak, nonatomic) ANStatusPhotosView *photosView;
/** 昵称 */
@property (weak, nonatomic) UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) UILabel *timeLabel;
/** 来自 */
@property (weak, nonatomic) UILabel *sourceLabel;
/** 正文 */
@property (weak, nonatomic) ANStatusTextView *contentLabel;

/** 转发微博整体 */
@property (weak, nonatomic) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (weak, nonatomic) ANStatusTextView *retweetContentLabel;
/** 转发配图 */
@property (weak, nonatomic) ANStatusPhotosView *retweetPhotosView;

/** 转发微博整体 */
@property (weak, nonatomic) ANStatusToolbar *toolbarView;


@end
@implementation ANStatusCell

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += ANStatusCellMargin;
//    [super setFrame:frame];
//}

// 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"statuses";
    ANStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ANStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法
 *  一般在这里添加所有可能显示的子控件以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // 点击cell时候不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化原创微博
        [self setupOriginal];
        
        // 初始化转发微博
        [self setupRetweet];
        
        // 初始化工具条
        [self setupToolbar];
    }
    return self;
}


/**
 *  初始化转发微博
 */
- (void)setupToolbar
{
    ANStatusToolbar *toolbarView = [ANStatusToolbar toolbar];
    [self.contentView addSubview:toolbarView];
    self.toolbarView = toolbarView;
}

/**
 *  初始化转发微博
 */
- (void)setupRetweet
{
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = ANColor(240, 240, 240, 1);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 昵称 +正文 */
    ANStatusTextView *retweetContentLabel = [[ANStatusTextView alloc] init];
    retweetContentLabel.font = ANStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发配图 */
    ANStatusPhotosView *retweetPhotosView = [[ANStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}

/**
 *  初始化原创微博
 */
- (void)setupOriginal
{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像 */
    ANIconView *iconView = [[ANIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    /** 配图 */
    ANStatusPhotosView *photosView = [[ANStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    nameLabel.font = ANStatusCellNameFont;
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = ANStatusCellTimeFont;
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来自 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = ANStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    ANStatusTextView *contentLabel = [[ANStatusTextView alloc] init];
    contentLabel.font = ANStatusCellContentFont;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)setStatusFrame:(ANStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 拿到模型 便于操作
    ANStatus *status = statusFrame.status;
    ANUser *user = status.user;
    
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    /** 会员图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipRank = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipRank];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
        
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
//    
//    NSString *newTime = status.created_at;
//    NSUInteger timeLength = self.timeLabel.text.length;
//    if (timeLength && timeLength != newTime.length) {
    
    /** 时间  */
    NSString *creatTime = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + ANStatusCellBorderWidth;
    CGSize timeSize = [creatTime sizeWithFont:ANStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = creatTime;
    
    /** 来自 */
    CGFloat sourceX = CGRectGetMaxX(statusFrame.timeLabelF) + ANStatusCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:ANStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.attributedText = status.attributedText;
    
    
    /** 被转发的微博 */
    if (status.retweeted_status) {
        ANStatus *retweeted_status = status.retweeted_status;
        
        self.retweetView.hidden = NO;
        /** 被转发的微博整体 */
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 被转发的微博正文 */
        self.retweetContentLabel.attributedText = status.retweetedAttributedText;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 被转发的微博配图 */
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = status.retweeted_status.pic_urls;
            
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
    
    /** 工具条 */
    self.toolbarView.frame = statusFrame.toolbarViewF;
    self.toolbarView.status = status;
}

@end
