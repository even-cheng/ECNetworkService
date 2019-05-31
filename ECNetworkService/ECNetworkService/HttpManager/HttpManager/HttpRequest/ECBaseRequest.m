//
//  ECBaseRequest.m
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import "ECBaseRequest.h"
#import "ECInterfacedConst.h"
#import "YYModel.h"

@implementation ECBaseRequest

+ (ECBaseRequest *)requestWithPath:(NSString *)path parameterModel:(NSObject*)parameterModel responseClass:(Class)responseClass {
    ECBaseRequest *request = [[ECBaseRequest alloc] init];
    if ([path hasPrefix:@"http"] || [path hasPrefix:@"https"]) {
        request.requestPath = path;
    } else {
        request.requestPath = [NSString stringWithFormat:@"%@/%@",tm_EnvironmentDevelopment,path];
    }
    if (parameterModel) {
        request.parameter = [parameterModel yy_modelToJSONObject];
    }
    request.responseClass = responseClass;
    return request;
}


+ (NSDictionary*)filterParams:(NSObject*)parameterModel{
 
    NSMutableDictionary* dict = [parameterModel yy_modelToJSONObject];
    for (NSString* key in dict.allKeys) {
        if ([dict objectForKey:key] == nil) {
            [dict removeObjectForKey:key];
        }
    }
    
    return dict.mutableCopy;
}


//服务器返回结果格式验证
- (BOOL)validateFormat:(id)responseObject {

    return [responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]];
}

- (id)responseModelWithResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error {

    if ([responseObject isKindOfClass:[NSArray class]]) {
        NSArray *datalist = [NSArray yy_modelArrayWithClass:_responseClass json:responseObject];
        ECBaseResponseModel *baseModel = [[ECBaseResponseModel alloc] init];
        baseModel.data = datalist;
        return baseModel;
    }

    id responseModel = [_responseClass yy_modelWithDictionary:responseObject];
    if (responseModel == nil) {
        NSLog(@"---数据解析错误---%@",*error);
    }
    
    ECBaseResponseModel *baseModel = [[ECBaseResponseModel alloc] init];
    baseModel.data = responseModel;
    return baseModel;
}

- (NSString *)methodTypeString {
    switch (self.requestType) {
        case HttpRequestTypeGet:
            return @"GET";
            break;
        case HttpRequestTypePost:
            return @"POST";
            break;
        case HttpRequestTypePut:
            return @"PUT";
            break;
        case HttpRequestTypeDelete:
            return @"DELETE";
            break;
        default:
            return @"GET";
            break;
    }
}



@end
