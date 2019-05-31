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
            return [ECNetworkHelper uploadImagesWithURL:request.requestPath parameters:nil name:@"file" images:imgs fileNames:@[@"file"] imageScale:1 imageType:@"png" progress:progress success:^(id responseObject) {
                
                complete(nil,responseObject);
                
            } failure:^(NSError *error,NSString* des, NSInteger statusCode) {
                
                EC_RequestError* EC_Error = [EC_RequestErrorUtils create:statusCode withDesc:des];
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
    /*
     设置网络请求参数的格式:默认为二进制格式
     */
    request.requestSerializerType = request.requestSerializerType?:ECRequestSerializerHTTP;
    /*
    设置服务器响应数据格式:默认为JSON格式
     */
    request.responseSerializerType = request.responseSerializerType?:ECResponseSerializerJSON;
    
    [ECNetworkHelper setRequestSerializer:request.requestSerializerType];
    [ECNetworkHelper setResponseSerializer:request.responseSerializerType];
    
    /*
     设置请求头,根据后台要求实现相关设置
     */
    [ECNetworkHelper setHttpHeaderField:request];
    
    // 开启日志打印
#if DEBUG
    [ECNetworkHelper openLog];
#endif
    
    // 获取网络缓存大小
    if (request.needCache) {NSLog(@"网络缓存大小cache = %fKB",[ECNetworkCache getAllHttpCacheSize]/1024.f);}

    void (^successBlock)(id) = ^(id responseObject){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self handleResponseObect:responseObject isCache:NO request:request completed:complete];
        });
    };
    void (^cacheBlock)(id) = ^(id cacheObject){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self handleResponseObect:cacheObject isCache:YES request:request completed:complete];
        });
    };
    void (^failureBlock)(NSError*,NSString*,NSInteger) = ^(NSError *error, NSString* des, NSInteger statusCode){
        //处理请求结果
        EC_RequestError* EC_Error = [EC_RequestErrorUtils create:statusCode withDesc:des];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete?complete(EC_Error,nil):nil;
        });
    };
    
    NSURLSessionTask* task = [ECNetworkHelper request:request
                                        responseCache:cacheBlock
                                              success:successBlock
                                              failure:failureBlock];
    
    return task;
}

#pragma mark -- 请求结果处理
+ (void)handleResponseObect:(id)responseObject isCache:(BOOL)isCache request:(ECBaseRequest *)request completed:(ECRequestCompleteBlock)completed {
    
    //如果没有缓存数据就不返回
    if (!responseObject) {
        if (isCache) {
            return;
        }
        
        if (completed) {
            
            EC_RequestError* EC_Error;
            if (isCache) {
                EC_Error = [EC_RequestErrorUtils create:EC_RequestErrorBuildModel withDesc:nil];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completed(EC_Error, nil);
            });
        }
        return;
    }
 
    //返回的数据格式校验
    BOOL validatedFormate = YES;
    if (request.responseSerializerType == ECResponseSerializerJSON) {
        validatedFormate = [request validateFormat:responseObject];
    }
    
    //格式不正确
    if (!validatedFormate) {
        
        NSString* errorDes = @"格式错误";
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            errorDes = [responseObject objectForKey:@"desc"];
        }
        EC_RequestError* EC_Error = [EC_RequestErrorUtils create:EC_RequestErrorBuildModel withDesc:errorDes];
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(EC_Error,nil);
        });
        return;
    }
    
    //解析结果
    NSError* error;
    ECBaseResponseModel* responseModel = nil;

    //返回数据解析成JsonObject
    switch (request.responseSerializerType) {
        case ECResponseSerializerHTTP:
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
            break;
        case ECResponseSerializerJSON:
        {
            //不用映射模型就直接返回json对象
            if (!request.responseClass) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completed(nil, responseObject);
                });
                return;
            }
        }
            break;
        
        default:
            break;
    }
    
 
    //将返回的json对象转换为模型
    responseModel = [request responseModelWithResponseObject:responseObject error:&error];
    
    if (responseModel && completed) {
        
        if (request.needCache && isCache) {
            responseModel.isCache = isCache;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(nil, responseModel);
        });
    }
    
    if (error) {
        
        EC_RequestError* EC_Error = [EC_RequestErrorUtils create:EC_RequestErrorBuildModel withDesc:[responseObject objectForKey:@"desc"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(EC_Error,nil);
        });
        return;
    }
    
}


@end
