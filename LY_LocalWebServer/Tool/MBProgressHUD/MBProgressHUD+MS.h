//
//  MBProgressHUD+MS.h
//
//  Created by mashuai on 13-4-18.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MS)
//在view展示成功提示
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
//在view展示失败提示
+ (void)showError:(NSString *)error toView:(UIView *)view;
//在view展示信息提示
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

//在window展示成功提示
+ (void)showSuccess:(NSString *)success;
//在window展示失败提示
+ (void)showError:(NSString *)error;
//在window展示信息提示
+ (MBProgressHUD *)showMessage:(NSString *)message;

//隐藏某个view上的提示
+ (void)hideHUDForView:(UIView *)view;
//隐藏提示
+ (void)hideHUD;

@end
