//
//  b15ViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/18.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b15ViewController.h"

@interface b15ViewController ()<UIScrollViewDelegate>
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
    NSArray *_numberArray;
    NSArray *_leftTArray;
    NSUInteger *_contentOffY;
    long total;
}
@end

@implementation b15ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _recordIndex = 0;
    _contentOffY = 0;
    _isHaveBall = NO;
    _titArray = @[@"二星组选",@"三星组三",@"三星组六",@"一星",@"五星",@"五星通选",@"二星直选",@"三星直选"];
    _tipArray = @[@"  至少选择2个号码",@"  至少选择2个号码",@"  至少选择3个号码",@"  每位至少选择1个号码",@"  每位至少选择1个号码",@"  每位至少选择1个号码",@"  每位至少选择1个号码",@"  每位至少选择1个号码"];
    _numberArray = @[@"1",@"1",@"1",@"1",@"5",@"5",@"2",@"3"];
    _leftTArray = @[@[@"  选号"],@[@"  选号"],@[@"  选号"],@[@"  选号"],@[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位"],@[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位"],@[@"第四位",@"第五位"],@[@"第三位",@"第四位",@"第五位"]];
    [self createTitleView];
    [self createtMainView];
    _topT.text = _tipArray[_recordIndex];
    [MNetworkManager getBuyDataWithUrl:self.dataUrl Success:^(id data)
     {
         _dataArray = [b2Model mj_objectArrayWithKeyValuesArray:data];
         [self dataRolad];
     } failure:^(NSError *error)
     {
         NSLog(@"error==========%@",error);
     }];
}
-(void)createTitleView
{
    _isSelected = NO;
    _titleView = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 150, 24)];
    _titleView.backgroundColor = [UIColor clearColor];
    [_titleView setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_titleView addTarget:self action:@selector(titleViewClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_titleView setImage:[[UIImage imageNamed:@"jiantou"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
    [_titleView setTitle:_titArray[_recordIndex] forState:(UIControlStateNormal)];
    self.navigationItem.titleView = _titleView;
    
}

-(void)titleViewClick:(UIButton *)sender
{
    
    _isSelected = !_isSelected;
    if (_isSelected)
    {
        [sender setTitle:_titArray[_recordIndex] forState:(UIControlStateNormal)];
        [sender setImage:[[UIImage imageNamed:@"jiantou_1"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [self coreateSelecteView];
    }else
    {
        [sender setTitle:_titArray[_recordIndex] forState:(UIControlStateNormal)];
        [sender setImage:[[UIImage imageNamed:@"jiantou"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [UIView animateWithDuration:1 animations:^{
            _topView.superview.alpha = 0;
        } completion:^(BOOL finished) {
            [_topView.superview removeFromSuperview];
        }];
    }
}

-(void)coreateSelecteView
{
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight-64)];
    bgV.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:bgV];
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 125)];
    _topView.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [bgV addSubview:_topView];
    
    for (int i = 0; i<8; i++)
    {
        int row = i%3;
        int lie = i/3;
        int with = (kMainWidth-50)/3;
        int height = 30;
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(10+(with+15)*row, 10+(height+10)*lie, with, height);
        [addBtn setTitle:_titArray[i] forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(topSeletedClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.tag = i;
        addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        addBtn.backgroundColor = [UIColor whiteColor];
        addBtn.clipsToBounds = YES;
        addBtn.layer.cornerRadius = 5;
        [addBtn.layer setBorderWidth:0.5];
        [addBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [_topView addSubview:addBtn];
        if (i==_recordIndex) {
            addBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
            [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [addBtn.layer setBorderColor:[[UIColor hexStringToColor:KNavBarHexColor] CGColor]];
        }
    }
    
}

-(void)topSeletedClick:(UIButton *)sender
{
    _isHaveBall = NO;
    _recordIndex = sender.tag;
    _isSelected = NO;
    _topT.text = _tipArray[sender.tag];
    [_titleView setTitle:_titArray[_recordIndex] forState:(UIControlStateNormal)];
    [_titleView setImage:[[UIImage imageNamed:@"jiantou"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
    [UIView animateWithDuration:1 animations:^{
        sender.superview.superview.alpha = 0;
    } completion:^(BOOL finished) {
        [sender.superview.superview removeFromSuperview];
    }];
    _chooselabel.text = @"已选0投注，共0元";
    _chooselabel.textColor = [UIColor hexStringToColor:KNavBarHexColor];
    
    [self section1];
    
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
    _bgV.contentSize = CGSizeMake(kMainWidth, 90*5+100);
    _bgV.pagingEnabled = NO;
    _bgV.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [self.view addSubview:_bgV];
  
    
    _topT = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
    _topT.textColor = [UIColor grayColor];
    _topT.textAlignment = NSTextAlignmentLeft;;
    _topT.font = [UIFont systemFontOfSize:15];
    _topT.backgroundColor = [UIColor clearColor];
    [_bgV addSubview:_topT];
    
    _sectionV = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, 90*5+100)];
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

-(void)section1
{
    [_sectionV removeAllSubviews];
    if (_recordIndex == 4 || _recordIndex == 5)
    {
        _bgV.contentSize = CGSizeMake(kMainWidth, 90*5+100);
    }
    else
    {
      _bgV.contentSize = CGSizeMake(kMainWidth, kMainHeight-64-30-43);
    }
    int ballH = 35;
    NSArray *sectiontA = _leftTArray[_recordIndex];
    int count = [_numberArray[_recordIndex] intValue];
    for (int s= 0; s<count; s++)
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
    switch (_recordIndex)
    {
        case 0:
        case 1:
        {
            int one = 0;
            for (UIView *sectionV in _sectionV.subviews)
            {
                for (UIView *view in sectionV.subviews)
                {
                    if (view.tag != 110)
                    {
                        UIButton *btn = (UIButton *)view;
                        if (btn.selected)
                        {
                            one++;
                        }
                    }
                }
            }
                int blue1 = 1;
                int blue2 = 1;
                for (int i = 1; i<one+1; i++) {
                    blue1 = blue1*i;
                }
                for (int i = 1; i<one-1; i++) {
                    blue2 = blue2*i;
                }
                
                total = blue1/(blue2*2);
        }
            break;
        case 2:
        {
            int one = 0;
            for (UIView *sectionV in _sectionV.subviews)
            {
                for (UIView *view in sectionV.subviews)
                {
                    if (view.tag != 110)
                    {
                        UIButton *btn = (UIButton *)view;
                        if (btn.selected)
                        {
                            one++;
                        }
                    }
                }
            }
            int blue1 = 1;
            int blue2 = 1;
            for (int i = 1; i<one+1; i++) {
                blue1 = blue1*i;
            }
            for (int i = 1; i<one-2; i++) {
                blue2 = blue2*i;
            }
            
             total = blue1/(blue2*6);
            
        }
        break;
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        {
           
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
            
        }
            break;
        default:
            break;
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
                    url = @"http://client.leaicai.com//news/10038.htm?requestType=1&version=1.0.3&appVersion=1";
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
            [self radomOne];
            
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
                        
                        model.types = _titArray[_recordIndex];
                        
                        OrderViewController *orderVc = [[OrderViewController alloc]init];
                        orderVc.title = [NSString stringWithFormat:@"时时彩-%@",_titArray[_recordIndex]];
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

-(void)radomOne
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"============%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > 0 && _contentOffY == 0)
    {
        _contentOffY ++;
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
        _contentOffY = 0;
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
