//
//  ViewController.m
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "LY_LocalServerManager.h"
#import "H5ApiModel.h"

@interface ViewController ()<WKNavigationDelegate, WKUIDelegate>{
    WKWebView *_wkWebView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 初始化 */
    [LYouLoadView show];
    [[LYouRequestManager shared]initH5Api:^(NSURLSessionDataTask * _Nonnull task, H5ApiModel *model) {
        NSLog(@"url=========%@",model.url);

        /** 创建webView */
        [self setupWebView];
        //开启本地服务器
        [[LY_LocalServerManager sharedInstance] start];
        //加载本地资源
        [self loadLocalRequest];
        [LYouLoadView hide];
    } withError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"error=========%@",error);
        [LYouLoadView hide];
        [XHToast showTopWithText:@"初始化失败"];
    }];
}

- (void)setupWebView {
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *controller = [[WKUserContentController alloc] init];
        configuration.userContentController = controller;
        configuration.processPool = [[WKProcessPool alloc] init];
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                        configuration:configuration];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        
        [self.view addSubview:_wkWebView];
    }
}

#pragma mark - 加载网络地址
- (void)loadRemoteRequest {
    if (_wkWebView) {
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"加载本地资源"]]];
    }
}

#pragma mark - 加载本地资源
- (void)loadLocalRequest {
    if (_wkWebView) {
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://localhost:%ld/index.html", [[LY_LocalServerManager sharedInstance] port] ] ]]];
    }
}

#pragma mark - WKNavigationDelegate
-                   (void)webView:(WKWebView *)webView
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
                completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, card);
    }
}

#pragma mark - UIDelegate
-                       (void)webView:(WKWebView *)webView
   runJavaScriptAlertPanelWithMessage:(NSString *)message
                     initiatedByFrame:(WKFrameInfo *)frame
                    completionHandler:(void (^)(void))completionHandler {
    
    NSString *alertTitle = @"温馨提示";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
