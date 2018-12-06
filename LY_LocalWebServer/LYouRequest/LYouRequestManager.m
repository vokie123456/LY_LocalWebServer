//
//  LYouRequestManager.m
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LYouRequestManager.h"

@implementation LYouRequestManager

/*! 初始化 */
+ (LYouRequestManager *)shared{
    static LYouRequestManager *_netWorkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _netWorkEngine = [[LYouRequestManager alloc]init];
    });
    return _netWorkEngine;
}

- (void)initH5Api:(LYReturnValueBlock)successBlock withError:(LYErroeBlock)errorBlock{
    
    NSDictionary *parametersDic = @{@"bundleId":@"C3000901",@"appVersion":[DeviceUUID getAppVersion],@"idfa":[DeviceUUID getIDFA],@"uuid":[DeviceUUID getUUID]};
    
    [[LYouRequest sharedInstance]NetRequestPOSTWithRequestURL:@"" WithParameter:parametersDic WithReturnValeuBlock:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nonnull responseDict) {
        NSString *jsonStr = [JoDes decode:responseDict[@"data"] key:DESKEY];
        NSData *data =[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        H5ApiModel *model = [H5ApiModel mj_objectWithKeyValues:dic];
        successBlock(task,model);
    } WithErrorBlock:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        errorBlock(task,error);
    } WithFailureBlock:^{
        
    }];
}



@end
