//
//  ANStatusCell.h
//  大安微博
//
//  Created by a on 15/11/10.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANStatusFrame;

@interface ANStatusCell : UITableViewCell

@property (nonatomic, strong)ANStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
