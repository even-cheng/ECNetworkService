//
//  ViewController.m
//  ECNetworkService
//
//  Created by Even on 2018/4/2.
//  Copyright © 2018年 EvenCheng. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
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

    TestModel* model = [TestModel new];
    model.title = @"test";
    model.pageNumber = @10;
    [ECServer getTestDatasWithParameterModel:model complete:^(EC_RequestError *error, ECBaseResponseModel *response) {
    
        if (error) {
            NSLog(@"%@",error.getMsg);
            return ;
        }
        
        TestResponseModel* responseModel = (TestResponseModel*)response;
        
        //拿到数据刷新UI
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
