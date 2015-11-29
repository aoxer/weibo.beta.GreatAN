//
//  ANStatusFrame.m
//  大安微博
//
//  Created by a on 15/11/10.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//


#import "ANStatusFrame.h"
#import "ANStatus.h"
#import "ANUser.h"
#import "ANStatusPhotosView.h"
@implementation ANStatusFrame
 
- (void)setStatus:(ANStatus *)status
{
    _status = status;
    
    ANUser *user = status.user;
    
    /** 原创微博整体 */
    
    /** 头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = ANStatusCellBorderWidth;
    CGFloat iconY = ANStatusCellBorderWidth;
    
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
   
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + ANStatusCellBorderWidth;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:ANStatusCellNameFont];
    
//    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    /** 会员图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + ANStatusCellBorderWidth;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + ANStatusCellBorderWidth;
    CGSize timeSize = [status.created_at sizeWithFont:ANStatusCellTimeFont];
    
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来自 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + ANStatusCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:ANStatusCellSourceFont];
    
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + ANStatusCellBorderWidth;
    CGFloat maxW = ANScreenWidth - 2 * contentX;
    CGSize contentSize = [status.attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图 */
    CGFloat originalH = 0;
    
    if (status.pic_urls.count) {
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelF) + ANStatusCellBorderWidth;
        CGSize photosSize = [ANStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX, photosY}, photosSize};
        originalH = CGRectGetMaxY(self.photosViewF) + ANStatusCellBorderWidth;
    } else { // 没配图
        originalH = CGRectGetMaxY(self.contentLabelF) + ANStatusCellBorderWidth;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = ANStatusCellMargin;
    CGFloat originalW = ANScreenWidth;
    self.originalViewF = (CGRect){{originalX, originalY}, {originalW, originalH}};
 
    
    /* 被转发微博 */
    CGFloat toolbarViewY = 0;
    if (status.retweeted_status) {
        /* 被转发的微博 */
        CGFloat retweetContentX = ANStatusCellBorderWidth;
        CGFloat retweetContentY = ANStatusCellBorderWidth;
        CGFloat maxW = ANScreenWidth - 2 * retweetContentX;
        
        CGSize retweetContentSize = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
    
        /* 被转发微博的配图 */
        CGFloat retweetViewH = 0;
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + ANStatusCellBorderWidth;
            CGSize retweetPhotosSize = [ANStatusPhotosView sizeWithCount:status.retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotoX, retweetPhotoY}, retweetPhotosSize};
            
            retweetViewH = CGRectGetMaxY(self.retweetPhotosViewF) + ANStatusCellBorderWidth;
        } else {
            retweetViewH = CGRectGetMaxY(self.retweetContentLabelF) + ANStatusCellBorderWidth;
        }
        
        /* 被转发微博的整体 */
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetViewW = ANScreenWidth;
        self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        toolbarViewY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolbarViewY = CGRectGetMaxY(self.originalViewF) + 0.5;
           }
    
    CGFloat toolbarViewX = 0;
    CGFloat toolbarViewW = ANScreenWidth;
    CGFloat toolbarViewH = 30;
    
    self.toolbarViewF = CGRectMake(toolbarViewX, toolbarViewY, toolbarViewW, toolbarViewH);
 
    self.cellHeight = CGRectGetMaxY(self.toolbarViewF);
}

@end














