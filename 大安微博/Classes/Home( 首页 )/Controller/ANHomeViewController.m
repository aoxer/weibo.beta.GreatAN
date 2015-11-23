//
//  ANHomeViewController.m
//  大安微博
//
//  Created by a on 15/10/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANHomeViewController.h"
#import "ANDropdownMenu.h"
#import "ANTitleMenuViewController.h"
#import "ANAccountTool.h"
#import "AFNetworking.h"
#import "ANTitleButton.h"
#import "UIImageView+WebCache.h"
#import "ANUser.h"
#import "ANStatus.h"
#import "MJExtension.h"
#import "ANLoadMoreFooter.h"
#import "ANStatusCell.h"
#import "ANStatusFrame.h"

@interface ANHomeViewController () <ANDropdownMenuDelegate>

/**
 *  微博数组 ( 里面放的是ANStasusFrame模型, 一个ANStatusFrame代表一个模型)
 */
@property (nonatomic, strong)NSMutableArray *statusFrames;
@end

@implementation ANHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = ANColor(211, 211, 211);
    
    // 设置footer高度
    self.tableView.tableFooterView.height = 44;
    // 设置导航栏内容
    [self setupNav];
    
    // 获得用户信息 ( 昵称 )
    [self setupUserInfo];
    
    // 加载微博数据
    // [self loadNewStatus];
    
    // 下拉刷新
    [self setupPullDownRefresh];
    
    // 加载上拉数据
    [self setupPullUpRefresh];
    
    // 获得未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
//    // 主线程也会抽时间处理下timer ( 不管主线程是否正在其他事件 )
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setupUnreadCount
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接参数
    ANAccount *account = [ANAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0 得清空数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"请求失败%@", error);
    }];
    
}

// 设置上拉刷新
- (void)setupPullUpRefresh
{
    ANLoadMoreFooter *footer = [ANLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
}

// 加载更多微博数据
- (void)loadMoreStatus
{
    // 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    ANAccount *account = [ANAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    
    // 取出最后面的微博
    ANStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    if (lastStatusFrame) {
        long long maxId = lastStatusFrame.status.idstr.longLongValue - 1;
        parameters[@"max_id"] = @(maxId);
    }
    
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 将微博字典数组转为微博模型数组
        NSArray *newStatuses = [ANStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将ANStatus数组转为ANStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        // 将更多地微博数据,添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新, 隐藏footer
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"error%@", error);
        self.tableView.tableFooterView.hidden = YES;
    }];
    
}

// 设置下拉刷新控件
- (void)setupPullDownRefresh
{
    // 添加下拉刷新
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    // 只有通过手动下拉刷新,才会触发UIControlEventValueChange
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    // 开始刷新
    [control beginRefreshing];
    [self loadNewStatus:control];
}

/**
 *   将ANStatus数组转为ANStatusFrame数组
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (ANStatus *status in statuses) {
        ANStatusFrame *statusFrame = [[ANStatusFrame alloc] init];
        statusFrame.status = status;
        [frames addObject:statusFrame];
    }
    return frames;
}

/**
 *  下拉加载新微博
 */
- (void)loadNewStatus:(UIRefreshControl *)control
{
    // 获取管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    ANAccount *account = [ANAccountTool account];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = account.access_token;
    
    // 取出最前面的微博
    ANStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    if (firstStatusFrame) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        parameter[@"since_id"] = firstStatusFrame.status.idstr;    }
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 将微博字典转为微博模型
        NSArray *newStatuses = [ANStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        ANLog(@"responseObject%@",responseObject);
        
        // 将ANStatus数组转为ANStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        // 将最新的微博数据添插入总数组里
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 停止菊花
        [control endRefreshing];
        
        // 显示更新微博数
        [self showStatusesCount:(int)newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"error%@", error);
        // 停止菊花
        [control endRefreshing];
    }];
}

