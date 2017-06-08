//
//  b11ViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/18.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b11ViewController.h"

@interface b11ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    NSMutableArray *_boolArray;
    UILabel *_chooselabel;
    NSInteger _recordSelectCount;
    NSString *_sellEndTime;
}
@end

@implementation b11ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _recordSelectCount = 0;
    self.view.backgroundColor = [UIColor grayColor];
    
    _dataArray = [NSArray array];
    _boolArray = [[NSMutableArray alloc]init];
    self.title = @"胜负14场";
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    [addBtn setImage:[[UIImage imageNamed:@"i"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    addBtn.tag = 0;
    addBtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight-64-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor hexStringToColor:@"f4f4f4"];
    [self.view addSubview:_tableView];
    
    
    UIView *_bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kMainHeight-44-64, kMainWidth, 44)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBtn.frame = CGRectMake(0, 0, 60, 44);
    [cleanBtn setTitle:@"清空" forState:(UIControlStateNormal)];
    [cleanBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
    cleanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cleanBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cleanBtn.tag = 1;
    cleanBtn.backgroundColor = [UIColor clearColor];
    [cleanBtn addtionVarticalLineWithSross:0.5 withLeft:60 withColor:[UIColor lightGrayColor]];
    [cleanBtn addtionHorizontalLineWithSross:0.5 withTop:0 withColor:[UIColor lightGrayColor]];
    [_bottomView addSubview:cleanBtn];
    
    
    _chooselabel = [UILabel new];
    _chooselabel.frame = CGRectMake(60, 0, kMainWidth-120, 44);
    _chooselabel.text = @"至少选择14场比赛";
    _chooselabel.textAlignment = NSTextAlignmentCenter;
    _chooselabel.textColor = [UIColor lightGrayColor];
    _chooselabel.font = [UIFont systemFontOfSize:14];
    _chooselabel.backgroundColor = [UIColor clearColor];
    [_chooselabel addtionHorizontalLineWithSross:0.5 withTop:0 withColor:[UIColor lightGrayColor]];
    
    [_bottomView addSubview:_chooselabel];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(kMainWidth-60, 0, 60, 44);
    [sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    sureBtn.tag = 2;
    sureBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    [_bottomView addSubview:sureBtn];
    
    
    [self.view addSubview:_bottomView];
    [MBProgressHUD showMessage:@"数据加载中..." toView:self.view];
    [MNetworkManager getBuyDataWithUrl:self.dataUrl Success:^(id data)
     {
         
         _dataArray = data[@"data"];
         _sellEndTime = data[@"sellEndTime"];
         if (_dataArray.count>0)
         {
             for (int i = 0; i<_dataArray.count; i++)
             {
                NSMutableArray *arrs = [[NSMutableArray alloc]initWithArray:@[@"0",@"0",@"0"]];
 
                [_boolArray addObject:arrs];
             }
             [_tableView reloadData];
         }else
         {
             [_tableView reloadData];
         }
        [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1];
     } failure:^(NSError *error)
     {
         [self performSelector:@selector(hideHUD) withObject:nil afterDelay:0];
         _dataArray = @[];
         [_tableView reloadData];
         NSLog(@"error==========%@",error);
     }];
    
}
-(void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)addClick:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
        {
            WebDetailViewController *web = [[WebDetailViewController alloc]init];
            web.url = @"http://client.leaicai.com//news/10059.htm?requestType=1&version=1.0.3&appVersion=1";
            web.titt = @"玩法规则";
            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 1:
        {
            [_boolArray removeAllObjects];
            _chooselabel.text = @"至少选择14场比赛";
            if (_dataArray.count>0)
            {
                for (int i = 0; i<_dataArray.count; i++)
                {
                    NSMutableArray *arrs = [[NSMutableArray alloc]initWithArray:@[@"0",@"0",@"0"]];
                    
                    [_boolArray addObject:arrs];
                }
                [_tableView reloadData];
            }
        }
            break;
        case 2:
        {
            if (_recordSelectCount < 14) {
                [MBProgressHUD showError:@"至少选择14场比赛" toView:self.view];
                return;
            }
            if ([M_Tool isLogin])
            {
                [MBProgressHUD showError:@"攻城狮攻克中。。。" toView:self.view];
            }else
            {
                [MBProgressHUD showError:@"请先登录" toView:self.view];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_dataArray.count>0)?_dataArray.count:0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    b3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell)
    {
        cell = [[b3Cell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    cell.indexPath = indexPath;
    
    NSArray *data = [b1Model mj_objectArrayWithKeyValuesArray:_dataArray];
    
    cell.model = data[indexPath.row];
    UIView *bgv = [cell.contentView viewWithTag:120];
    
    NSMutableArray *boolA = _boolArray[indexPath.row];
    for (int i = 0; i<bgv.subviews.count; i++)
    {
        UIButton *btn = bgv.subviews[i];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if ([boolA[btn.tag] boolValue])
        {
            btn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [btn.layer setBorderColor:[[UIColor hexStringToColor:KNavBarHexColor] CGColor]];
        }else
        {
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        }
        
    }
    
    return cell;
}

-(void)buttonClick:(UIButton *)sender
{
    //NSLog(@"------------%@",sender.superview.superview);
    b3Cell *cell = (b3Cell *)sender.superview.superview.superview;
    NSMutableArray *boolA = _boolArray[cell.indexPath.row];
    if ([boolA[sender.tag] isEqualToString:@"1"])
    {
        [boolA replaceObjectAtIndex:sender.tag withObject:@"0"];
        //[boolA replaceObjectAtIndex:cell.indexPath.row withObject:smallA];
        [_boolArray replaceObjectAtIndex:cell.indexPath.row withObject:boolA];
        _recordSelectCount--;
    }else
    {
        _recordSelectCount++;
        [boolA replaceObjectAtIndex:sender.tag withObject:@"1"];
        //[boolA replaceObjectAtIndex:cell.indexPath.row withObject:smallA];
        [_boolArray replaceObjectAtIndex:cell.indexPath.row withObject:boolA];
    }
    [_tableView reloadData];
    if (_recordSelectCount==0) {
        _chooselabel.text = @"至少选择14场比赛";
        return;
    }
    NSString *ss = [NSString stringWithFormat:@"%ld",_recordSelectCount];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已选%ld注",_recordSelectCount]];
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor hexStringToColor:KNavBarHexColor]
                range:NSMakeRange(2,ss.length)];
    _chooselabel.attributedText = str;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
    _title.text = [NSString stringWithFormat:@"截止时间:%@",_sellEndTime];
    _title.textColor = [UIColor hexStringToColor:KNavBarHexColor];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:14];
    _title.backgroundColor = [UIColor colorWithRed:246/255.0 green:242/255.0 blue:199/255.0 alpha:1];
    
    [_title addtionHoriaontalLineWithSross:0.5 withLeft:0 withColor:[UIColor lightGrayColor]];
    [_title addtionHoriaontalLineWithSross:0.5 withLeft:0 withTop:0 withColor:[UIColor lightGrayColor]];
    return _title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
