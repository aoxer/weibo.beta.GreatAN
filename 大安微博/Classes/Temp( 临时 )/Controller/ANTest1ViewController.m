//
//  ANTest1ViewController.m
//  大安微博
//
//  Created by a on 15/10/26.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTest1ViewController.h"
#import "ANTest2ViewController.h"

@interface ANTest1ViewController ()

@end

@implementation ANTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ANTest2ViewController *test2 = [[ANTest2ViewController alloc] init];
    
    [self.navigationController pushViewController:test2 animated:YES];
    self.navigationItem.backBarButtonItem = nil;
}

@end
