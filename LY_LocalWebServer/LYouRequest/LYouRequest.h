//
//  LYouRequest.h
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYouRequest : AFHTTPSessionManager

/*! 定义返回请求数据的block类型 */
typedef void (^SLReturnValueBlock)(NSURLSessionDataTask *task, NSDictionary *responseDict);
typedef void (^SLErroeBlock)(NSURLSessionDataTask *task, NSError* error);
typedef void (^SLFailureBlock)(void);
typedef void (^SLNetWorkStatusBlock)(AFNetworkReachabilityStatus status);

/*! 初始化 */
+ (LYouRequest *)sharedInstance;

/*! 监测网络的可链接性 */
- (void)netWorkReachabilityWithReturnNetWorkStatusBlock:(SLNetWorkStatusBlock)block;

/*! GET请求 */
- (void)NetRequestGETWithRequestURL: (NSString *) requestURLString
                      WithParameter: (NSDictionary *) parameter
               WithReturnValeuBlock: (SLReturnValueBlock) block
                     WithErrorBlock: (SLErroeBlock) errorBlock
                   WithFailureBlock: (SLFailureBlock) failureBlock;

/*! POST请求 */
- (void)NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (SLReturnValueBlock) block
                      WithErrorBlock: (SLErroeBlock) errorBlock
                    WithFailureBlock: (SLFailureBlock) failureBlock;

/*! POST上传单张图片 */
- (void) NetRequestPOSTIMGWithRequestURL: (NSString *) requestURLString
                           WithParameter: (NSDictionary *) parameter
                           WithUpLoadImg: (UIImage *) image
                    WithReturnValeuBlock: (SLReturnValueBlock) block
                          WithErrorBlock: (SLErroeBlock) errorBlock
                        WithFailureBlock: (SLFailureBlock) failureBlock;

/*! POST上传多张图片 */
- (void)  NetRequestPOSTMoreImgWithRequestURL: (NSString *) requestURLString
                                WithParameter: (NSDictionary *) parameter
                                WithUpLoadImg: (NSMutableArray *) imageArray
                         WithReturnValeuBlock: (SLReturnValueBlock) block
                               WithErrorBlock: (SLErroeBlock) errorBlock
                             WithFailureBlock: (SLFailureBlock) failureBlock;

@end

NS_ASSUME_NONNULL_END
