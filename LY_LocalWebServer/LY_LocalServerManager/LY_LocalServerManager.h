//
//  LY_LocalServerManager.h
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LY_LocalServerManager : NSObject

@property (nonatomic, assign, readonly) NSUInteger port;

+ (instancetype)sharedInstance;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
