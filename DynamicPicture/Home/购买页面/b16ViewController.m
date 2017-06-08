//
//  b16ViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/18.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b16ViewController.h"

@interface b16ViewController ()

@end

@implementation b16ViewController

- (void)viewDidLoad {
    self.haveList = NO;
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
    self.title = @"山东11选5";
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
