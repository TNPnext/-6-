//
//  b4ViewController.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/9.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b4ViewController.h"

@interface b4ViewController ()
{
    NSArray *_titArray;
    NSArray *_tipArray;
    UIView *_topView;
    UIView *_kTopView;
    NSInteger _recordIndex;
    BOOL  _isSelected;
    UIButton *_titleView;
    UIView *_fourBgV;
    UIView *_bgV;
    UILabel *_topT;
    NSMutableArray  *_dataArray;
    NSUInteger _isHaveBall;
}
@end

@implementation b4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isHaveBall = 0;
    _recordIndex = 0;
    _dataArray = [NSMutableArray array];
    _titArray = @[@"三不同号",@"二不同号",@"任意选号",@"猜对子",@"猜顺子",@"猜豹子"];
    _tipArray = @[@"猜中3个不同号码即中奖",@"猜中2个不同号码即中奖",@"任意智能组合你选的号码，加大中奖概率",@"猜中对子即中奖",@"只要开出顺子，奖金10元",@"猜中一个豹子号即中奖"];
    [self createTitleView];
    [self createtMainView];
    [self createFourButtonView];
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

    
    _bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, kMainHeight-64-30-44)];
    _bgV.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [self.view addSubview:_bgV];
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipeclick:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [_bgV addGestureRecognizer:upSwipe];
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipeclick:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_bgV addGestureRecognizer:downSwipe];
    
    _topT = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, kMainWidth, 30)];
    _topT.textColor = [UIColor blackColor];
    _topT.textAlignment = NSTextAlignmentCenter;
    _topT.font = [UIFont systemFontOfSize:15];
    _topT.backgroundColor = [UIColor clearColor];
    [_bgV addSubview:_topT];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0, kMainHeight-44-64, kMainWidth, 44);
    [sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sureBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    sureBtn.tag = 2;
    sureBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    [self.view addSubview:sureBtn];
}

-(void)upSwipeclick:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp)
    {
        self.topTitle.text = @"下拉查看最近开奖记录";
        [UIView animateWithDuration:0.5 animations:^{
            _bgV.frame = CGRectMake(0, 30, kMainWidth,kMainHeight-64-30-44);
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
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 90)];
    _topView.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    [bgV addSubview:_topView];
    
    for (int i = 0; i<6; i++)
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
    [_fourBgV removeFromSuperview];
    [self createFourButtonView];
    
}

