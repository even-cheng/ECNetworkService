//
//  EC_RequestComplation.h
//  EC
//
//  Created by Even on 2018/3/1.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#ifndef EC_RequestComplation_h
#define EC_RequestComplation_h

#import "EC_RequestError.h"

/**
 请求结果
 
 @param error     是否成功
 @param response  结果参数
 */
typedef void(^ECRequestCompleteBlock)(EC_RequestError* error,ECBaseResponseModel* response);


#endif /* Even_PayComplation_h */
