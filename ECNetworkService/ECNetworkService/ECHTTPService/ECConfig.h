//
//  ECConfig.h
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SEnvironmentType) {
    SEnvironmentDevelopment = 0,
    SEnvironmentTest        = 1,
    SEnvironmentProduct     = 2
};

@interface ECConfig : NSObject

/**环境配置*/
@property (nonatomic, assign) SEnvironmentType environmentType;


+(instancetype)shareConfig;

//获取当前环境的请求地址
- (NSString *)getEnvironmentUrlString;

@end
