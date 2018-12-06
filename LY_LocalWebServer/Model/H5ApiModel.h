//
//  H5ApiModel.h
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface H5ApiModel : NSObject

@property (strong, nonatomic) NSString *result;      //目前没用
@property (strong, nonatomic) NSString *aspectRatio; //url页面是横屏还是竖屏  0横屏，1竖屏游戏一律设置为竖屏，如果aspectRatio字段是0，那就旋转一下屏幕，同样，如果是打开内置游戏，内置游戏是横屏，也要旋转一下屏幕
@property (strong, nonatomic) NSString *isOpen;  //是否打开url，如果是0表示运行你写的那个游戏，1表示打开url参数指定的地址
@property (strong, nonatomic) NSString *url;     //app要打开的地址
@property (strong, nonatomic) NSString *zfqd;    //支持的支付渠道，目前有支付宝微信和内购，alipay://,weixin://,inpay://，一般只有alipay://,weixin://

@end

NS_ASSUME_NONNULL_END
