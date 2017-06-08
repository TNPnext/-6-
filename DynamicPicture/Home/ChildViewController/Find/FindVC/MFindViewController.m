//
//  MFindViewViewController.m
//  MoivePlace
//
//  Created by hewenxue on 17/2/15.
//  Copyright © 2017年 cxmx. All rights reserved.
//

#import "MFindViewController.h"
#import "MFindSearchView.h"
#import "TLSearchWebController.h"
#import "NetworkPublicHeader.h"
#import "BHInfiniteScrollView.h"
#import "MJRefresh.h"
#import <UIImageView+WebCache.h>
#import "MFAppModel.h"
#import "WebDetailViewController.h"
#import "MJExtension.h"
#import "ZiXunTableViewCell.h"
@interface MFindViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_maimTaleView;
    NSMutableArray *_dataArray;
    NSInteger _pages;
}

@end

@implementation MFindViewController

-(void)loadView
{
    [super loadView];
    _dataArray = [[NSMutableArray alloc]init];
    _pages = 1;
    //
    self.view.backgroundColor = [UIColor whiteColor];
    _maimTaleView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight-64-49) style:UITableViewStylePlain];
    _maimTaleView.delegate = self;
    _maimTaleView.rowHeight = 80;
    _maimTaleView.dataSource = self;
    [self.view addSubview:_maimTaleView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pages = 1;
         [self performSelector:@selector(refreshed) withObject:nil afterDelay:1];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    _maimTaleView.mj_header = header;
    _maimTaleView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pages ++;
        [self performSelector:@selector(refreshed) withObject:nil afterDelay:0];
    }];
    
    [MNetworkManager getZiXunpage:1 Type:_urls Success:^(id data) {
       
        _dataArray = [ZiXunModel mj_objectArrayWithKeyValuesArray:data];
        [_maimTaleView reloadData];
    } failure:^(NSError *error) {
        
    }];

}
-(void)refreshed
{
    
    [_maimTaleView.mj_header endRefreshing];
    if (_pages!=1)
    {
        [MNetworkManager getZiXunpage:_pages Type:_urls Success:^(id data) {
            
            NSArray *arr = [ZiXunModel mj_objectArrayWithKeyValuesArray:data];
            [_dataArray addObjectsFromArray:arr];
            [_maimTaleView.mj_footer endRefreshing];
            [_maimTaleView reloadData];
            
        } failure:^(NSError *error) {
          [_maimTaleView.mj_footer endRefreshing];
        }];
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZiXunModel *model = _dataArray[indexPath.row];
    static NSString *cellIdentifier = @"ThreeCell";
    ZiXunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ZiXunTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.model = model;
    cell.selectionStyle = 0;
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ZiXunModel *model = _dataArray[indexPath.row];
    WebDetailViewController *web = [WebDetailViewController new];
    web.titt = @"资讯详情";
    web.url = model.wapLink;
    
    [self presentViewController:web animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
