//
//  ECHTTPRequest.m
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import "ECHTTPRequest.h"
#import "ECBaseRequest.h"
#import "EC_RequestErrorUtils.h"

@implementation ECHTTPRequest

//上传文件
+ (NSURLSessionTask *)sendRequest:(ECBaseRequest*)request withProgress:(ECHttpProgress)progress complete:(ECRequestCompleteBlock)complete;
{
    switch (request.upLoadFileType) {
        case ECUploadFileTypeHeaderIcon:
        {
            NSArray* imgs = (NSArray*)request.upLoadFile;
            return [ECNetworkHelper uploadImagesWithURL:request.requestPath parameters:nil name:@"head_portrait" images:imgs fileNames:@[@"head_portrait"] imageScale:1 imageType:@"png" progress:progress success:^(id responseObject) {
                
                complete(nil,responseObject);
                
            } failure:^(NSError *error) {
                
                EC_RequestError* EC_Error = [EC_RequestErrorUtils create:error.code withDesc:nil];
                complete(EC_Error,nil);
                
            }];
        }
        default:
            break;
    }
}

#pragma mark - 请求的公共方法
+ (NSURLSessionTask *)sendRequest:(ECBaseRequest*)request complete:(ECRequestCompleteBlock)complete;
{
    /**
     设置网络请求参数的格式:默认为二进制格式
     ECRequestSerializerJSON(JSON格式),
     ECRequestSerializerHTTP(二进制格式)
     
     设置方式 : [ECNetworkHelper setRequestSerializer:ECRequestSerializerHTTP];
     */
    [ECNetworkHelper setRequestSerializer:ECRequestSerializerJSON];
    
    /**
     设置服务器响应数据格式:默认为JSON格式
     ECResponseSerializerJSON(JSON格式),
     ECResponseSerializerHTTP(二进制格式)
     
     设置方式 : [ECNetworkHelper setResponseSerializer:ECResponseSerializerJSON];
     */
    [ECNetworkHelper setResponseSerializer:ECResponseSerializerJSON];
    
    /**
     设置请求头 : [ECNetworkHelper setValue:@"value" forHTTPHeaderField:@"header"];
     */
//    NSString* token = [UserManager shareUser].token;
//    if (token) {
//        [ECNetworkHelper setValue:[UserManager shareUser].token forHTTPHeaderField:@"token"];
//    }
    
    // 开启日志打印
    [ECNetworkHelper openLog];
    
    // 获取网络缓存大小
    NSLog(@"网络缓存大小cache = %fKB",[ECNetworkCache getAllHttpCacheSize]/1024.f);
    
    // 清理缓存 [ECNetworkCache removeAllHttpCache];
    
    /**带缓存请求(先获取缓存数据,再进行网络请求,会返回两次数据)*/
    if (request.needCache) {
        
        switch (request.requestType) {
            case HttpRequestTypePost:
                // 发起请求
                return [ECNetworkHelper POST:request.requestPath parameters:request.parameter responseCache:^(id responseCache) {
                    
                    [self handleResponseObect:responseCache request:request completed:complete];
                    
                } success:^(id responseObject) {
                    
                    //处理请求结果
                    [self handleResponseObect:responseObject request:request completed:complete];
                    
                } failure:^(NSError *error) {
                    
                    EC_RequestError* EC_Error = [EC_RequestErrorUtils create:error.code withDesc:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        complete(EC_Error,nil);
                    });
                }];
                
            case HttpRequestTypeGet:
                // 发起请求
                return [ECNetworkHelper GET:request.requestPath parameters:request.parameter responseCache:^(id responseCache) {
                    
                    //处理请求结果
                    [self handleResponseObect:responseCache request:request completed:complete];
                    
                } success:^(id responseObject) {
                    
                    //处理请求结果
                    [self handleResponseObect:responseObject request:request completed:complete];
                    
                } failure:^(NSError *error) {
                    
                    EC_RequestError* EC_Error = [EC_RequestErrorUtils create:error.code withDesc:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        complete(EC_Error,nil);
                    });
                }];
                
            case HttpRequestTypePut:
                
            case HttpRequestTypeDelete:
                
            default:
                return nil;
                break;
        }
        
    } else {
        
        switch (request.requestType) {
            case HttpRequestTypePost:
                // 发起请求
                return [ECNetworkHelper POST:request.requestPath parameters:request.parameter success:^(id responseObject) {
                    
                    //处理请求结果
                    [self handleResponseObect:responseObject request:request completed:complete];
                    
                } failure:^(NSError *error) {
                    
                    EC_RequestError* EC_Error = [EC_RequestErrorUtils create:error.code withDesc:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        complete(EC_Error,nil);
                    });
                }];
                
            case HttpRequestTypeGet:
                // 发起请求
                return [ECNetworkHelper GET:request.requestPath parameters:request.parameter success:^(id responseObject) {
                    
                    //处理请求结果
                    [self handleResponseObect:responseObject request:request completed:complete];
                    
                } failure:^(NSError *error) {
                    
                    EC_RequestError* EC_Error = [EC_RequestErrorUtils create:error.code withDesc:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        complete(EC_Error,nil);
                    });
                }];
                
            case HttpRequestTypePut:

            case HttpRequestTypeDelete:
               
                
            default:
                return nil;
                break;
        }
        
    }

}

#pragma mark -- 请求结果处理
+ (void)handleResponseObect:(id)responseObject request:(ECBaseRequest *)request completed:(ECRequestCompleteBlock)completed {
    
    //如果没有缓存数据就不返回
    if (!responseObject) {
        return;
    }
    
    //返回结果判断
    if ([responseObject[@"success"] integerValue] != 1) {//失败
        
        EC_RequestError* EC_Error = [EC_RequestErrorUtils create:EC_RequestErrorWithInvalidToken withDesc:[responseObject objectForKey:@"desc"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(EC_Error,nil);
        });
        return;
    }
    
    //返回的数据格式校验
    BOOL validatedFormate = [request validateFormat:responseObject];
    if (!validatedFormate) {
        
        EC_RequestError* EC_Error = [EC_RequestErrorUtils create:EC_RequestErrorResponseFormat withDesc:[responseObject objectForKey:@"desc"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(EC_Error,nil);
        });
        return;
    }
    
    id responseModel = nil;
 
    NSError* error;
    //将返回的结果转换为responsModel
    responseModel = [request responseModelWithResponseObject:responseObject error:&error];
    if (error) {
        
        EC_RequestError* EC_Error = [EC_RequestErrorUtils create:EC_RequestErrorBuildModel withDesc:[responseObject objectForKey:@"desc"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(EC_Error,nil);
        });
        return;
    }
    
   
    if (completed) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(nil, responseModel);
        });
    }
}

@end
