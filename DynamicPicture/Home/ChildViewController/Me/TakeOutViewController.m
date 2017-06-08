//
//  TakeOutViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/22.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "TakeOutViewController.h"

@interface TakeOutViewController ()
{
    UIView *viewsBg;
}
@end

@implementation TakeOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"提现";
    [self setUI];
}

-(void)setUI
{
    NSArray *titA = @[@"开户行",@"银行卡号",@"开户所在地",@"开户人名字",@"提现金额"];
    NSArray *placeT = @[@"请输入开户行",@"请输入卡号",@"请输入开户所在地",@"请输入开户人名字",@"至少输入100"];
    
    for (int i = 0; i<5; i++)
    {
    viewsBg = [[UIView alloc]initWithFrame:CGRectMake(0, 20+44*i, kMainWidth, 44)];
    [self.view addSubview:viewsBg];
    
    UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 44)];
    _title.text = titA[i];
    _title.textColor = [UIColor blackColor];
    _title.textAlignment = 0;
    _title.font = [UIFont systemFontOfSize:15];
    [viewsBg addSubview:_title];
    
    UITextField *inputF = [[UITextField alloc]initWithFrame:CGRectMake(120, 7, kMainWidth-160, 30)];
    inputF.font = [UIFont systemFontOfSize:15];
    inputF.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputF.tag = i;
    inputF.placeholder = placeT[i];
    [viewsBg addSubview:inputF];
    
    [viewsBg addtionUnderlineWithSross:0.5 withColor:[UIColor grayColor]];
        if (i==4 || i == 1)
        {
            inputF.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 20+44*5+20, kMainWidth, 40);
    
    [addBtn setTitle:@"提现" forState:(UIControlStateNormal)];
    [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    addBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    [self.view addSubview:addBtn];
}

-(void)addClick:(UIButton *)sender
{
    for (UIView *view in viewsBg.subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField *field = (UITextField *)view;
            if ([field.text isEqualToString:@""])
            {
                [MBProgressHUD showSuccess:@"请填写完整信息"];
                return;
            }
            else
            {
                //[MBProgressHUD showSuccess:@"可提现余额不足"];
                return;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
