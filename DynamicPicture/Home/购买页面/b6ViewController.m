//
//  b6ViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/9.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b6ViewController.h"

@interface b6ViewController ()<UIScrollViewDelegate>
{
    NSArray *_titArray;
    NSArray *_tipArray;
    UIView *_topView;
    UIView *_kTopView;
    NSInteger _recordIndex;
    BOOL  _isSelected;
    UIButton *_titleView;
    UIView *_fourBgV;
    UIScrollView *_bgV;
    UILabel *_topT;
    NSMutableArray  *_dataArray;
    NSUInteger _isHaveBall;
    UIButton *cleanBtn;
    UILabel *_chooselabel;
    UIView *_sectionV;
    long total;

}
@end

@implementation b6ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isHaveBall = NO;
    _recordIndex = 0;
    self.title = @"七星彩";
    [self createtMainView];
    [MNetworkManager getBuyDataWithUrl:self.dataUrl Success:^(id data)
     {
         _dataArray = [b2Model mj_objectArrayWithKeyValuesArray:data];
         [self dataRolad];
     } failure:^(NSError *error)
     {
         NSLog(@"error==========%@",error);
     }];

}


-(void)dataRolad
{
    for (int i = 0; i<_kTopView.subviews.count; i++)
    {
        UILabel *label = _kTopView.subviews[i];
        if (label.tag != 110)
        {
            b2Model *model = _dataArray[label.tag];
            NSString *str = [model.drawNumber stringByReplacingOccurrencesOfString:@"," withString:@" "];
            NSString *str1 = [str stringByReplacingOccurrencesOfString:@"#" withString:@" "];
            NSString *str3 = [NSString stringWithFormat:@"%@期                   %@",model.issue,str1];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str3];
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor lightGrayColor]
                                     range:NSMakeRange(0,model.issue.length+1)];
            
            
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor hexStringToColor:KNavBarHexColor]
                                     range:NSMakeRange(str3.length-str1.length,str1.length)];
            
            label.attributedText = attributedString;
            
        }
    }
}

-(void)createtMainView
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    [addBtn setImage:[UIImage imageNamed:@"列表"] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    addBtn.tag = 0;
    addBtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    _kTopView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, 130)];
    _kTopView.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [self.view addSubview:_kTopView];
    
    UILabel *_toptitle = [[UILabel alloc]initWithFrame:CGRectMake(-20, 0, kMainWidth, 30)];
    _toptitle.text = @"              期号                          开奖号";
    _toptitle.tag = 110;
    _toptitle.textColor = [UIColor blackColor];
    _toptitle.textAlignment = NSTextAlignmentCenter;
    _toptitle.font = [UIFont systemFontOfSize:14];
    [_kTopView addSubview:_toptitle];
    
    for (int i = 0; i<5; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+20*i, kMainWidth, 20)];
        label.tag = i;
        label.backgroundColor = (i%2==0)?[UIColor whiteColor]:[UIColor hexStringToColor:@"f4f4f4"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        
        
        [_kTopView addSubview:label];
    }
    
    
    _bgV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, kMainHeight-64-30-44)];
    _bgV.delegate = self;
    _bgV.bounces = NO;
    _bgV.contentSize = CGSizeMake(kMainWidth, 75*7+250);
    _bgV.pagingEnabled = NO;
    _bgV.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [self.view addSubview:_bgV];
    
    _topT = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
    _topT.textColor = [UIColor grayColor];
    _topT.text = @"  每位至少选择1个号码";
    _topT.textAlignment = NSTextAlignmentLeft;;
    _topT.font = [UIFont systemFontOfSize:15];
    _topT.backgroundColor = [UIColor clearColor];
    [_bgV addSubview:_topT];
    
    _sectionV = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, 75*7+250)];
    _sectionV.backgroundColor = [UIColor clearColor];
    [_bgV addSubview:_sectionV];
    
    [self section1];
    
    UIView *_bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kMainHeight-44-64, kMainWidth, 44)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBtn.frame = CGRectMake(0, 0, 60, 44);
    [cleanBtn setTitle:@"清空" forState:(UIControlStateNormal)];
    [cleanBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
    cleanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cleanBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cleanBtn.tag = 1;
    cleanBtn.backgroundColor = [UIColor clearColor];
    [cleanBtn addtionVarticalLineWithSross:0.5 withLeft:60 withColor:[UIColor lightGrayColor]];
    [_bottomView addSubview:cleanBtn];
    
    
    _chooselabel = [UILabel new];
    _chooselabel.frame = CGRectMake(60, 0, kMainWidth-120, 44);
    _chooselabel.text = @"已选0投注，共0元";
    _chooselabel.textAlignment = NSTextAlignmentCenter;
    _chooselabel.textColor = [UIColor hexStringToColor:KNavBarHexColor];
    _chooselabel.font = [UIFont systemFontOfSize:14];
    _chooselabel.adjustsFontSizeToFitWidth = YES;
    _chooselabel.backgroundColor = [UIColor clearColor];
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
}

