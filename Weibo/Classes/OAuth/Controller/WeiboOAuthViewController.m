//
//  WeiboOAuthViewController.m
//  Weibo
//
//  Created by Yang Chao on 5/30/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboOAuthViewController.h"
#import "AFNetworking.h"
#import "CYMainTabViewController.h"
#import "NewFeatureViewController.h"
#import "WeiboAccount.h"
#import "WeiboAccountTool.h"

@interface WeiboOAuthViewController () <UIWebViewDelegate>

@end

@implementation WeiboOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    
    //2. 用webView加载登录界面
    //请求地址 ： https://api.weibo.com/oauth2/authorize?client_id=2489662495&redirect_uri=http://
    //请求参数 ：client_id  指的是app key
    //          redirect_uri  回调地址，有默认值http://
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2489662495&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CYLog(@"finishLoad");
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    CYLog(@"startLoad");

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.获得URL
    NSString *url = request.URL.absoluteString;
    
    //2. 判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { //是回调地址
        //截取code=后面的参数值，截取substring
        unsigned long fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}
/**
 *  利用code （授权过的request token，换取access token）
 *
 *  @param code <#code description#>
 */
- (void)accessTokenWithCode:(NSString *)code
{
    /**
     *  URL: https://api.weibo.com/oauth2/access_token
     
     必选	类型及范围	说明
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2489662495";
    params[@"client_secret"] = @"bc9b3a070d318f9dca70ce957a5f3325";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://";

    //3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        CYLog(@"请求成功-%@",responseObject);
        
        WeiboAccount *account = [WeiboAccount accountWithDict:responseObject];
        
        //存储帐号信息
        [WeiboAccountTool storeAccount:account];
        
        
        //切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CYLog(@"请求失败-%@",error);
    }];
    
    
    
}


@end
