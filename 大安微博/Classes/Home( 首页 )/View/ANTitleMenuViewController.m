//
//  ANTitleMenuViewController.m
//  大安微博
//
//  Created by a on 15/10/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTitleMenuViewController.h"

@interface ANTitleMenuViewController ()

@end

@implementation ANTitleMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"首页";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"好友圈";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"全部";
    }
    
    
    return cell;


}

@end
