//
//  b3ViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/9.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b3ViewController.h"

@interface b3ViewController ()
{
    UIView *_topView;
    UIView *_bgV;
    UIView *_bgV1;
    UIView *_bgV2;
    UILabel *_chooselabel;
    NSInteger _recordRedCount;
    NSInteger _recordBlueCount;
    BOOL _isHaveBall;
    UIButton *cleanBtn;
    NSMutableArray *_blueBallArray;
    NSMutableArray  *_dataArray;
    long total;
}
@end

@implementation b3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isHaveBall = NO;
    _recordBlueCount = 0;
    _recordRedCount= 0;
    _dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    self.title = @"普通投注";
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    [addBtn setImage:[UIImage imageNamed:@"列表"] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    addBtn.tag = 0;
    addBtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    [self mainViewCreate];
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
    for (int i = 0; i<_topView.subviews.count; i++)
    {
        UILabel *label = _topView.subviews[i];
        if (label.tag != 110)
        {
            b2Model *model = _dataArray[label.tag];
            NSString *str = [model.drawNumber stringByReplacingOccurrencesOfString:@"," withString:@" "];
            NSString *str1 = [str stringByReplacingOccurrencesOfString:@"#" withString:@" "];
            NSString *str3 = [NSString stringWithFormat:@"%@期               %@",model.issue,str1];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str3];
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor lightGrayColor]
                                     range:NSMakeRange(0,model.issue.length+1)];
            
            
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor hexStringToColor:KNavBarHexColor]
                                     range:NSMakeRange(str3.length-str1.length,str1.length-5)];
            
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor blueColor]
                                     range:NSMakeRange(str3.length-5,5)];
            label.attributedText = attributedString;
            
        }
    }
}

-(void)upSwipeclick:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp)
    {
        self.topTitle.text = @"下拉查看最近开奖记录";
        [UIView animateWithDuration:0.5 animations:^{
            _bgV.frame = CGRectMake(0, 30, kMainWidth, kMainHeight-64-30-44);
        }];
    }
    else
    {
        self.topTitle.text = @"上拉收起内容";
        [UIView animateWithDuration:0.5 animations:^{
            _bgV.frame = CGRectMake(0, 160, kMainWidth, kMainHeight-64-30-44);
        }];
    }
}

