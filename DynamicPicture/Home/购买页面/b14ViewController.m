//
//  b12ViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/18.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b14ViewController.h"

@interface b14ViewController ()

@end
@implementation b14ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    [MNetworkManager getBuyDataWithUrl:self.dataUrl Success:^(id data)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
         _title.text = @"无数据";
         _title.textColor = [UIColor hexStringToColor:KNavBarHexColor];
         _title.textAlignment = NSTextAlignmentCenter;
         _title.font = [UIFont systemFontOfSize:20];
         [self.view addSubview:_title];
         _title.centerY = self.view.centerY-60;
     } failure:^(NSError *error)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
         _title.text = @"无数据";
         _title.textColor = [UIColor hexStringToColor:KNavBarHexColor];
         _title.textAlignment = NSTextAlignmentCenter;
         _title.font = [UIFont systemFontOfSize:20];
         [self.view addSubview:_title];
         _title.centerY = self.view.centerY-60;
     }];


    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"四场进球场";
    
}


@end
