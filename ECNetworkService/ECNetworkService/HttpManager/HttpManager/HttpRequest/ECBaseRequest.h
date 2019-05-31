//
//  ECBaseRequest.h
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECBaseParamsModel.h"
#import "ECBaseResponseModel.h"
#import "ECNetworkHelper.h"

//请求类型
typedef enum : NSUInteger {
    HttpRequestTypeGet = 0,
    HttpRequestTypePost,
    HttpRequestTypePut,
    HttpRequestTypeDelete
} HttpRequestType;

//上传文件类型
typedef enum : NSUInteger {
    ECUploadFileTypeHeaderIcon,
} ECUploadFileType;

@interface ECBaseRequest : NSObject

//是否上传文件
@property (nonatomic, assign) BOOL isUploadFile;
//上传文件类型
@property (nonatomic, assign) ECUploadFileType upLoadFileType;
//上传文件
@property (nonatomic, strong) id upLoadFile;

//请求地址
@property (nonatomic, copy) NSString *requestPath;

//请求参数(dict)
@property (nonatomic, strong) id parameter;

//请求数据类型
@property (nonatomic, assign) ECRequestSerializer requestSerializerType;
//解析数据类型
@property (nonatomic, assign) ECResponseSerializer responseSerializerType;

//解析的ResponseModelClass
@property (nonatomic, copy) Class responseClass;

//请求类型(增删改查)
@property (nonatomic, assign) HttpRequestType requestType;

//是否需要缓存(如果有缓存会返回两次,一次缓存,一次网络数据)
@property (nonatomic, assign) BOOL needCache;

//是否只获取缓存(如果有则返回缓存,没有则请求数据),默认NO
@property (nonatomic, assign) BOOL requestCacheOnly;

//生成一个请求对象
+ (ECBaseRequest *)requestWithPath:(NSString *)path
                     parameterModel:(NSObject*)parameterModel
                     responseClass:(Class)responseClass;

//服务器返回数据格式校验
- (BOOL)validateFormat:(id)responseObject;

//返回结果转模型
- (id)responseModelWithResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error;

- (NSString *)methodTypeString;

@end
