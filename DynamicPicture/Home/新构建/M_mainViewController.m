//
//  M_mainViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "M_mainViewController.h"
#import "BHInfiniteScrollView.h"
#import "MJRefresh.h"
#import "SectionOneCell.h"
#import "SectionTwoCell.h"
#import "SectionThreeCell.h"
#import "SectionFourCell.h"
#import "BuyViewController.h"
#import "HuoDongViewController.h"
#import "SearchViewController.h"
#import "ZiXunMViewController.h"
#import "WebDetailViewController.h"
#import "BuyViewController.h"
#import "BuyHeader.h"


@interface M_mainViewController ()<UITableViewDelegate,UITableViewDataSource,SectionOneCellDelegate,SectionTwoCellDelegate,SectionThreeCellDelegate,SectionFourCellDelegate>
{
    UITableView *_tableView;
}
@end

@implementation M_mainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableviewCreate];
    
}
-(void)RefreshEnd
{
    [_tableView.mj_header endRefreshing];
}

-(void)tableviewCreate
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    //_tableView.backgroundColor = [UIColor redColor];
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf performSelector:@selector(RefreshEnd) withObject:nil afterDelay:1];
    }];
    _tableView.mj_header = header;
    
    UIView *_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainWidth/3+100)];
    NSArray *urlsArray = @[[UIImage imageNamed:@"banner"],[UIImage imageNamed:@"banner0"],[UIImage imageNamed:@"banner00"],[UIImage imageNamed:@"banner000"]];
    //NSArray *titlesArray = @[];
    BHInfiniteScrollView* infinitePageView2 = [BHInfiniteScrollView
                                               infiniteScrollViewWithFrame:CGRectMake(0, 0, kMainWidth, kMainWidth/3+20) Delegate:nil ImagesArray:urlsArray];
    infinitePageView2.titlesArray = nil;
    infinitePageView2.dotSize = 8;
    infinitePageView2.dotSpacing = 0.5;
    infinitePageView2.pageControlAlignmentOffset = CGSizeMake(10,10);
    infinitePageView2.scrollTimeInterval = 3.0f;
    infinitePageView2.dotColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    infinitePageView2.selectedDotColor = [UIColor hexStringToColor:KNavBarHexColor];
    infinitePageView2.autoScrollToNextPage = YES;
    infinitePageView2.scrollDirection = BHInfiniteScrollViewScrollDirectionHorizontal;
    infinitePageView2.pageControlAlignmentH = BHInfiniteScrollViewPageControlAlignHorizontalRight;
    infinitePageView2.pageControlAlignmentV = BHInfiniteScrollViewPageControlAlignVerticalButtom;
    infinitePageView2.reverseDirection = NO;
    [_view addSubview:infinitePageView2];
    
    UIView *_view2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(infinitePageView2.frame), kMainWidth, 80)];
    _view2.backgroundColor =[UIColor hexStringToColor:@"f4f4f4"];
    NSArray *imgA = @[@"直播",@"资讯",@"活动",@"专家"];
    for (int i = 0; i<4; i++)
    {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake((kMainWidth/4)*i, 0, kMainWidth/4,70);
        [addBtn setImage:[UIImage imageNamed:imgA[i]] forState:(UIControlStateNormal)];
        [addBtn setTitle:imgA[i] forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 10, 0, 0);
        addBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -40, 0, 0);
        addBtn.tag = i;
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.backgroundColor = [UIColor whiteColor];
        [_view2 addSubview:addBtn];
    }
    [_view addSubview:_view2];
    
    
    
    
    _tableView.tableHeaderView = _view;
}

