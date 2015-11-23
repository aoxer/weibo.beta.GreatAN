//
//  ANEmotionListView.m
//  大安微博
//
//  Created by a on 15/11/18.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//


#import "ANEmotionListView.h"
#import "ANEmotionPageView.h"


@interface ANEmotionListView () <UIScrollViewDelegate>

@property (nonatomic, weak)UIPageControl *pageControl;
@property (nonatomic, weak)UIScrollView *scrollView;
@end
@implementation ANEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1.scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO; 
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        // 设置圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
    }
    return self;
}

- (void)layoutSubviews
{
    // 1.pageControl
    self.pageControl.width = ANScreenWidth;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.scrollView
    self.scrollView.height = self.pageControl.y;
    self.scrollView.width = self.width;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.pageView
    NSUInteger pageCount = self.scrollView.subviews.count;
    
    for (int i = 0; i<pageCount; i++) {
        UIView *pageView = self.scrollView.subviews[i];
        if ([pageView isKindOfClass:[UIView class]]) {
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.pageControl.numberOfPages * self.scrollView.width, 0);
    
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger pageCount = (emotions.count + ANEmotionPageSize - 1) / ANEmotionPageSize;
    // 设置页数
    self.pageControl.numberOfPages = pageCount;
    // 创建加载表情的pageView
    for (int i = 0; i<pageCount; i++) {
        ANEmotionPageView *pageView = [[ANEmotionPageView alloc] init]; 
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * ANEmotionPageSize;
        // 剩余表情数
        NSUInteger left = emotions.count - range.location;
        if (left < ANEmotionPageSize) {
            range.length = left;
        } else {
        range.length = ANEmotionPageSize;
        }
        // 把每页对应的20个表情提取出来存到pageView的emotionsPage里
        pageView.emotionsInPage = [emotions subarrayWithRange:range];
        
        [self.scrollView addSubview:pageView];
    }
    
    // 重新排布子控件位置
    [self setNeedsLayout];
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = self.scrollView.contentOffset.x / self.scrollView.width;
    
    self.pageControl.currentPage = (NSUInteger)(pageNo + 0.5);
}

@end
