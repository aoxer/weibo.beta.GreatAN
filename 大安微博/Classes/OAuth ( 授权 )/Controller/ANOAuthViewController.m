//
//  ANOAuthViewController.m
//  大安微博
//
//  Created by a on 15/11/3.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANOAuthViewController.h" 
#import "MBProgressHUD+MJ.h"
#import "ANAccountTool.h"
#import "ANHttpTool.h"

@interface ANOAuthViewController ()<UIWebViewDelegate>

@end

@implementation ANOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    /*
     client_id
     redirect_uri
     */
    // 用webView加载登陆页面
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", ANAppKey, ANRedirectURL];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
 
}

#pragma mark UIWebViewDelegate 代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    ANLog(@"webViewDidStartLoad");
    [MBProgressHUD showMessage:@"正在加载"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    ANLog(@"webViewDidFinishLoad");
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    ANLog(@"shouldStartLoadWithRequest");
    // 1.获得url
    NSString *url = request.URL.absoluteString;

    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是毁掉地址
        // 截取code= 后面的的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        // 利用code换取accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    

        return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = ANAppKey;
    parameters[@"client_secret"] = ANAppSecret;
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"redirect_uri"] = ANRedirectURL;
    parameters[@"code"] = code;
     
    [ANHttpTool post:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(id json) {
        ANLog(@"%@", json);
        // 将返回的账号数据存进沙盒
        ANAccount *account = [ANAccount accountWithDict:json];
        [ANAccountTool saveAccount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(NSError *error) {
        ANLog(@"error--%@", error);
        
        [MBProgressHUD hideHUD];
    }];
    
    
}

@end