// 显示更新的微博数量
- (void)showStatusesCount:(int)count
{
    // 1.创建显示微博数量的View
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.width = ANScreenWidth;
    countLabel.height = 35;
    countLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    countLabel.textAlignment = NSTextAlignmentCenter;
    // 判断信微博数量来决定显示文字
    if (count == 0) {
        countLabel.text = @"等一哈在拉";
    } else {
        countLabel.text = [NSString stringWithFormat:@"加载了%d条微博", count];
    }
    
    [self.navigationController.view insertSubview:countLabel belowSubview:self.navigationController.navigationBar];
    countLabel.y = 64 - countLabel.height;
    // 动画
    [UIView animateWithDuration:0.5 animations:^{
        // 0.5s的时间把countView推出来 (把countView.y设为0)
//        countLabel.y += countLabel.height;
        countLabel.transform = CGAffineTransformMakeTranslation(0, countLabel.height);
    } completion:^(BOOL finished) {
        // 动画结束后执行这里 
        // UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            // 0.5s的时间把countView推回去 (把countView.y恢复为负数)
//            countLabel.y -= countLabel.height;
            countLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 把countView从superView中移除
            [countLabel removeFromSuperview];
        }];
    }];
    
    
    
    
    
    
}
/**
 *  懒加载
 */
- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}


- (void)setupUserInfo
{
    /*
     请求地址: https://api.weibo.com/2/users/show.json
     请求参数:
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID。
     */
 
    // 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    ANAccount *account = [ANAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        ANLog(@"success--%@", responseObject);
        
        
        // 设置名字
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        
        ANUser *user = [ANUser objectWithKeyValues:responseObject];
//        NSString *name = responseObject[@"name"];
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        // 存储昵称到沙盒中
        account.name = user.name;
        [ANAccountTool saveAccount:account];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"failure--%@", error);
    }];
    
}

/**
 *   设置导航栏内容
 */
- (void)setupNav
{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(friendSearch) andImageName:@"navigationbar_friendsearch" andImageNameHighlight:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(pop) andImageName:@"navigationbar_pop" andImageNameHighlight:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮*/
    ANTitleButton *titleButton = [[ANTitleButton alloc] init];
    // 设置图片和文字
    NSString *name = [ANAccountTool account].name;
    [titleButton setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    
    // 监听
    [titleButton addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.titleView = titleButton;
    
}

// 标题点击
- (void)titleBtnClick:(UIButton *)titleBtn
{
    // 1.创建下拉菜单
    ANDropdownMenu *menu = [ANDropdownMenu menu];
    menu.delegate = self;
    // 2.设置内容
    ANTitleMenuViewController *titleMenuVc =  [[ANTitleMenuViewController alloc] init];
    titleMenuVc.view.height = 44 * 3;
    titleMenuVc.view.width = 200;
    
    menu.contentController = titleMenuVc;
    
    // 3.显示菜单
    [menu showFrom:titleBtn];
    
    
}

 

-(void)friendSearch
{
    ANLog(@"FriendSearch");
}

- (void)pop
{
    ANLog(@"pop");
}



#pragma mark ANDropdownMenuDelegate 
// 销毁dropdownMenu让箭头向下
- (void)dropDownMenuDidDismiss:(ANDropdownMenu *)dropdownMenu
{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = NO;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

// 显示dropdownMenu让箭头向上
- (void)dropDownMenuDidShow:(ANDropdownMenu *)dropdownMenu
{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ANStatusCell *cell = [ANStatusCell cellWithTableView:tableView];
    
    // 给cell传递模型数据
    cell.statusFrame = self.statusFrames[indexPath.row];
   
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 如果tableView还没有数据就返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat judegOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >=judegOffsetY) { // 最后一个cell完全进入视线
        // 显示footerView
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多微博数据
        [self loadMoreStatus];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANStatusFrame *frame = self.statusFrames[indexPath.row];
    
    return frame.cellHeight;
}
 
 @end
