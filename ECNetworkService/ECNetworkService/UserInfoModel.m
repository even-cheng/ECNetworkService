
//
//  UserInfoModel.m
//  ECNetworkService
//
//  Created by 快游 on 2019/5/31.
//  Copyright © 2019 EvenCheng. All rights reserved.
//

#import "UserInfoModel.h"
#import <YYModel.h>

@implementation UserInfoModel


//详细使用方式请自行学习YYModel解析

/**
 指定某些字段解析成自定义格式，格式： 自定义字段：原始字段
 */
+ (NSDictionary *)modelCustomPropertyMapper;{
    return @{
             @"ID":@"id"
             };
}

//在此做一些自定义操作，这一步之后数据就会完成解析。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    return YES;
}

//嵌套模型解析
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"user": [UserInfoModel class]
             };
}


@end
