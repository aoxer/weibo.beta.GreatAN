//
//  ANTest2ViewController.m
//  大安微博
//
//  Created by a on 15/10/26.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTest2ViewController.h"
#import "ANTest3ViewController.h"
@interface ANTest2ViewController ()

@end

@implementation ANTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ANTest3ViewController *test3 = [[ANTest3ViewController alloc] init];
    test3.title = @"Test3";
    [self.navigationController pushViewController:test3 animated:YES];
}


@end