-(void)mainViewCreate
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, 130)];
    _topView.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [self.view addSubview:_topView];
    
    UILabel *_toptitle = [[UILabel alloc]initWithFrame:CGRectMake(-20, 0, kMainWidth, 30)];
    _toptitle.text = @"期号               开奖号";
    _toptitle.tag = 110;
    _toptitle.textColor = [UIColor blackColor];
    _toptitle.textAlignment = NSTextAlignmentCenter;
    _toptitle.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:_toptitle];
    
    for (int i = 0; i<5; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+20*i, kMainWidth, 20)];
        label.tag = i;
        label.backgroundColor = (i%2==0)?[UIColor whiteColor]:[UIColor hexStringToColor:@"f4f4f4"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        
        
        [_topView addSubview:label];
    }
    
    
    _bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, kMainHeight-64-30-44)];
    _bgV.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [self.view addSubview:_bgV];
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipeclick:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [_bgV addGestureRecognizer:upSwipe];
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipeclick:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_bgV addGestureRecognizer:downSwipe];
    
    
    UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 40)];
    _title.text = @"  前区(至少选5个)";
    _title.textColor = [UIColor blackColor];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.font = [UIFont systemFontOfSize:14];
    _title.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [_bgV addSubview:_title];
    
    _bgV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kMainWidth, (kMainWidth/29)*15+6*(kMainWidth/58))];
    _bgV1.backgroundColor = [UIColor whiteColor];
    [_bgV addSubview:_bgV1];
    
    NSArray *titA = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35"];
    for (int i = 0; i<35; i++)
    {
        int row = i%7;
        int lie = i/7;
        int width = (kMainWidth/29)*3;
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(width/3+(width + width/3)*row, width/6+(width+width/6)*lie, width, width);
        [addBtn setTitle:titA[i] forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(SectionOneClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.tag = i;
        addBtn.backgroundColor = [UIColor whiteColor];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        addBtn.clipsToBounds = YES;
        addBtn.layer.cornerRadius = width/2;
        [addBtn.layer setBorderWidth:0.5];
        [addBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [_bgV1 addSubview:addBtn];
        
    }
    
    UILabel *_title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgV1.frame), kMainWidth, 40)];
    _title2.text = @"  后区(至少选2个)";
    _title2.textColor = [UIColor blackColor];
    _title2.textAlignment = NSTextAlignmentLeft;
    _title2.font = [UIFont systemFontOfSize:14];
    _title2.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [_bgV addSubview:_title2];
    
    _bgV2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_title2.frame), kMainWidth, (kMainWidth/29)*6+3*(kMainWidth/58))];
    _bgV2.backgroundColor = [UIColor whiteColor];
    [_bgV addSubview:_bgV2];
    
    NSArray *titA2 = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    _blueBallArray = [titA2 mutableCopy];
    for (int i = 0; i<12; i++)
    {
        int row = i%7;
        int lie = i/7;
        int width = (kMainWidth/29)*3;
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(width/3+(width + width/3)*row, width/6+(width+width/6)*lie, width, width);
        [addBtn setTitle:titA2[i] forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(SectionTwoClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.tag = i;
        addBtn.backgroundColor = [UIColor whiteColor];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        addBtn.clipsToBounds = YES;
        addBtn.layer.cornerRadius = width/2;
        [addBtn.layer setBorderWidth:0.5];
        [addBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [_bgV2 addSubview:addBtn];
    }
    
    UIView *_bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kMainHeight-44-64, kMainWidth, 44)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBtn.frame = CGRectMake(0, 0, 60, 44);
    [cleanBtn setTitle:@"机选" forState:(UIControlStateNormal)];
    [cleanBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
    cleanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cleanBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cleanBtn.tag = 1;
    cleanBtn.backgroundColor = [UIColor clearColor];
    [cleanBtn addtionVarticalLineWithSross:0.5 withLeft:60 withColor:[UIColor lightGrayColor]];
    [_bottomView addSubview:cleanBtn];
    
    
    _chooselabel = [UILabel new];
    _chooselabel.frame = CGRectMake(60, 0, kMainWidth-120, 44);
    _chooselabel.text = @"至少选择5个红球和2个蓝球";
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

//红球点击
-(void)SectionOneClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    if (sender.selected)
    {
        _recordRedCount ++;
        [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        sender.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
        [sender.layer setBorderColor:[[UIColor hexStringToColor:KNavBarHexColor] CGColor]];
    }else
    {
        _recordRedCount --;
        [sender setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
        sender.backgroundColor = [UIColor whiteColor];
        [sender.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    }
    
    [self bollSetting];
    
}

//蓝球点击
-(void)SectionTwoClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    if (sender.selected)
    {
        _recordBlueCount ++;
        [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        sender.backgroundColor = [UIColor blueColor];
        [sender.layer setBorderColor:[[UIColor blueColor] CGColor]];
    }else
    {
        _recordBlueCount --;
        [sender setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        sender.backgroundColor = [UIColor whiteColor];
        [sender.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    }
    
    [self bollSetting];
    
}

-(void)bollSetting
{
    if (_recordRedCount < 5 || _recordBlueCount < 2) {
        [cleanBtn setTitle:@"机选" forState:(UIControlStateNormal)];
        _chooselabel.textColor = [UIColor hexStringToColor:KNavBarHexColor];
        _chooselabel.text = @"至少选择5个红球和2个蓝球";
        _isHaveBall = NO;
        return;
    }
    [cleanBtn setTitle:@"清空" forState:(UIControlStateNormal)];
    _isHaveBall = YES;
    int red1 = 1;
    int red2 = 1;
    for (int i = 1; i<_recordRedCount+1; i++) {
        red1 = red1*i;
    }
    for (int i = 1; i<_recordRedCount-4; i++) {
        red2 = red2*i;
    }
    int blue1 = 1;
    int blue2 = 1;
    for (int i = 1; i<_recordBlueCount+1; i++) {
        blue1 = blue1*i;
    }
    for (int i = 1; i<_recordBlueCount-1; i++) {
        blue2 = blue2*i;
    }
    
     total = (red1/(red2*120))*(blue1/(blue2*2));
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
                    url = @"http://client.leaicai.com//news/10026.htm?requestType=1&version=1.0.3&appVersion=1";
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
            if ([sender.titleLabel.text isEqualToString:@"清空"])
            {
                [sender setTitle:@"机选" forState:(UIControlStateNormal)];
                [self cleanSelected];
            }else
            {
                NSArray *titA = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35"];
                NSArray *titA2 = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
                NSMutableArray *arcArr = [NSMutableArray array];
                NSMutableArray *arcArr2 = [NSMutableArray array];
                while (1)
                {
                    int arc  = arc4random()%34;
                    if (![arcArr containsObject:titA[arc]])
                    {
                        [arcArr addObject:titA[arc]];
                    }
                    if (arcArr.count == 5) {
                        break;
                    }
                }
                
                for (int i = 0; i<5; i++)
                {
                    UIButton *btn = _bgV1.subviews[[arcArr[i] integerValue]];
                    [self SectionOneClick:btn];
                }
                
                while (1)
                {
                    int arc  = arc4random()%11;
                    if (![arcArr2 containsObject:titA2[arc]])
                    {
                        [arcArr2 addObject:titA2[arc]];
                    }
                    if (arcArr2.count == 2) {
                        break;
                    }
                }
                
                for (int i = 0; i<2; i++)
                {
                    UIButton *btn = _bgV2.subviews[[arcArr2[i] integerValue]];
                    [self SectionTwoClick:btn];
                }

            }
            
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
                        if (_recordRedCount>5 || _recordBlueCount>2) {
                            model.types = @"复式投注";
                        }else
                        {
                            model.types = @"单式投注";
                        }
                        
                        OrderViewController *orderVc = [[OrderViewController alloc]init];
                        orderVc.title = @"大乐透-普通投注";
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
    _recordRedCount = 0;
    _recordBlueCount = 0;
    for (UIButton *sender in _bgV1.subviews)
    {
        [sender setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
        sender.selected = NO;
        sender.backgroundColor = [UIColor whiteColor];
        [sender.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    }
    for (UIButton *sender in _bgV2.subviews)
    {
        [sender setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
        sender.selected = NO;
        sender.backgroundColor = [UIColor whiteColor];
        [sender.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    }
    _chooselabel.textColor = [UIColor hexStringToColor:KNavBarHexColor];
    _chooselabel.text = @"至少选择5个红球和2个蓝球";
    _isHaveBall = NO;
}

-(NSString *)getSeletedBall
{
    NSString *str1=@"",*str2=@"#";
    
    for (UIButton *sender in _bgV1.subviews)
    {
        if (sender.selected)
        {
            str1 = [str1 stringByAppendingString:[NSString stringWithFormat:@"%@,",sender.titleLabel.text]];
        }
    }
    for (UIButton *sender in _bgV2.subviews)
    {
        if (sender.selected)
        {
            str2 = [str2 stringByAppendingString:[NSString stringWithFormat:@"%@,",sender.titleLabel.text]];
        }
    }
    return [str1 stringByAppendingString:str2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
