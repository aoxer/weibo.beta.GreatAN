//
//  ANEmotionTextView.h
//  大安微博
//
//  Created by a on 15/11/21.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTextView.h"
@class ANEmotions;
@interface ANEmotionTextView : ANTextView
- (void)insertEmotion:(ANEmotions *)emotions;
- (NSString *)fullText;
@end