-(void)sectionClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected)
    {
        [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        sender.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    }else
    {
        
        [sender setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
        sender.backgroundColor = [UIColor whiteColor];
    }
    
             total = 1;
            for (UIView *sectionV in _sectionV.subviews)
            {
                int record = 0;

                    for (UIView *view in sectionV.subviews)
                    {
                        if (view.tag != 110)
                        {
                            UIButton *btn = (UIButton *)view;
                            if (btn.selected)
                            {
                                record++;
                            }
                        }
                    }
                if (record == 0)
                {
                    _isHaveBall = NO;
                    _chooselabel.text = @"已选0投注，共0元";
                    _chooselabel.textColor = [UIColor hexStringToColor:KNavBarHexColor];
                    return;
                }
                total = total*record;

            }
            if (total==0)
            {
                _isHaveBall = NO;
                _chooselabel.text = @"已选0投注，共0元";
                _chooselabel.textColor = [UIColor hexStringToColor:KNavBarHexColor];
                return;
            }
            _isHaveBall = YES;
            _chooselabel.textColor = [UIColor lightGrayColor];
            NSString *ss1 = [NSString stringWithFormat:@"%ld",total];
            NSString *ss2 = [NSString stringWithFormat:@"%ld",total*2];
            NSString *str = [NSString stringWithFormat:@"已选%ld投注，共%ld元",total,total*2];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor hexStringToColor:KNavBarHexColor]
                                     range:NSMakeRange(2,ss1.length)];
            
            
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor hexStringToColor:KNavBarHexColor]
                                     range:NSMakeRange(str.length-ss2.length-1,ss2.length)];
            _chooselabel.attributedText = attributedString;
    
}
//导航右item
-(void)addClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            GuiZheView *gzView = [[GuiZheView alloc]init];
            [gzView showView];
            gzView.btnBlock = ^(NSInteger index) {
                NSString *url = @"";
                NSString *title = @"";
                if (!index)
                {
                    //走势
                    url = @"http://m.leaicai.com/saishi/jzzoushi";
                    title = @"号码走势";
                }else
                {
                    //玩法规则
                    url = @"http://client.leaicai.com//news/10030.htm?requestType=1&version=1.0.3&appVersion=1";
                    title = @"玩法规则";
                }
                WebDetailViewController *web = [[WebDetailViewController alloc]init];
                web.url = url;
                web.titt = title;
                [self.navigationController pushViewController:web animated:YES];
            };
  
        }
            break;
        case 1:
        {
            _chooselabel.textColor = [UIColor hexStringToColor:KNavBarHexColor];
            _chooselabel.text = @"已选0投注，共0元";
            _isHaveBall = NO;
            [self cleanSelected];
            
        }
            break;
        case 2:
        {
            if (_isHaveBall)
            {
                UserModel *user = [M_Tool getUserInfo];
                if ([M_Tool isLogin])
                {
                    if ([user.money intValue]>0)
                    {
                        b2Model *model = [[b2Model alloc]init];
                        model.drawNumber = [self getSeletedBall];
                        model.number = [NSString stringWithFormat:@"%ld",total];
                        
                        model.types = @"单式投注";
                        
                        OrderViewController *orderVc = [[OrderViewController alloc]init];
                        orderVc.title = @"七星彩-普通投注";
                        orderVc.model = model;
                        [self.navigationController pushViewController:orderVc animated:YES];
                    }else
                    {
                        [MBProgressHUD showError:@"可用余额不足 请先充值" toView:self.view];
                    }
                }else
                {
                    [MBProgressHUD showError:@"请先登录" toView:self.view];
                }
            }
        }
            break;
        default:
            break;
    }
}

