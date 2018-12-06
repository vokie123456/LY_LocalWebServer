//
//  DeviceUUID.h
//  JionMe
//
//  Created by grx on 2017/2/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceUUID : NSObject

+(NSString *)getUUID;
+(NSString *)getIDFA;
+(NSString *)getAppVersion;

@end
