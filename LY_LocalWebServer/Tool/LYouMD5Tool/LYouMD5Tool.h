//
//  LYouMD5Tool.h
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYouMD5Tool : NSObject

+(NSString *)MD5ForLower32Bate:(NSString *)str;
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
+(NSString *)MD5ForLower16Bate:(NSString *)str;
+(NSString *)MD5ForUpper16Bate:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
