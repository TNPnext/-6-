//
//  MainViewController.m
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "DynamicPictureListViewController.h"
#import "DynamicPictureCell.h"
#import "DynamicPictureModel.h"

#import "MJRefresh.h"
#import "NSString+Version.h"
#import "UpDataVersionView.h"
#import "ADModel.h"
#import "SearchViewController.h"

#import "NetworkPublicHeader.h"
#import "MJExtension.h"
#import "ADWebViewController.h"
#import "MLoginView.h"

#import "HistoryViewController.h"
#import "ThreeCell.h"
#import "FiveCell.h"
#import "SevenCell.h"
#import "EightCell.h"
NSString * DETAIL_MODIFY_NOTICE = @"DETAIL_MODIFY_NOTICE";

@interface DynamicPictureListViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation DynamicPictureListViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_dataArray.count==0) {
      [self.tableView.mj_header beginRefreshing];
    }
    [self.tableView reloadData];
}

-(void)loadView
{
    [super loadView];
    self.nextPage = 20;
    _dataArray = [[NSMutableArray alloc]init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight - 64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.nextPage = 20;
        [weakSelf getData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf headUploadingisHead:0];
//    }];

    
    [self getData];
    //
//    [MNetworkManager getDetailData:_categorys page:20 Success:^(id data) {
//        
//       // NSLog(@"----------%@",data);
//        NSDictionary *dict = data[@"model"];
//        NSArray *arr = dict[@"data"];
//        _dataArray = [CategoryModel mj_objectArrayWithKeyValuesArray:arr];
//        _type = dict[@"cn"];
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//      [MBProgressHUD showError:@"请检查网络是否正常"];
//    }];
    
}
-(void)getData
{
    [MNetworkManager getMainDataSuccess:^(id data) {
        NSArray *arr = data[@"model"];
        
        _dataArray = [CategoryModel mj_objectArrayWithKeyValuesArray:arr];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"请检查网络是否正常"];
    }];
}
-(void)headUploadingisHead:(NSInteger)number
{
    if (number ==1)
    {
        [MNetworkManager getDetailData:_categorys page:20 Success:^(id data) {
            
            // NSLog(@"----------%@",data);
            NSDictionary *dict = data[@"model"];
            NSArray *arr = dict[@"data"];
            _dataArray = [CategoryModel mj_objectArrayWithKeyValuesArray:arr];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
          [self.tableView.mj_header endRefreshing];
        }];
    }else
    {
        self.nextPage +=20;
        
        [MNetworkManager getDetailData:_categorys page:self.nextPage Success:^(id data) {
            
            // NSLog(@"----------%@",data);
            NSDictionary *dict = data[@"model"];
            NSArray *arr = dict[@"data"];
            _dataArray = [CategoryModel mj_objectArrayWithKeyValuesArray:arr];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
           [self.tableView.mj_footer endRefreshing];
        }];
      
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = _dataArray[indexPath.row];
    if ([model.cn isEqualToString:@"福彩3D"] ||[model.cn isEqualToString:@"安徽快3"] ||[model.cn isEqualToString:@"吉林快3"] ||[model.cn isEqualToString:@"湖北快3"] ||[model.cn isEqualToString:@"江苏快3"] ||[model.cn isEqualToString:@"排列三"] )
    {
        static NSString *cellIdentifier = @"ThreeCell";
        ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[ThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.model = model;
        return cell;
  
    }
    else if ([model.cn isEqualToString:@"重庆时时彩"] ||[model.cn isEqualToString:@"广东11选5"] ||[model.cn isEqualToString:@"江西11选5"] ||[model.cn isEqualToString:@"山东11选5"]||[model.cn isEqualToString:@"上海11选5"]||[model.cn isEqualToString:@"排列五"]||[model.cn isEqualToString:@"彩运11选5"])
    {
        static NSString *cellIdentifier = @"FiveCell";
        FiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[FiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.model = model;
        return cell;
    }
    else if ([model.cn isEqualToString:@"七乐彩"] ||[model.cn isEqualToString:@"广东快乐十分"] ||[model.cn isEqualToString:@"重庆快乐十分"])
    {
        static NSString *cellIdentifier = @"EightCell";
        EightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[EightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.model = model;
        return cell;
    }else
    {
      return [UITableViewCell new];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = _dataArray[indexPath.row];
    if ([model.cn isEqualToString:@"单场"] ||[model.cn isEqualToString:@"快乐扑克3"] ||[model.cn isEqualToString:@"胜负彩14场"])
    {
        return 0;
    }else
    {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = _dataArray[indexPath.row];
    HistoryViewController *hisVC = [HistoryViewController new];
    hisVC.categorys = model;
    hisVC.title = @"开奖记录";
    [self.navigationController pushViewController:hisVC animated:YES];
}
@end
