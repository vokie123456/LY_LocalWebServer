//
//  LYLocalWebController.m
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/7.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYLocalWebController.h"
#import <WebKit/WebKit.h>
#import "LY_LocalServerManager.h"

@interface LYLocalWebController ()<WKNavigationDelegate, WKUIDelegate>{
    WKWebView *_wkWebView;
}

@end

@implementation LYLocalWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /** 创建webView */
    [self setupWebView];
    /** 开启本地服务器 */
    [[LY_LocalServerManager sharedInstance] start];
    if ([self.h5Model.isOpen isEqualToString:@"0"]) {
        /** 加载本地资源 */
        [self loadLocalRequest];
    }else{
        /** 加载网络地址 */
        [self loadRemoteRequest];
    }
}

/** 支持旋转 */
-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    if ([self.h5Model.aspectRatio isEqualToString:@"0"]) {
        /** 横屏 */
        return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
    }else{
        /** 竖屏 */
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)setupWebView {
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *controller = [[WKUserContentController alloc] init];
        configuration.userContentController = controller;
        configuration.preferences = [[WKPreferences alloc] init];
        
        configuration.preferences.minimumFontSize =10;
        configuration.preferences.javaScriptEnabled =YES;
        configuration.preferences.javaScriptCanOpenWindowsAutomatically =NO;
        
        configuration.processPool = [[WKProcessPool alloc] init];
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                        configuration:configuration];
        if ([self.h5Model.aspectRatio isEqualToString:@"0"]) {
            _wkWebView.frame = CGRectMake(0, 0, Main_Screen_Height, Main_Screen_Width);
        }else{
            _wkWebView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
        }
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        [self.view addSubview:_wkWebView];
    }
}

#pragma mark - 禁止长按/选择
-(void)noneSelectScript:(WKWebView *)webView{
    NSMutableString *javascript = [NSMutableString string];
    //禁止长按
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];
    //禁止选择
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [webView.configuration.userContentController addUserScript:noneSelectScript];
}

#pragma mark- 禁止放大缩小
-(void)noneScaleScript:(WKWebView *)webView{
    // 禁止放大缩小
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=0.0,maximum-scale=0.0, minimum-scale=0.0, user-scalable=yes\";"
    "script.content=\"width=device-width"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
}

#pragma mark - 加载网络地址
- (void)loadRemoteRequest {
    if (_wkWebView) {
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.h5Model.url]]];
    }
}

#pragma mark - 加载本地资源
- (void)loadLocalRequest {
    if (_wkWebView) {
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://localhost:%ld/index.html", [[LY_LocalServerManager sharedInstance] port] ] ]]];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    webView.scrollView.bounces=NO;
    [self noneSelectScript:_wkWebView];
    [self noneScaleScript:webView];
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

//页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 获取完整url并进行UTF-8转码
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    if ([strRequest hasPrefix:@"weixin://"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        /** 微信支付 */
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:strRequest] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    NSLog(@"链接===========:%@",strRequest);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, card);
    }
}

#pragma mark - UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message
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
