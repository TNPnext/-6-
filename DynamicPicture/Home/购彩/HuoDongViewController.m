//
//  HuoDongViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "HuoDongViewController.h"
@interface HuoDongViewController ()

@end

@implementation HuoDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新活动";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    [self performSelector:@selector(hudH) withObject:nil afterDelay:1];
}
-(void)hudH
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, (kMainHeight-30-64)/2, kMainWidth, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"暂无活动";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
