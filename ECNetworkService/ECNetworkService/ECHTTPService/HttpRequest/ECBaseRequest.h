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

//请求参数(Model)
@property (nonatomic, strong) id parameter;

//解析的ResponseModelClass
@property (nonatomic, copy) Class responseClass;

//请求方式
@property (nonatomic, assign) HttpRequestType requestType;

//是否需要缓存
@property (nonatomic, assign) BOOL needCache;


//生成一个请求对象
+ (ECBaseRequest *)requestWithPath:(NSString *)path
                     parameterModel:(ECBaseParamsModel*)parameterModel
                     responseClass:(Class)responseClass;

//服务器返回数据格式校验
- (BOOL)validateFormat:(id)responseObject;

//返回结果转模型
- (id)responseModelWithResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error;

@end
