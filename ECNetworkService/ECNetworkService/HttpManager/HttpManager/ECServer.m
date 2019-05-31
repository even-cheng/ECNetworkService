//
//  ECServer.m
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import "ECServer.h"
#import "ECBaseRequest.h"
#import "ECInterfacedConst.h"

typedef void(^CompleteBlock)(BOOL success, NSString* errorMsg);
@interface ECServer ()
@property (copy, nonatomic) CompleteBlock complete;
@end

@implementation ECServer

+ (instancetype)sharedServer{
    
    static ECServer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ECServer alloc] init];
    });
    return instance;
}

/**
 网络请求入口
 
 @param apiType 请求接口类型
 @param params 参数
 @param analysisModelClass 需要解析的模型
 @param complete 回调
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)requestWithAPI:(APIType)apiType
                           andParams:(NSDictionary *)params
                    andAnalysisClass:(Class)analysisModelClass
                        withComplete:(ECRequestCompleteBlock)complete;{
 
    NSString* path = @"";
    HttpRequestType requestType = HttpRequestTypeGet;
    
    //是否缓存请求结果，如果为YES,则会回调两次，一次缓存一次网络数据，可以根据回调对象判断类型
    BOOL needCache = NO;

    switch (apiType) {

#pragma mark 登录注册
        case APITypeWithLogin:
            path = @"auth/login";
            requestType = HttpRequestTypePost;
            break;
            
        case APITypeWithRegisterByUserName:
            path = @"auth/register";
            requestType = HttpRequestTypePost;
            break;
            
        case APITypeWithRegisterByPhoneNumber:
            path = @"auth/mobile_register";
            requestType = HttpRequestTypePost;
            break;
            
        case APITypeWithGetUserInfo:
            path = @"user/info";
            requestType = HttpRequestTypeGet;
            break;
            
        case APITypeWithForgetPwd:
            path = @"auth/forgetpwd";
            requestType = HttpRequestTypePost;
            break;
            
        case APITypeWithConfig:
            path = @"auth/config";
            requestType = HttpRequestTypeGet;
            needCache = YES;
            break;
            
        
    }

    return [self requestWithPath:path
               andResqusetMethod:requestType
                       andParams:params
           andResponseModelClass:analysisModelClass
                       needCache:needCache
                    withComplete:complete];
}


/**
 发送验证码入口
 
 @param phoneCodeSendType 请求接口类型
 @param mobile 请求方式
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)sendPhoneCodeWithType:(PhoneCodeSendType)phoneCodeSendType
                                  andMobile:(NSString *)mobile
                               withComplete:(ECRequestCompleteBlock)complete;{
    
    NSString* path = @"auth/send_sms";
    NSDictionary* params = @{@"type":@(phoneCodeSendType), @"mobile":mobile};
    
    return [self requestWithPath:path
               andResqusetMethod:HttpRequestTypePost
                       andParams:params
           andResponseModelClass:nil
                       needCache:NO
                    withComplete:complete];
}


/**
 网络请求主入口

 @param path 请求短链
 @param requestType 请求方式
 @param params 参数
 @param modelClass 解析模型类
 @param needCache 是否缓存结果
 @param complete 回调
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)requestWithPath:(NSString *)path
                    andResqusetMethod:(HttpRequestType)requestType
                            andParams:(NSDictionary *)params
                andResponseModelClass:(Class)modelClass
                            needCache:(BOOL)needCache
                         withComplete:(ECRequestCompleteBlock)complete;{
    
    ECBaseRequest *request = [ECBaseRequest requestWithPath:path parameterModel:params responseClass:modelClass];
    request.requestType= requestType;
    request.needCache = needCache;

    return [ECHTTPRequest sendRequest:request complete:complete];
}



@end
