//
//  SearchViewController.m
//  DynamicPicture
//
//  Created by TNP on 17/2/20.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "SearchViewController.h"

#import "MainViewController.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_maimTaleView;
    NSArray *_dataArray;
}

@end

@implementation SearchViewController
-(void)createADVView
{
    //CGFloat viewHeight = [UIScreen mainScreen].bounds.size.width/3;
    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainHeight, 44)];
    views.backgroundColor = [UIColor whiteColor];
    
    UILabel *tits = [[UILabel alloc]initWithFrame:CGRectMake(17, 0, kMainWidth, 44)];
    tits.text = @"预测开奖";
    tits.textAlignment = NSTextAlignmentLeft;
    tits.font = [UIFont systemFontOfSize:15];
    [views addSubview:tits];

    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(17, 44, kMainWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [views addSubview:line];
    
    _maimTaleView.tableHeaderView = views;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"专家预测";
    NSArray *array = @[@"双色球",@"福彩3D", @"七乐彩",@"七星彩",@"排列三",@"排列五",@"超级大乐透"];
    
    _dataArray = [array mutableCopy];
    //
    _maimTaleView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight-64) style:UITableViewStylePlain];
    _maimTaleView.delegate = self;
    _maimTaleView.dataSource = self;
    _maimTaleView.rowHeight = 80;
    [self.view addSubview:_maimTaleView];
   [self createADVView];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
        UIImageView *_headImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        _headImg.clipsToBounds = YES;
        _headImg.layer.cornerRadius = 30;
        _headImg.tag = 120;
        [cell.contentView addSubview:_headImg];
        
        UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 60)];
        _title.tag = 130;
        _title.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:_title];
    }
    // NSArray *array = @[@"双色球",@"福彩3D", @"七乐彩",@"七星彩",@"排列三",@"排列五",@"超级大乐透"];
    NSArray *imgA = @[@"1",@"13",@"14",@"17",@"15",@"16",@"2"];
    UIImageView *img = [cell.contentView viewWithTag:120];
    img.image = [UIImage imageNamed:imgA[indexPath.row]];
    UILabel *tit = [cell.contentView viewWithTag:130];
    tit.text = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewController *mainVc = [MainViewController new];
    mainVc.selectIndex = indexPath.row;
    [self.navigationController pushViewController:mainVc animated:YES];
}

@end
