//
//  HistoryViewController.m
//  DynamicPicture
//
//  Created by TNP on 2017/4/27.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "HistoryViewController.h"
#import "MNetworkManager.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "ThreeCell.h"
#import "FiveCell.h"
#import "SevenCell.h"
#import "EightCell.h"
#import "TNPTool.h"

@interface HistoryViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    UIButton *addBtn;
}
@end

@implementation HistoryViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (_dataArray.count==0) {
//        [self.tableView.mj_header beginRefreshing];
//    }
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [addBtn removeFromSuperview];
}
-(void)addClick:(UIButton *)sender
{
    NSArray *arr = TOutDate(@"shoucang");
    NSMutableArray *dataA = [[NSMutableArray alloc]init];
    NSDictionary *dic = [_categorys mj_keyValues];
    if (arr.count>0)
    {
        [dataA addObjectsFromArray:arr];
        if (![dataA containsObject:dic])
        {
         [dataA addObject:dic];
        }
    }else
    {
     [dataA addObject:dic];
    }
    TWriteDate(dataA, @"shoucang");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"成功加入收藏、请到我的收藏中查看管理" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alert show];
}

-(void)loadView
{
    [super loadView];
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(kMainWidth-60, 20, 40, 40);
    [addBtn setTitle:@"收藏" forState:(UIControlStateNormal)];
    [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    addBtn.backgroundColor = [UIColor clearColor];
    [self.navigationController.view addSubview:addBtn];
    
    self.nextPage = 20;
    _dataArray = [[NSMutableArray alloc]init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ThreeCell class] forCellReuseIdentifier:@"Three"];
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.nextPage = 20;
        [weakSelf headUploadingisHead:1];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf headUploadingisHead:0];
        }];

        [MNetworkManager getDetailData:_categorys.n page:20 Success:^(id data) {
    
        // NSLog(@"----------%@",data);
            NSDictionary *dict = data[@"model"];
            NSArray *arr = dict[@"data"];
            _dataArray = [CategoryModel mj_objectArrayWithKeyValuesArray:arr];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
          [MBProgressHUD showError:@"请检查网络是否正常"];
        }];
    
}

-(void)headUploadingisHead:(NSInteger)number
{
    if (number ==1)
    {
        [MNetworkManager getDetailData:_categorys.n page:20 Success:^(id data) {
            
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
        
        [MNetworkManager getDetailData:_categorys.n page:self.nextPage Success:^(id data) {
            
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
    model.isHistory = @"1";
    model.cn = _categorys.cn;
    if ([model.cn isEqualToString:@"福彩3D"] ||[model.cn isEqualToString:@"安徽快3"] ||[model.cn isEqualToString:@"吉林快3"] ||[model.cn isEqualToString:@"湖北快3"] ||[model.cn isEqualToString:@"江苏快3"] ||[model.cn isEqualToString:@"排列三"] )
    {
        
        ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Three" forIndexPath:indexPath];
        cell.model = model;
        return cell;
        
    }
    else if ([model.cn isEqualToString:@"重庆时时彩"] ||[model.cn isEqualToString:@"广东11选5"] ||[model.cn isEqualToString:@"江西11选5"] ||[model.cn isEqualToString:@"山东11选5"]||[model.cn isEqualToString:@"上海11选5"]||[model.cn isEqualToString:@"排列五"]||[model.cn isEqualToString:@"彩运11选5"])
    {
        static NSString *cellIdentifier = @"Five";
        FiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[FiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.model = model;
        return cell;
    }
    else if ([model.cn isEqualToString:@"超级大乐透"] ||[model.cn isEqualToString:@"七星彩"] ||[model.cn isEqualToString:@"双色球"])
    {
        static NSString *cellIdentifier = @"Seven";
        SevenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[SevenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.model = model;
        return cell;
    }
    else if ([model.cn isEqualToString:@"七乐彩"] ||[model.cn isEqualToString:@"广东快乐十分"] ||[model.cn isEqualToString:@"重庆快乐十分"])
    {
        static NSString *cellIdentifier = @"Eight";
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
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
