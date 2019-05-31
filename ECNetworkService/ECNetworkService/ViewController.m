//
//  ViewController.m
//  ECNetworkService
//
//  Created by Even on 2018/4/2.
//  Copyright © 2018年 EvenCheng. All rights reserved.
//

#import "ViewController.h"
#import "UserInfoModel.h"
#import "ECServer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //用法：
    [self loadCardShopDatas];
}

-(void)loadCardShopDatas{

    [ECServer requestWithAPI:APITypeWithGetUserInfo andParams:@{@"userId":@"0"} andAnalysisClass:NSClassFromString(@"UserInfoModel") withComplete:^(EC_RequestError *error, ECBaseResponseModel *response) {
        if (error) {
            return ;
        }
        if (response.isCache) {
            NSLog(@"这是缓存数据");
        } else {
            NSLog(@"这是实时数据");
        }
        UserInfoModel* user = response.data;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
