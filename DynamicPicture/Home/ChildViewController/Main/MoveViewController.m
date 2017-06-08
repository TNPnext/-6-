//
//  MoveViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/2.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "MoveViewController.h"
#import "NetworkPublicHeader.h"
#import "MJExtension.h"
#import "ThreeCell.h"
#import "FiveCell.h"
#import "SevenCell.h"
#import "EightCell.h"
#import "MoveTableViewCell.h"
@interface MoveViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_maimTableView;
    NSDictionary *_dataDic;
    NSArray *_dataArr;
}
@end

@implementation MoveViewController

- (void)loadView
{
    [super loadView];
    _dataDic = [NSDictionary new];
    _dataArr = [NSArray new];
    _maimTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight-64-44) style:UITableViewStylePlain];
    _maimTableView.delegate = self;
    _maimTableView.dataSource = self;
    [self.view addSubview:_maimTableView];
    
    [MBProgressHUD showMessage:@"加载中。。。" toView:self.view];
    [MNetworkManager getMoveDataWithLottype:_model.lottype Playtype:_model.playtype Success:^(id data) {
        _dataDic = data;
        NSArray *arr = data[@"list"];
        _dataArr = [MoveModel mj_objectArrayWithKeyValuesArray:arr];
        [_maimTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArr.count>0) {
      return _dataArr.count+1;
    }else
    {
        return 0;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = [CategoryModel new];
    model.isHistory = @"1";
    model.issue = _dataDic[@"kjissue"];
    model.date = @"";
    model.code = _dataDic[@"kjnum"];
    model.cn = _titles;
    
    
    
    if (indexPath.row == 0) {
    if ([model.cn isEqualToString:@"福彩3D"] ||[model.cn isEqualToString:@"排列三"] )
    {
        static NSString *cellIdentifier = @"ThreeCell";
        ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[ThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.model = model;
        return cell;
        
    }
    else if ([model.cn isEqualToString:@"排列五"])
    {
        static NSString *cellIdentifier = @"FiveCell";
        FiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[FiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.model = model;
        return cell;
    }
    else if ([model.cn isEqualToString:@"超级大乐透"] ||[model.cn isEqualToString:@"七星彩"] ||[model.cn isEqualToString:@"双色球"])
    {
        static NSString *cellIdentifier = @"SevenCell";
        SevenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[SevenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.model = model;
        return cell;
    }
    else if ([model.cn isEqualToString:@"七乐彩"])
    {
        static NSString *cellIdentifier = @"EightCell";
        EightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[EightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.model = model;
        return cell;
    }else
    {
        return [UITableViewCell new];
    }
    }else
    {
        MoveModel *OtherModel = _dataArr[indexPath.row-1];
        static NSString *cellIdentifier = @"MoveTableViewCell";
        MoveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[MoveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.model = OtherModel;
        return cell;
    }

}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
