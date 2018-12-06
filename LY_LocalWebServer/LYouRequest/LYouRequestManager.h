//
//  LYouRequestManager.h
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "H5ApiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYouRequestManager : NSObject

typedef void (^LYReturnValueBlock)(NSURLSessionDataTask *task, H5ApiModel *model);
typedef void (^LYErroeBlock)(NSURLSessionDataTask *task, NSError* error);
typedef void (^LYFailureBlock)(void);

+ (LYouRequestManager *)shared;
/*! 初始化 */
- (void)initH5Api:(LYReturnValueBlock)successBlock withError:(LYErroeBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
