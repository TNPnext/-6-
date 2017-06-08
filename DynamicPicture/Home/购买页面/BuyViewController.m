//
//  BuyViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "BuyViewController.h"

@interface BuyViewController ()

@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    if (_haveList)
    {
        _topTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
        _topTitle.text = @"下拉查看最近开奖记录";
        _topTitle.textColor = [UIColor hexStringToColor:KNavBarHexColor];
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.font = [UIFont systemFontOfSize:14];
        _topTitle.backgroundColor = [UIColor colorWithRed:246/255.0 green:242/255.0 blue:199/255.0 alpha:1];
        [self.view addSubview:_topTitle];
    }
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
