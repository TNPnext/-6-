//
//  BuyRecordViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/23.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "BuyRecordViewController.h"
#import "NetworkPublicHeader.h"
#import "OrderCell.h"
#import "b1Model.h"
#import "MJExtension.h"
@interface BuyRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
}
@end

@implementation BuyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [b2Model mj_objectArrayWithKeyValuesArray:[M_Tool getRecordData]];
    
    self.view.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    
    [MNetworkManager getBuyDataWithUrl:@"http://client.leaicai.com/lottery/my_scheme.htm?&clientUserSession=1404404_5756a53b9845bf691969d06bd61fbae7&firstRow=0&fetchSize=10&type=0&requestType=1&version=1.0.3&appVersion=1" Success:^(id data)
     {
         
     } failure:^(NSError *error)
     {
    
     }];
    self.title = @"购彩记录";

    
    
    if (_dataArray.count>0) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kMainWidth, kMainHeight-64) style:UITableViewStylePlain];
        _tableView.rowHeight = 60;
        //_tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }else
    {
        UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
        _title.text = @"无数据";
        _title.textColor = [UIColor hexStringToColor:KNavBarHexColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:_title];
        _title.centerY = self.view.centerY-60;
  
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SectionOneCell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
