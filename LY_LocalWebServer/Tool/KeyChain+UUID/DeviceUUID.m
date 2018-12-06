//
//  DeviceUUID.m
//  JionMe
//
//  Created by grx on 2017/2/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "DeviceUUID.h"
#import "KeyChainStore.h" 
#import <AdSupport/AdSupport.h>

@implementation DeviceUUID

+(NSString *)getUUID
{
    //获取项目的bundle ID
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    //根据bundle ID拼接一个自定义的key用来作为keychain里面的唯一标示
    //NSString *keyUUid = [NSString stringWithFormat:@"%@.uuid",bundleId];
    //将bundle ID作为唯一key在keychain里面获取保存的uuid
    NSString * strUUID = (NSString *)[KeyChainStore load:bundleId];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
         CFRelease(uuidRef);
        //将该uuid保存到keychain
        [KeyChainStore save:bundleId data:strUUID];
        
    }
    return strUUID;
}

+(NSString *)getIDFA{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+(NSString *)getAppVersion{
    //获取app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

@end
