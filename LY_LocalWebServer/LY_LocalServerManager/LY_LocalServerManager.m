//
//  LY_LocalServerManager.m
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LY_LocalServerManager.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"

@interface LY_LocalServerManager(){
    HTTPServer *_httpServer; /** 创建服务 */
}

@end

@implementation LY_LocalServerManager

+ (instancetype)sharedInstance {
    static LY_LocalServerManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LY_LocalServerManager alloc] init];
    });
    return _sharedInstance;
}

- (void)start {
    _port = 60000;
    if (!_httpServer) {
        _httpServer = [[HTTPServer alloc] init];
        [_httpServer setConnectionClass:[MyHTTPConnection class]];
        [_httpServer setType:@"_http._tcp."];
        [_httpServer setPort:_port];
        NSString * webLocalPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Resource"];
        [_httpServer setDocumentRoot:webLocalPath];
        NSLog(@"Setting document root: %@", webLocalPath);
    }
    if (_httpServer && ![_httpServer isRunning]) {
        NSError *error;
        if([_httpServer start:&error]) {
            NSLog(@"start server success in port %d %@", [_httpServer listeningPort], [_httpServer publishedName]);
            NSLog(@"启动成功");
        } else {
            NSLog(@"启动失败");
        }
    }
    
}

- (void)stop {
    if (_httpServer && [_httpServer isRunning]) {
        [_httpServer stop];
    }
}


@end
