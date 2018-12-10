//
//  AppDelegate.m
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import "LY_LocalServerManager.h"
#import "H5ApiModel.h"
#import "LYLocalWebController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /** 初始化 */
    [LYouLoadView show];
    [[LYouRequestManager shared]initH5Api:^(NSURLSessionDataTask * _Nonnull task, H5ApiModel *model) {
//        model.isOpen = @"0";
        LYLocalWebController *rootVC = [LYLocalWebController new];
        rootVC.h5Model = model;
        self.window.rootViewController = rootVC;
        [self.window makeKeyAndVisible];
        [LYouLoadView hide];
    } withError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"error=========%@",error);
        [LYouLoadView hide];
        [XHToast showTopWithText:@"初始化失败"];
    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
