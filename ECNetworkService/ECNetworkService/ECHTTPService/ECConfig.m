//
//  ECConfig.m
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import "ECConfig.h"
#import "ECInterfacedConst.h"

#define XUserDefaults [NSUserDefaults standardUserDefaults]

@implementation ECConfig

+(instancetype)shareConfig{
    
    static ECConfig* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]init];
    });
    
    return instance;
}

- (NSString *)getEnvironmentUrlString;{
    switch (self.environmentType) {
        case SEnvironmentDevelopment:
            return kEnviromentDevelopment;

            break;
        case SEnvironmentTest:
            return kEnviromentTest;

            break;
        case SEnvironmentProduct:
            return kEnviromentProduct;

            break;
            
        default:
            return kEnviromentDevelopment;

            break;
    }
}


@end
