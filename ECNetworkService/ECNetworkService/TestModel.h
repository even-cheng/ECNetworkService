//
//  TestModel.h
//  EC
//
//  Created by Even on 2018/3/6.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import "ECBaseParamsModel.h"
#import "ECBaseResponseModel.h"

@interface TestModel : ECBaseParamsModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *pageNumber;

@end

@interface TestResponseItemModel : ECModel

@property (nonatomic, copy) NSString *goodsTitle;
@property (nonatomic, copy) NSString *goodsDesc;

@end

@interface TestResponseModel : ECBaseResponseModel

//总数
@property (nonatomic, copy) NSNumber *totalCount;

@property (nonatomic, strong) NSArray *data;

@end

