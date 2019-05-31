//
//  EC_RequestErrorUtils.m
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//


#import "EC_RequestErrorUtils.h"
#import "EC_RequestComplation.h"

@implementation EC_RequestErrorUtils

+(EC_RequestError*)create:(EC_RequestErrorOption)code withDesc:(NSString*)desc{
    EC_RequestError* error = [[EC_RequestError alloc] init];
    error.errorOption = code;
    if ((int)code > 499 && (int)code < 600) {
        error.errorOption = EC_RequestErrorWithServerConnectError;
    }
    if (desc) {
        error.desc = desc;
    }
    
    if (code == EC_RequestErrorWithForbidAccount || code == EC_RequestErrorWithForNotLogin || code == EC_RequestErrorWithNoneUser) {
        NSLog(@"*********  账号状态异常  ********");
    }
    
    return error;
}


@end
