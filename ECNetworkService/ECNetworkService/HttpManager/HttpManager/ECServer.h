//
//  ECServer.h
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECHTTPRequest.h"
#import "ECBaseParamsModel.h"
#import "ECNetworkHelper.h"

typedef enum : NSUInteger {
    
//登录注册
    APITypeWithLogin = 1,
    APITypeWithRegisterByUserName,
    APITypeWithRegisterByPhoneNumber,
    APITypeWithForgetPwd,
    APITypeWithGetUserInfo,
    APITypeWithConfig,

} APIType;

//1注册 2找回密码
typedef enum : NSUInteger {
    PhoneCodeSendByRegister = 1,
    PhoneCodeSendByForgetPwd = 2,
} PhoneCodeSendType;

@interface ECServer : NSObject

+ (instancetype)sharedServer;

/**
 普通网络请求入口
 
 @param apiType 请求接口类型
 @param params 参数
 @param analysisModelClass 需要解析的模型.传nil为默认解析为字典或者数组。
 @param complete 回调
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)requestWithAPI:(APIType)apiType
                           andParams:(NSDictionary *)params
                    andAnalysisClass:(Class)analysisModelClass
                        withComplete:(ECRequestCompleteBlock)complete;


/**
 发送验证码入口
 
 @param phoneCodeSendType 请求接口类型
 @param mobile 请求方式
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)sendPhoneCodeWithType:(PhoneCodeSendType)phoneCodeSendType
                           andMobile:(NSString *)mobile
                        withComplete:(ECRequestCompleteBlock)complete;


@end