-(void)addClick:(UIButton *)sender
{
  //@[@"直播",@"资讯",@"活动",@"专家"];
    switch (sender.tag) {
        case 0:
        {
            WebDetailViewController *webD = [WebDetailViewController new];
            webD.url = @"http://lac.mc.sportsdt.com/live/";
            webD.titt = @"直播";
          [self.navigationController pushViewController:webD animated:YES];
        }
            break;
        case 1:
        {
          [self.navigationController pushViewController:[ZiXunMViewController new] animated:YES];
        }
            break;
        case 2:
        {
          [self.navigationController pushViewController:[HuoDongViewController new] animated:YES];
        }
            break;
        case 3:
        {
          [self.navigationController pushViewController:[SearchViewController new] animated:YES];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 190;
    }else
    {
        return 110;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
    static NSString *cellIdentifier = @"SectionOneCell";
    SectionOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[SectionOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.delegate = self;
    return cell;
    }
    else if (indexPath.row == 1) {
        static NSString *cellIdentifier = @"SectionTwoCell";
        SectionTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[SectionTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.delegate = self;
        return cell;
    }
    else if (indexPath.row == 2) {
        static NSString *cellIdentifier = @"SectionThreeCell";
        SectionThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[SectionThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.delegate = self;
        return cell;
    }
    else {
        static NSString *cellIdentifier = @"SectionFourCell";
        SectionFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[SectionFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.delegate = self;
        return cell;
    }


}
//第1区
-(void)SectionOneCellClick:(UIButton *)sender
{
    NSArray *arr = @[@"http://client.leaicai.com/lottery/spf.htm?fIssues=all&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10032&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10026&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10074&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10025&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10030&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/bjdc.htm?requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/basketball.htm?version=1.0.3&requestType=1&appVersion=1"];
    NSArray *vcs = @[[b1ViewController new],[b2ViewController new],[b3ViewController new],[b4ViewController new],[b5ViewController new],[b6ViewController new],[b7ViewController new],[b8ViewController new]];
    BuyViewController *buyV = vcs[sender.tag];
    buyV.dataUrl = arr[sender.tag];
    if (sender.tag == 1 ||sender.tag == 2||sender.tag == 3 ||sender.tag == 4||sender.tag == 5) {
        buyV.haveList = YES;
    }
    [self.navigationController pushViewController:buyV animated:YES];
}

//第2区
-(void)SectionTwoCellCellClick:(UIButton *)sender
{
    NSArray *arr = @[@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10025&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10033&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10024&firstRow=0&fetchSize=5&qianId=5&requestType=1&version=1.0.3&appVersion=1"];
    NSArray *vcs = @[[b5ViewController new],[b9ViewController new],[b10ViewController new]];
    BuyViewController *buyV = vcs[sender.tag];
    buyV.dataUrl = arr[sender.tag];
    buyV.haveList = YES;
    [self.navigationController pushViewController:buyV animated:YES];
}

//第3区
-(void)SectionThreeCellClick:(UIButton *)sender
{
    NSArray *arr = @[@"http://client.leaicai.com//lottery/toto14.htm?issue=0&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com//lottery/toto9.htm?issue=0&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com//lottery/toto6.htm?issue=0&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/goal4.htm?issue=0&requestType=1&version=1.0.3&appVersion=1"];
    NSArray *vcs = @[[b11ViewController new],[b12ViewController new],[b13ViewController new],[b14ViewController new]];
    BuyViewController *buyV = vcs[sender.tag];
    buyV.dataUrl = arr[sender.tag];
    buyV.haveList = NO;
    [self.navigationController pushViewController:buyV animated:YES];
}

//第4区
-(void)SectionFourCellCellClick:(UIButton *)sender
{
    NSArray *arr = @[@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10038&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10046&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1",@"http://client.leaicai.com/lottery/issue_notify.htm?lotteryId=10073&firstRow=0&fetchSize=5&requestType=1&version=1.0.3&appVersion=1"];
    NSArray *vcs = @[[b15ViewController new],[b16ViewController new],[b4ViewController new]];
    BuyViewController *buyV = vcs[sender.tag];
    buyV.dataUrl = arr[sender.tag];
    buyV.haveList = YES;
    [self.navigationController pushViewController:buyV animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
