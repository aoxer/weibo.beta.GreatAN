//
//  ANStatusToolbar.h
//  大安微博
//
//  Created by a on 15/11/12.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANStatus;
@interface ANStatusToolbar : UIView
+ (instancetype)toolbar;
@property (nonatomic, strong)ANStatus *status;
@end
