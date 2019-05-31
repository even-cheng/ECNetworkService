//
//  EC_RequestError.m
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//


#import "EC_RequestError.h"

@interface EC_RequestError ()

@property (nonatomic) NSMutableDictionary* errorDic;

@end

@implementation EC_RequestError

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化异常信息
        //注册异常信息(配置文件)
        _errorDic = [[NSMutableDictionary alloc] init];
        [_errorDic setValue:@"请求失败" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorWithRequestError]];
        [_errorDic setValue:@"请登录" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorWithForNotLogin]];
        [_errorDic setValue:@"账号不存在" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorWithNoneUser]];
        [_errorDic setValue:@"账号被禁用" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorWithForbidAccount]];
        [_errorDic setValue:@"资源不存在" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorWithOutResource]];
        [_errorDic setValue:@"请求方式错误" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorWithWrongMethed]];
        [_errorDic setValue:@"服务器连接失败" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorWithServerConnectError]];
        [_errorDic setValue:@"请求超时" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorRequestTimeOut]];
        [_errorDic setValue:@"数据解析异常" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorBuildModel]];
        [_errorDic setValue:@"网络连接异常" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorConnectionError]];
        [_errorDic setValue:@"网络异常,请检查网络设置" forKey:[[NSString alloc] initWithFormat:@"%ld",(long)EC_RequestErrorUnknown]];
    }
    return self;
}

-(NSString*)getMsg{
    if (![_desc isKindOfClass:[NSNull class]] && _desc && [_desc length]) {
        return _desc;
    }
    
    if (![_errorDic.allKeys containsObject:[[NSString alloc] initWithFormat:@"%ld",_errorOption]]) {
        _errorOption = EC_RequestErrorUnknown;
    }
    return [_errorDic objectForKey:[[NSString alloc] initWithFormat:@"%ld",_errorOption]];
}

@end
