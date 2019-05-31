//
//  ECBaseResponseModel.h
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
// 数据请求返回结果基类

#import "ECModel.h"

@interface ECBaseResponseModel : ECModel


@property (nonatomic, strong) id data;

@property (nonatomic, assign) BOOL isCache;

@end