-(void)addClick:(UIButton *)sender
{
    if (sender.tag == 0) {
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
                [MBProgressHUD showSuccess:@"暂无玩法介绍"];
                return ;
            }
            WebDetailViewController *web = [[WebDetailViewController alloc]init];
            web.url = url;
            web.titt = title;
            [self.navigationController pushViewController:web animated:YES];
        };

    }
   else if (sender.tag == 2)
    {
        if (_isHaveBall)
        {
            
            if ([M_Tool isLogin])
            {
                [MBProgressHUD showError:@"彩种维护中。。。" toView:self.view];
               
            }else
            {
               [MBProgressHUD showError:@"请先登录" toView:self.view];
            }
        }
    }else
    {
    _recordIndex = sender.tag;
    _isSelected = NO;
    [_titleView setTitle:_titArray[_recordIndex] forState:(UIControlStateNormal)];
    [_titleView setImage:[[UIImage imageNamed:@"jiantou"] tintColorWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
    [UIView animateWithDuration:1 animations:^{
        sender.superview.superview.alpha = 0;
    } completion:^(BOOL finished) {
        [sender.superview.superview removeFromSuperview];
    }];
    }
}

-(void)createFourButtonView
{
    if (_recordIndex ==0 ||_recordIndex ==1 || _recordIndex ==2) {
    int width = (kMainWidth-40)/3;
    _fourBgV = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_topT.frame)+5, kMainWidth-40, width*2)];
    _fourBgV.backgroundColor = [UIColor clearColor];
    [_bgV addSubview:_fourBgV];
    
    
    NSArray *tittA = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    for (int i = 0; i<6; i++)
    {
        int row = i%3;
        int lie = i/3;
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(width*row, width*lie, width, width);
        [addBtn setTitle:tittA[i] forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(contentClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        addBtn.tag = i;
        addBtn.backgroundColor = [UIColor whiteColor];
        [_fourBgV addSubview:addBtn];
    }

    [_fourBgV addtionUnderlineWithSross:0.5 withColor:[UIColor grayColor]];
    [_fourBgV addtionHorizontalLineWithSross:0.5 withTop:0 withColor:[UIColor grayColor]];
    [_fourBgV addtionHorizontalLineWithSross:0.5 withTop:width withColor:[UIColor grayColor]];
    
    
    [_fourBgV addtionVarticalLineWithSross:0.5 withLeft:0 withColor:[UIColor grayColor]];
    [_fourBgV addtionVarticalLineWithSross:0.5 withLeft:width withColor:[UIColor grayColor]];
    [_fourBgV addtionVarticalLineWithSross:0.5 withLeft:width*2 withColor:[UIColor grayColor]];
    [_fourBgV addtionVarticalLineWithSross:0.5 withLeft:width*3 withColor:[UIColor grayColor]];
    }else if (_recordIndex ==3 || _recordIndex ==5)
    {
        int width = (kMainWidth-20)/3;
        int hight = width/2;
        _fourBgV = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_topT.frame)+5, kMainWidth-20, hight*2)];
        _fourBgV.backgroundColor = [UIColor clearColor];
        [_bgV addSubview:_fourBgV];
        
        NSArray *tittA = @[@"11*",@"22*",@"33*",@"44*",@"55*",@"66*"];
        NSArray *tittA1 = @[@"111",@"222",@"333",@"444",@"555",@"666"];
        for (int i = 0; i<6; i++)
        {
            int row = i%3;
            int lie = i/3;
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame = CGRectMake(width*row, hight*lie, width, hight);
            [addBtn setTitle:(_recordIndex ==3)?tittA[i]:tittA1[i] forState:(UIControlStateNormal)];
            [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [addBtn addTarget:self action:@selector(contentClick:) forControlEvents:(UIControlEventTouchUpInside)];
            addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            addBtn.tag = i;
            addBtn.backgroundColor = [UIColor whiteColor];
            [_fourBgV addSubview:addBtn];
        }
        [_fourBgV addtionUnderlineWithSross:0.5 withColor:[UIColor grayColor]];
        [_fourBgV addtionHorizontalLineWithSross:0.5 withTop:0 withColor:[UIColor grayColor]];
        [_fourBgV addtionHorizontalLineWithSross:0.5 withTop:hight withColor:[UIColor grayColor]];
        
        
        [_fourBgV addtionVarticalLineWithSross:0.5 withLeft:0 withColor:[UIColor grayColor]];
        [_fourBgV addtionVarticalLineWithSross:0.5 withLeft:width withColor:[UIColor grayColor]];
        [_fourBgV addtionVarticalLineWithSross:0.5 withLeft:width*2 withColor:[UIColor grayColor]];
        [_fourBgV addtionVarticalLineWithSross:0.5 withLeft:width*3 withColor:[UIColor grayColor]];
        
    }else
    {
        _fourBgV = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_topT.frame)+5, kMainWidth-40, 44)];
        _fourBgV.backgroundColor = [UIColor clearColor];
        [_bgV addSubview:_fourBgV];
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(0, 0, kMainWidth-40, 44);
        [addBtn setTitle:@"123,234,345,456" forState:(UIControlStateNormal)];
        [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [addBtn addTarget:self action:@selector(contentClick:) forControlEvents:(UIControlEventTouchUpInside)];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [addBtn.layer setBorderWidth:0.5];
        [addBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        addBtn.backgroundColor = [UIColor whiteColor];
        [_fourBgV addSubview:addBtn];
    }
}

-(void)contentClick:(UIButton *)sender
{
   
    sender.selected = !sender.selected;
    
    if (sender.selected)
    {
        _isHaveBall++;
     [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
     sender.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    }else
    {
        _isHaveBall--;
        [sender setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        sender.backgroundColor = [UIColor whiteColor];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