-(void)cleanSelected
{
    for (UIView *sectionV in _sectionV.subviews)
    {
        for (UIView *view in sectionV.subviews)
        {
            if (view.tag != 110)
            {
                UIButton *btn = (UIButton *)view;
                btn.selected = NO;
                [btn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
                btn.backgroundColor = [UIColor whiteColor];
            }
        }
 
    }
  
}

-(void)section1
{
    [_sectionV removeAllSubviews];
    int ballH = 35;
    
    NSArray *sectiontA = @[@" 第一位",@" 第二位",@" 第三位",@" 第四位",@" 第五位",@" 第六位",@" 第七位",];
    for (int s= 0; s<7; s++)
    {
        UIView *sectionV = [[UIView alloc]initWithFrame:CGRectMake(0,(75+25)*s, kMainWidth, 90)];
        sectionV.tag = s;
        sectionV.backgroundColor = [UIColor clearColor];
        [_sectionV addSubview:sectionV];
        
        UILabel *sectionT = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, ballH)];
        sectionT.text = sectiontA[s];
        sectionT.tag =110;
        sectionT.textAlignment = NSTextAlignmentLeft;
        sectionT.textColor = [UIColor lightGrayColor];
        sectionT.font = [UIFont systemFontOfSize:12];
        sectionT.adjustsFontSizeToFitWidth = YES;
        [sectionV addSubview:sectionT];
        
        NSArray *tittA = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        for (int i = 0; i<10; i++)
        {
            int row = i%5;
            int lie = i/5;
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame = CGRectMake(50+(ballH+10)*row, (ballH+10)*lie, ballH, ballH);
            [addBtn setTitle:tittA[i] forState:(UIControlStateNormal)];
            [addBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
            [addBtn addTarget:self action:@selector(sectionClick:) forControlEvents:(UIControlEventTouchUpInside)];
            addBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            addBtn.tag = i;
            addBtn.backgroundColor = [UIColor whiteColor];
            addBtn.clipsToBounds = YES;
            addBtn.layer.cornerRadius = ballH/2;
            [addBtn.layer setBorderWidth:0.5];
            [addBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
            [sectionV addSubview:addBtn];
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"============%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > 0 && _recordIndex == 0)
    {
        _recordIndex ++;
        scrollView.scrollEnabled = NO;
        [scrollView setContentOffset:CGPointZero animated:NO];
        self.topTitle.text = @"下拉查看最近开奖记录";
        [UIView animateWithDuration:0.5 animations:^{
            _bgV.frame = CGRectMake(0, 30, kMainWidth, kMainHeight-64-30-44);
            scrollView.scrollEnabled = YES;
        } completion:^(BOOL finished) {
            
        }];
    }

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  //NSLog(@"22222============%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y == 0)
    {
        _recordIndex = 0;
        self.topTitle.text = @"上拉收起内容";
        [UIView animateWithDuration:0.5 animations:^{
            _bgV.frame = CGRectMake(0, 160, kMainWidth, kMainHeight-64-30-44);
        }];
    }
}

-(NSString *)getSeletedBall
{
    NSString *str1=@"";
    for (UIView *sectionV in _sectionV.subviews)
    {
        for (UIView *view in sectionV.subviews)
        {
            if (view.tag != 110)
            {
                UIButton *btn = (UIButton *)view;
                if (btn.selected)
                {
                    str1 = [str1 stringByAppendingString:[NSString stringWithFormat:@"%@,",btn.titleLabel.text]];
                }
            }
        }
        
    }
    return str1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
