//
//  ANEmotionAttachment.m
//  大安微博
//
//  Created by a on 15/11/22.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANEmotionAttachment.h"
#import "ANEmotions.h"
@implementation ANEmotionAttachment

- (void)setEmotion:(ANEmotions *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
