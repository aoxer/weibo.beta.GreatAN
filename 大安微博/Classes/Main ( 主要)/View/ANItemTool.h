//
//  ANItemTool.h
//  大安微博
//
//  Created by a on 15/10/27.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANItemTool : NSObject
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action andImageName:(NSString *)imageName andImageNameHighlight:(NSString *)imageNameHighlight;
@end
