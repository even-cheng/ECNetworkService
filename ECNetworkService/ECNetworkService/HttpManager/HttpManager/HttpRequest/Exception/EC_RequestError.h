//
//  EC_RequestError.h
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//


#import <Foundation/Foundation.h>

//错误类型
typedef NS_ENUM(NSInteger,EC_RequestErrorOption){

    //请求错误
    EC_RequestErrorWithRequestError = 400,
    //账号未登录
    EC_RequestErrorWithForNotLogin = 401,
    //账号被封禁
    EC_RequestErrorWithForbidAccount = 403,
    //资源不存在
    EC_RequestErrorWithOutResource = 404,
    //请求方式错误
    EC_RequestErrorWithWrongMethed = 405,
    //未注册
    EC_RequestErrorWithNoneUser = 421,
    //服务器连接失败 500
    EC_RequestErrorWithServerConnectError = 500,
    
    //请求超时
    EC_RequestErrorRequestTimeOut = -1,
    //数据转模型失败(数据格式错误)
    EC_RequestErrorBuildModel = -2,
    //网络连接异常
    EC_RequestErrorConnectionError = -3,
    
    //未知异常
    EC_RequestErrorUnknown
};

//异常类
@interface EC_RequestError : NSObject

@property (nonatomic,assign) EC_RequestErrorOption errorOption;
@property (nonatomic,copy) NSString* desc;


//异常信息
-(NSString*)getMsg;

@end
