//
//  OrderViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/23.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "UserModel.h"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    int         _mupNumber;
    UITextField *_fieldV;
    UILabel *BL;
}
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mupNumber = 1;
    self.view.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kMainWidth, 61) style:UITableViewStylePlain];
    _tableView.rowHeight = 60;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
   
    
    _fieldV = [[UITextField alloc]initWithFrame:CGRectMake((kMainWidth-100)/2-60, 100, 100, 30)];
    _fieldV.borderStyle = UITextBorderStyleRoundedRect;
    _fieldV.keyboardType = UIKeyboardTypeNumberPad;
    _fieldV.font = [UIFont systemFontOfSize:15];
    _fieldV.clearButtonMode = UITextFieldViewModeWhileEditing;
    _fieldV.placeholder = @"最大999";
    _fieldV.text = @"1";
    [self.view addSubview:_fieldV];
    
    BL = [[UILabel alloc]initWithFrame:CGRectMake((kMainWidth-100)/2+50, 100, 200, 30)];
    BL.text = [NSString stringWithFormat:@"倍  总%d元",[_model.number intValue]*2*_mupNumber];
    [self.view addSubview:BL];
    
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(10, 200, kMainWidth-20, 44);
    [sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sureBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.cornerRadius = 5;
    sureBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    [self.view addSubview:sureBtn];
    
    
    
    
    UILabel *resonL = [[UILabel alloc]initWithFrame:CGRectMake(0, kMainHeight-200, kMainWidth, 100)];
    resonL.text = @"    《购买彩票申明》：如果用户在使用过程中遇到以下情况，购买彩票中奖无法兑换引起的用户纷争造成用户的损失，本公司会承担用户的损失给予补偿，如引起法律责任，本公司会承担法律责任，与苹果公司无关。";
    resonL.numberOfLines = 0;
    resonL.textColor = [UIColor lightGrayColor];
    resonL.textAlignment = NSTextAlignmentLeft;
    resonL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:resonL];
}

-(void)addClick:(UIButton *)sender
{
    UserModel *usermodel = [M_Tool getUserInfo];
    _mupNumber = [_fieldV.text intValue];
    BL.text = [NSString stringWithFormat:@"倍  总%d元",[_model.number intValue]*2*_mupNumber];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定投注？" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *yAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        if ([usermodel.money intValue]-([_model.number intValue]*2*_mupNumber)<0)
        {
            [MBProgressHUD showSuccess:@"可用余额不足 请先充值"];
        }else
        {
//            [MBProgressHUD showSuccess:@"攻城狮攻克中"];
//            usermodel.money = [NSString stringWithFormat:@"%d",[usermodel.money intValue]-([_model.number intValue]*2*_mupNumber)];
//            [M_Tool saveUserInfo:usermodel];
//            _model.multiple = _fieldV.text;
//            
//            [M_Tool saveRecordDataWithdata:_model];
//            [MBProgressHUD showSuccess:@"购彩成功 请到我的购彩记录中查看状态"];
//            [self.navigationController popViewControllerAnimated:YES];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.555c9.com/Index/h5.html#/home"]];
        }
    }];
    UIAlertAction *nAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
    [alertVc addAction:yAction];
    [alertVc addAction:nAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SectionOneCell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.witeL.hidden = YES;
    cell.model = _model;
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if ([_fieldV.text isEqualToString:@""] || [_fieldV.text isEqualToString:@"0"] || [_fieldV.text intValue]<1)
    {
        _fieldV.text = @"1";
    }
    _mupNumber = [_fieldV.text intValue];
    BL.text = [NSString stringWithFormat:@"倍  总%d元",[_model.number intValue]*2*_mupNumber];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    if ([_fieldV.text isEqualToString:@""] || [_fieldV.text isEqualToString:@"0"] || [_fieldV.text intValue]<1)
    {
        _fieldV.text = @"1";
    }
    _mupNumber = [_fieldV.text intValue];
    BL.text = [NSString stringWithFormat:@"倍  总%d元",[_model.number intValue]*2*_mupNumber];
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
