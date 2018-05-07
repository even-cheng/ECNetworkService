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

//导入请求模型头文件
#import "TestModel.h"

@implementation ECServer

#pragma mark --------登录注册---------
//--------请求示例---------//
+ (NSURLSessionTask *)getTestDatasWithParameterModel:(TestModel *)parametersModel complete:(ECRequestCompleteBlock)complete;
{
    ECBaseRequest *request = [ECBaseRequest requestWithPath:kTest parameterModel:parametersModel responseClass:[TestResponseModel class]];
    request.requestType= HttpRequestTypePost;
    request.needCache = YES;
    
    return [ECHTTPRequest sendRequest:request complete:complete];
}

//--------上传文件---------//
+ (NSURLSessionTask *)uploadFile:(id)file withType:(ECUploadFileType)type withProgress:(ECHttpProgress)progress complete:(ECRequestCompleteBlock)complete;
{
    ECBaseRequest *request = [ECBaseRequest requestWithPath:kTest parameterModel:[ECBaseParamsModel new] responseClass:[ECBaseResponseModel class]];
    request.requestType= HttpRequestTypePost;
    request.isUploadFile = YES;
    request.upLoadFileType = type;
    request.upLoadFile = file;

    return [ECHTTPRequest sendRequest:request withProgress:progress complete:complete];
}

@end
