//
//  TogetherBViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "TogetherBViewController.h"
#import <UIImage+Extension.h>
#import "NetworkPublicHeader.h"
@interface TogetherBViewController ()
{
    NSArray *titA;
    UIView *_topView;
    NSInteger _recordIndex;
    BOOL  _isSelected;
    UIButton *_titleView;
    UIView *_fourBgV;
}
@end

@implementation TogetherBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"" toView:self.view];
    _recordIndex = 0;
    titA = @[@"全部合买",@"双色球",@"福彩3D",@"七乐彩",@"大乐透",@"排列3/5",@"七星彩",@"竞彩足球",@"北京单场",@"十一运夺金",@"胜负14场",@"任选九场",@"竞彩篮球",@"重庆时时彩",@"江西时时彩",@"6场半全场",@"四场进球场",@"广西快3"];
    [self createTitleView];
    [self createFourBtn];
    [MNetworkManager getHeMaiDataSuccess:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
    [self performSelector:@selector(createNoDataView:) withObject:nil afterDelay:0.5];
}

-(void)createNoDataView:(NSString *)str
{
    if ([str isEqualToString:@"1"])
    {
      [MBProgressHUD hideHUDForView:self.view animated:YES];
    }else
    {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((kMainWidth-80)/2, 100, 80, 100)];
    imageV.image = [UIImage imageNamed:@"quexing_icon"];
    [self.view addSubview:imageV];
    
    UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), kMainWidth, 30)];
    _title.text = @"没有查询到相关信息";
    _title.textColor = [UIColor lightGrayColor];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_title];
    }
}

-(void)createFourBtn
{
   _fourBgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 40)];
    _fourBgV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_fourBgV];
    NSArray *tittA = @[@"进度",@"金额",@"剩余",@"热度"];
    for (int i = 0; i<4; i++)
    {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(20+((kMainWidth-40-240)/3+60)*i, 10, 60, 30);
        [addBtn setImage:[UIImage imageNamed:@"choose2"] forState:(UIControlStateNormal)];
        [addBtn setTitle:tittA[i] forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(fourBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.tag = i;
        addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        addBtn.backgroundColor = [UIColor whiteColor];
        [_fourBgV addSubview:addBtn];
        if (i==0) {
            [addBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
            [addBtn setImage:[UIImage imageNamed:@"choose"] forState:(UIControlStateNormal)];
        }
    }
    
}

-(void)fourBtnClick:(UIButton *)sender
{
    [MBProgressHUD showMessage:@"" toView:self.view];
    for (int i = 0; i<_fourBgV.subviews.count; i++)
    {
        UIButton *btn = _fourBgV.subviews[i];
        if (btn.tag == sender.tag)
        {
            [btn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:@"choose"] forState:(UIControlStateNormal)];
        }else
        {
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:@"choose2"] forState:(UIControlStateNormal)];
        }
    }
  
    //
    [MNetworkManager getHeMaiDataSuccess:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
    [self performSelector:@selector(createNoDataView:) withObject:@"1" afterDelay:0.5];
}


-(void)createTitleView
{
    _isSelected = NO;
    _titleView = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 150, 24)];
    _titleView.backgroundColor = [UIColor clearColor];
    [_titleView setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_titleView addTarget:self action:@selector(titleViewClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_titleView setImage:[[UIImage imageNamed:@"jiantou"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
    [_titleView setTitle:titA[_recordIndex] forState:(UIControlStateNormal)];
    self.navigationItem.titleView = _titleView;
    
}

-(void)titleViewClick:(UIButton *)sender
{

    _isSelected = !_isSelected;
    if (_isSelected)
    {
     [sender setTitle:titA[_recordIndex] forState:(UIControlStateNormal)];
    [sender setImage:[[UIImage imageNamed:@"jiantou_1"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [self coreateSelecteView];
    }else
    {
        [sender setTitle:titA[_recordIndex] forState:(UIControlStateNormal)];
        [sender setImage:[[UIImage imageNamed:@"jiantou"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [UIView animateWithDuration:1 animations:^{
            _topView.superview.alpha = 0;
        } completion:^(BOOL finished) {
            [_topView.superview removeFromSuperview];
        }];
    }
}

-(void)coreateSelecteView
{
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, (kMainHeight-64-49))];
    bgV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bgV];
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, (kMainHeight-64-49)/2)];
    _topView.backgroundColor = [UIColor whiteColor];
    [bgV addSubview:_topView];
    
    for (int i = 0; i<18; i++)
    {
        int row = i%3;
        int lie = i/3;
        int with = (kMainWidth-50)/3;
        int height = (((kMainHeight-64-49)/2)-70)/6;
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(10+(with+15)*row, 10+(height+10)*lie, with, height);
        [addBtn setTitle:titA[i] forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.tag = i;
        addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        addBtn.backgroundColor = [UIColor whiteColor];
        addBtn.clipsToBounds = YES;
        addBtn.layer.cornerRadius = 5;
        [addBtn.layer setBorderWidth:0.5];
        [addBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [_topView addSubview:addBtn];
        if (i==_recordIndex) {
            addBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
            [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [addBtn.layer setBorderColor:[[UIColor hexStringToColor:KNavBarHexColor] CGColor]];
        }
    }
   
}


-(void)addClick:(UIButton *)sender
{
    [MBProgressHUD showMessage:@"" toView:self.view];
    _recordIndex = sender.tag;
    _isSelected = NO;
    [_titleView setTitle:titA[_recordIndex] forState:(UIControlStateNormal)];
    [_titleView setImage:[[UIImage imageNamed:@"jiantou"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
    [UIView animateWithDuration:1 animations:^{
        sender.superview.superview.alpha = 0;
    } completion:^(BOOL finished) {
        [sender.superview.superview removeFromSuperview];
    }];
    
    [MNetworkManager getHeMaiDataSuccess:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
    [self performSelector:@selector(createNoDataView:) withObject:@"1" afterDelay:0.5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
