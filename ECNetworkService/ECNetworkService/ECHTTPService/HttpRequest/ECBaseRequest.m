//
//  ECBaseRequest.m
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import "ECBaseRequest.h"
#import "ECInterfacedConst.h"

@implementation ECBaseRequest

+ (ECBaseRequest *)requestWithPath:(NSString *)path parameterModel:(ECBaseParamsModel*)parameterModel responseClass:(Class)responseClass {
    
    ECBaseRequest *request = [[ECBaseRequest alloc] init];
//    request.requestPath = [[ECConfig shareConfig].getEnvironmentUrlString stringByAppendingString:path];
    request.parameter = [parameterModel dictionaryValue];
    request.responseClass = responseClass;
    return request;
}

//服务器返回结果格式验证
- (BOOL)validateFormat:(id)responseObject {
    
    if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]]) {
        
        return YES;
    }
    return NO;
}

- (id)responseModelWithResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error {
    
    if ([responseObject isKindOfClass:[NSArray class]]) {
        
        return [MTLJSONAdapter modelsOfClass:_responseClass fromJSONArray:responseObject error:error];
    }
    
    id responseModel = [MTLJSONAdapter modelOfClass:_responseClass fromJSONDictionary:responseObject error:error];
    
    if (*error) {
        NSLog(@"---数据解析错误---%@",*error);
    }
    
    return responseModel;
}

@end
