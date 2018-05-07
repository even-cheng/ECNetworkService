//
//  ECHTTPRequest.h
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECBaseRequest.h"
#import "EC_RequestComplation.h"
#import "ECNetworkHelper.h"

@interface ECHTTPRequest : NSObject

//普通请求
+ (NSURLSessionTask *)sendRequest:(ECBaseRequest*)request complete:(ECRequestCompleteBlock)complete;

//上传文件
+ (NSURLSessionTask *)sendRequest:(ECBaseRequest*)request withProgress:(ECHttpProgress)progress complete:(ECRequestCompleteBlock)complete;

@end
