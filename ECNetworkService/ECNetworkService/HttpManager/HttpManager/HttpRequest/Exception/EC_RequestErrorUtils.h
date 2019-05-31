//
//  EC_RequestErrorUtils.h
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECHTTPRequest.h"
#import "EC_RequestError.h"

//异常赋值和创建必需由内部实现，不能客户端创建，因为异常是从框架内步抛出
@interface EC_RequestErrorUtils : NSObject

+(EC_RequestError*)create:(EC_RequestErrorOption)code withDesc:(NSString*)desc;

@end
