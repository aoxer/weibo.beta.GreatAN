//
//  ANStatusFrame.h
//  大安微博
//
//  Created by a on 15/11/10.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

// 1.存放着一个cell内部所有子控件的frame数据
// 2.存放着一个cell的高度
// 3.存放着一个数据模型ANStatus

#import <Foundation/Foundation.h>
// 昵称字体
#define ANStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define ANStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define ANStatusCellSourceFont ANStatusCellTimeFont
// 正文字体
#define ANStatusCellContentFont [UIFont systemFontOfSize:14]
// 被转发微博正文字体
#define ANStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

// cell的边框宽度
#define ANStatusCellBorderWidth 10
// cell的间距
#define ANStatusCellMargin 13

@class ANStatus;
@interface ANStatusFrame : NSObject

@property (nonatomic, strong)ANStatus *status;
/** 原创微博整体frame */
@property (assign, nonatomic) CGRect originalViewF;
/** 头像frame */
@property (assign, nonatomic) CGRect iconViewF;
/** 会员图标frame */
@property (assign, nonatomic) CGRect vipViewF;
/** 配图frame */
@property (assign, nonatomic) CGRect photosViewF;
/** 昵称frame */
@property (assign, nonatomic) CGRect nameLabelF;
/** 时间frame */
@property (assign, nonatomic) CGRect timeLabelF;
/** 来自frame */
@property (assign, nonatomic) CGRect sourceLabelF;
/** 正文frame */
@property (assign, nonatomic) CGRect contentLabelF;

/** 转发微博整体 */
@property (assign, nonatomic) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (assign, nonatomic) CGRect retweetContentLabelF;
/** 转发配图 */
@property (assign, nonatomic) CGRect retweetPhotosViewF;

/** 工具条整体 */
@property (assign, nonatomic) CGRect toolbarViewF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
