//
//  PayViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/22.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "PayViewController.h"
#import "NetworkPublicHeader.h"
@interface PayViewController ()
{
    UIView *_topView;
    NSArray *_titArray;
    NSInteger _selectedIndex;
}
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedIndex = 0;
    self.view.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    self.title = @"充值";
    _titArray = @[@"50",@"100",@"200",@"300",@"500",@"1000"];
    [self setUI];
}


-(void)setUI
{
    UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, kMainWidth, 30)];
    _title.text = @"选择充值金额:";
    _title.textColor = [UIColor lightGrayColor];
    _title.textAlignment = 0;
    _title.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_title];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kMainWidth, 110)];
    //_topView.backgroundColor =
    [self.view addSubview:_topView];
    
    for (int i = 0; i<6; i++)
    {
        int row = i%3;
        int lie = i/3;
        int with = (kMainWidth-60)/3;
        int height = 40;
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(15+(with+15)*row, (height+20)*lie, with, height);
        [addBtn setTitle:_titArray[i] forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.tag = i;
        addBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        addBtn.backgroundColor = [UIColor whiteColor];
        addBtn.clipsToBounds = YES;
        addBtn.layer.cornerRadius = 5;
        [addBtn.layer setBorderWidth:0.5];
        [addBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [_topView addSubview:addBtn];
        if (i==0) {
            addBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
            [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [addBtn.layer setBorderColor:[[UIColor hexStringToColor:KNavBarHexColor] CGColor]];
        }
    }

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(15, CGRectGetMaxY(_topView.frame)+20, kMainWidth-30, 44);
    [addBtn setImage:[UIImage imageNamed:@"支付宝"] forState:(UIControlStateNormal)];
    [addBtn setImage:[UIImage imageNamed:@"支付宝"] forState:(UIControlStateSelected)];
    [addBtn setTitle:@"支付宝" forState:(UIControlStateNormal)];
    [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(payClick:) forControlEvents:(UIControlEventTouchUpInside)];
    addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    addBtn.clipsToBounds = YES;
    addBtn.layer.cornerRadius = 5;
    [addBtn.layer setBorderWidth:0.5];
    [addBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    addBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:addBtn];
}

-(void)addClick:(UIButton *)sender
{
    _selectedIndex = sender.tag;
    for (UIButton *addBtn in _topView.subviews)
    {
        if (addBtn.tag == sender.tag)
        {
            addBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
            [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [addBtn.layer setBorderColor:[[UIColor hexStringToColor:KNavBarHexColor] CGColor]];
        }else
        {
            addBtn.backgroundColor = [UIColor whiteColor];
            [addBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [addBtn.layer setBorderColor:[[UIColor grayColor] CGColor]];
        }
    }
}

-(void)payClick:(UIButton *)sender
{
    
    [MNetworkManager getPayWithMoney:_titArray[_selectedIndex] Success:^(id data)
     {
         if ([data[@"message"] isEqualToString:@"成功"])
         {
           [[UIApplication sharedApplication]openURL:[NSURL URLWithString:data[@"pay_info"]]];
         }else
         {
           [MBProgressHUD showSuccess:@"获取充值订单失败"];
         }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"请检查网络是否正常"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
