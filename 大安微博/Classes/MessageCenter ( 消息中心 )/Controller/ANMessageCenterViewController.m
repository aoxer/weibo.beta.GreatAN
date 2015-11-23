//
//  ANMessageCenterViewController.m
//  大安微博
//
//  Created by a on 15/10/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANMessageCenterViewController.h"
#import "ANTest1ViewController.h"
#import "ANSearchBar.h"
@interface ANMessageCenterViewController ()

@end

@implementation ANMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:self action:@selector(composeMsg)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
//    ANLog(@"ANMessageCenterViewController---viewDidLoad ");
    
    ANSearchBar *searchBar = [ANSearchBar searchBar];
    searchBar.height = 30;
    searchBar.width = 300;
    [self.view addSubview:searchBar];
}



- (void)composeMsg
{
    ANLog(@"composeMsg");
}

#pragma mark - Table view data source

 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Message---%ld", indexPath.row];
    return cell;
}

#pragma mark 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANTest1ViewController *test1 = [[ANTest1ViewController alloc] init];
    test1.title = @"Test1";
    // 当test1控制器被push的时候, test1所在的tabbarController的tabbar会自动隐藏
    // 当test1控制器被pop的时候, test1所在的tabbarController的tabbar会自动显示
    test1.hidesBottomBarWhenPushed = YES;
    
    NSLog(@"%@", self.navigationController);
    [self.navigationController pushViewController:test1 animated:YES];
}


@end
