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

@class TestModel;

@interface ECServer : NSObject

//--------请求示例---------//
+ (NSURLSessionTask *)getTestDatasWithParameterModel:(TestModel *)parametersModel complete:(ECRequestCompleteBlock)complete;


//--------上传文件---------//
+ (NSURLSessionTask *)uploadFile:(id)file withType:(ECUploadFileType)type withProgress:(ECHttpProgress)progress complete:(ECRequestCompleteBlock)complete;

@end
