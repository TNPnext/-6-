//
//  CollectionViewController.m
//  DynamicPicture
//
//  Created by TNP on 17/2/20.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "CollectionViewController.h"
#import "MJExtension.h"
#import "DynamicPictureModel.h"
#import "APIs.h"
#import "DynamicPictureCell.h"
#import "DetailViewController.h"
#import "ADModel.h"
#import "MJRefresh.h"
#import "TNPTool.h"
#import "CategoryModel.h"
@interface CollectionViewController ()
{
    UILabel *_noDataTitle;
}
@end

@implementation CollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, 0, kMainWidth, kMainHeight - 64);
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
   // NSMutableArray *dicArray = [DynamicPictureModel mj_keyValuesArrayWithObjectArray:self.models];
}
-(void)getData
{
    
}
-(void)isHaveDataWithArray:(NSArray *)models
{
    
    if (models.count<1)
    {
        if (_noDataTitle)
        {
           _noDataTitle.alpha = 1;
        }else
        {
            [self initNoDataViews];
        }
        self.tableView.alpha = 0;
    }else
    {
        _noDataTitle.alpha = 0;
        self.tableView.alpha = 1;
    }
    self.dataArray = [CategoryModel mj_objectArrayWithKeyValuesArray:models];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        NSArray *dic = [CategoryModel mj_keyValuesArrayWithObjectArray:self.dataArray];
        TWriteDate(dic, @"shoucang");
        [self isHaveDataWithArray:self.dataArray];
    }
    [self.tableView reloadData];
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = NO;
    NSArray *dicArr = TOutDate(@"shoucang");

    if (dicArr.count>0)
    {
        [self.tableView reloadData];
    }
    [self isHaveDataWithArray:dicArr];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//没有收藏记录
- (void)initNoDataViews
{
    _noDataTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 60)];
    _noDataTitle.centerX = self.view.centerX;
    _noDataTitle.centerY = self.view.centerY-(self.view.centerY/4);
    _noDataTitle.text = @"暂无收藏内容";
    _noDataTitle.font = [UIFont systemFontOfSize:20];
    _noDataTitle.textColor = [UIColor redColor];
    _noDataTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_noDataTitle];
}

@end
