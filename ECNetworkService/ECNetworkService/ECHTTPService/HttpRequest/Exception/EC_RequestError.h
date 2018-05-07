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
    
    //服务器异常
    EC_RequestErrorWithServerConnect = -1004,
    //TOKEN为空
    EC_RequestErrorWithInvalidToken = -1016,
    //网络连接异常
    EC_RequestErrorConnectionError = -1009,
    //请求超时
    EC_RequestErrorRequestTimeOut = -1001,
    //请求地址不存在
    EC_RequestErrorBadRequest = -1011,
    //服务器返回数据类型异常
    EC_RequestErrorResponseFormat,
    //数据转模型失败(数据格式错误)
    EC_RequestErrorBuildModel,
    //请求失败
    EC_RequestErrorUnknown
};

//异常类
@interface EC_RequestError : NSObject

@property (nonatomic,assign) EC_RequestErrorOption errorOption;
@property (nonatomic,copy) NSString* desc;


//异常信息
-(NSString*)getMsg;

@end
