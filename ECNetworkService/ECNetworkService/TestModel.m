//
//  CardShopListModel.m
//  EC
//
//  Created by Even on 2018/3/6.
//  Copyright © 2018年 Even-Cheng. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{@"title":@"title",
             @"pageNumber":@"pageNumber"
             };
}

@end

@implementation TestResponseItemModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{@"productId":@"productId",
             @"goodsTitle":@"goodsTitle",
             };
}

@end


@implementation TestResponseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{@"data":@"data",
             @"totalCount":@"totalCount"
             };
}

+ (NSValueTransformer *)dataJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[TestResponseItemModel class]];
}

@end
