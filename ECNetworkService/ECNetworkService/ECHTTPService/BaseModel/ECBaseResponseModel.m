//
//  ECBaseResponseModel.m
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import "ECBaseResponseModel.h"

@implementation ECBaseResponseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{@"code":@"code",
             @"desc":@"desc",
             @"serverTime":@"serverTime",
             @"success":@"success"
             };
}

@end
