//
//  MLoginView.m
//  DynamicPicture
//
//  Created by TNP on 17/3/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "MLoginView.h"
#import "DPHttpTool.h"
@interface MLoginView()
{
    UIView *_view;
    BOOL _keyBoardIsHidden;
    UITextField *phoneField;
    UITextField *validationField;
}
@end
@implementation MLoginView

-(void)show
{
  [[[UIApplication sharedApplication].delegate window]addSubview:self];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardhidden) name:UIKeyboardDidHideNotification object:nil];
        
        UITapGestureRecognizer *tapSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelfAction)];
        [self addGestureRecognizer:tapSelf];
        
        self.bounds = CGRectMake(0, 0, kMainWidth, kMainHeight);
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 532/2, 514/2)];
        _view.backgroundColor = [UIColor whiteColor];
        _view.center = self.center;
        _view.clipsToBounds = YES;
        _view.layer.cornerRadius = 13;
        [self addSubview:_view];
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _view.width, 44)];
        title.text = @"登录";
        title.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
        title.font = [UIFont systemFontOfSize:18];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [_view addSubview:title];
        
        UILabel *phoneLine = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(title.frame)+60, _view.width-40, 1)];
        phoneLine.backgroundColor = [UIColor hexStringToColor:@"E3E3E3"];
        [_view addSubview:phoneLine];
        
        phoneField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(title.frame)+60/2, _view.width-40, 30)];
        phoneField.placeholder = @"请输入手机号";
        phoneField.keyboardType = UIKeyboardTypeNumberPad;
        [_view addSubview:phoneField];

        UILabel *validationLine = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(phoneLine.frame)+108/2, _view.width-40, 1)];
       validationLine.backgroundColor = [UIColor hexStringToColor:@"E3E3E3"];
        [_view addSubview:validationLine];
        
        validationField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(phoneLine.frame)+42/2, _view.width/2, 30)];
        validationField.placeholder = @"请输入验证码";
        validationField.keyboardType = UIKeyboardTypeNumberPad;
        [_view addSubview:validationField];
        
        UIButton *sendMarkBtn = [[UIButton alloc]initWithFrame:CGRectMake(_view.width-90, CGRectGetMaxY(phoneLine.frame)+12, 70, 30)];
        [sendMarkBtn addTarget:self action:@selector(senderMarkClick:) forControlEvents:(UIControlEventTouchUpInside)];
        sendMarkBtn.tag = 110;
        sendMarkBtn.clipsToBounds = YES;
        sendMarkBtn.layer.cornerRadius = 4;
        sendMarkBtn.backgroundColor = [UIColor hexStringToColor:@"E3E3E3"];
        [sendMarkBtn setTitle:@"发送验证码" forState:(UIControlStateNormal)];
        [sendMarkBtn setTitleColor:[UIColor hexStringToColor:@"666666"] forState:(UIControlStateNormal)];
        sendMarkBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_view addSubview:sendMarkBtn];
    
        NSArray *tit = @[@"取消",@"登录"];
        for (int i = 0; i<2; i++)
        {
            UIButton *yesOrNoBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+(90+46)*i, CGRectGetMaxY(validationLine.frame)+30, 90, 35)];
            [yesOrNoBtn setTitle:tit[i] forState:UIControlStateNormal];
            yesOrNoBtn.tag = 100+i;
            [yesOrNoBtn addTarget:self action:@selector(senderMarkClick:) forControlEvents:(UIControlEventTouchUpInside)];
            yesOrNoBtn.backgroundColor = i==0?[UIColor whiteColor]:[UIColor hexStringToColor:KNavBarHexColor];
            yesOrNoBtn.clipsToBounds = YES;
            yesOrNoBtn.layer.cornerRadius = 6;
            yesOrNoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [yesOrNoBtn setTitleColor:i==0?[UIColor blackColor]:[UIColor whiteColor] forState:(UIControlStateNormal)];
            if (i==0)
            {
                [yesOrNoBtn.layer setBorderWidth:0.5];
                [yesOrNoBtn.layer setBorderColor:[[UIColor hexStringToColor:@"999999"] CGColor]];
            }
            [_view addSubview:yesOrNoBtn];
        }
        
 
    }
    return self;
}

-(void)senderMarkClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 110:
        {
            //发送验证码....
            if ([phoneField.text isEqualToString:@""] || phoneField.text.length<1)
            return;
            [DPHttpTool postSenderMarkWithPhone:phoneField.text isSenderMark:YES success:^(NSURLSessionDataTask *task, id result)
             {
                NSLog(@"result=======%@",result);
                 if ([result[@"ret"] intValue]==200) {
                     sender.userInteractionEnabled = NO;
                  [sender setTitle:@"已发送" forState:(UIControlStateNormal)];
                 }
                 [MBProgressHUD showSuccess:result[@"msg"]];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"error=======%@",error);
            }];
        }
            break;
        case 100:
        {
            //取消
            
            if (self.cancelLoginBlock)
            {
                self.cancelLoginBlock();
                [self removeFromSuperview];
            }
        }
            break;
        case 101:
        {
            
            //登录
            if (self.loginBlock)
            {
                //__weak typeof(self) weakSelf = self;
                if ([phoneField.text isEqualToString:@""] || phoneField.text.length<1 || [validationField.text isEqualToString:@""] || validationField.text.length<1)
                {
                    [MBProgressHUD showError:@"请填写完整信息"];
                    return;
                }
                [DPHttpTool postUserLoginWithPhone:phoneField.text Mark:validationField.text success:^(NSURLSessionDataTask *task, id result) {
                    NSLog(@"logresult=======%@",result);
                    if ([result[@"ret"] integerValue]==200) {
                        NSArray *dataArr = result[@"data"];
                        NSDictionary *dict = [dataArr firstObject];
                        [M_Tool saveUserInfo:dict];
                        self.loginBlock(YES);
                        [self removeFromSuperview];
                    }else if ([result[@"ret"] integerValue]==423)
                    {
                        [MBProgressHUD showError:@"验证码错误!"];
                    }
                    else if ([result[@"ret"] integerValue]==424)
                    {
                        [MBProgressHUD showError:@"验证码已过期!"];
                    }
                    else
                    {
                      [MBProgressHUD showError:@"输入信息有误!"];
                    }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    self.loginBlock(NO);
                    [self removeFromSuperview];
                     NSLog(@"logresulterror=======%@",error);
                }];
                
                
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)tapSelfAction
{
    [self endEditing:YES];
}

-(void)keyboardShow
{
    _keyBoardIsHidden = YES;
}

-(void)keyboardhidden
{
    _keyBoardIsHidden = NO;
}
@end



//加入会员View ************************************
@interface PayView()
{
    UIView *_view;
    BOOL _keyBoardIsHidden;
    UILabel *_types;
    UIButton *_payBtnType1;
    UIButton *_payBtnType2;
}
@end
@implementation PayView

-(void)show
{
    [[[UIApplication sharedApplication].delegate window]addSubview:self];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UITapGestureRecognizer *tapSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelfAction)];
        [self addGestureRecognizer:tapSelf];
        
        self.bounds = CGRectMake(0, 0, kMainWidth, kMainHeight);
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 532/2, 514/2-40)];
        _view.backgroundColor = [UIColor whiteColor];
        _view.center = self.center;
        _view.clipsToBounds = YES;
        _view.layer.cornerRadius = 13;
        [self addSubview:_view];
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _view.width, 44)];
        title.text = @"加入会员";
        title.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
        title.font = [UIFont systemFontOfSize:18];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [_view addSubview:title];
        
        _types = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame)+20, _view.width, 15)];
        
        _types.font = [UIFont systemFontOfSize:14];
        _types.textAlignment = NSTextAlignmentCenter;
        [_view addSubview:_types];
        
 
        _payBtnType1 = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_types.frame)+20, 105, 20)];
        [_payBtnType1 addTarget:self action:@selector(payBtnType1:) forControlEvents:(UIControlEventTouchUpInside)];
        _payBtnType1.tag = 110;
        [_payBtnType1 setImage:[UIImage imageNamed:@"btn_unselected"] forState:(UIControlStateNormal)];
        [_payBtnType1 setImage:[UIImage imageNamed:@"btn_selected"] forState:(UIControlStateSelected)];
        _payBtnType1.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_payBtnType1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_payBtnType1 setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateSelected)];
        _payBtnType1.titleLabel.font = [UIFont systemFontOfSize:15];
        [_view addSubview:_payBtnType1];
        
        _payBtnType2 = [[UIButton alloc]initWithFrame:CGRectMake(_view.width-125, CGRectGetMaxY(_types.frame)+20, 105, 20)];
        [_payBtnType2 addTarget:self action:@selector(payBtnType1:) forControlEvents:(UIControlEventTouchUpInside)];
        _payBtnType2.tag = 120;
        [_payBtnType2 setImage:[UIImage imageNamed:@"btn_unselected"] forState:(UIControlStateNormal)];
        [_payBtnType2 setImage:[UIImage imageNamed:@"btn_selected"] forState:(UIControlStateSelected)];
        _payBtnType2.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_payBtnType2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_payBtnType2 setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateSelected)];
        _payBtnType2.titleLabel.font = [UIFont systemFontOfSize:15];
        [_view addSubview:_payBtnType2];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(title.frame)+188/2, _view.width-40, 1)];
        line.backgroundColor = [UIColor hexStringToColor:@"E3E3E3"];
        [_view addSubview:line];
        
        NSArray *tit = @[@"取消",@"确定"];
        for (int i = 0; i<2; i++)
        {
            UIButton *yesOrNoBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+(90+46)*i, CGRectGetMaxY(line.frame)+20, 90, 35)];
            [yesOrNoBtn setTitle:tit[i] forState:UIControlStateNormal];
            yesOrNoBtn.tag = 100+i;
            [yesOrNoBtn addTarget:self action:@selector(payBtnType1:) forControlEvents:(UIControlEventTouchUpInside)];
            yesOrNoBtn.backgroundColor = i==0?[UIColor whiteColor]:[UIColor hexStringToColor:KNavBarHexColor];
            yesOrNoBtn.clipsToBounds = YES;
            yesOrNoBtn.layer.cornerRadius = 6;
            yesOrNoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [yesOrNoBtn setTitleColor:i==0?[UIColor blackColor]:[UIColor whiteColor] forState:(UIControlStateNormal)];
            if (i==0)
            {
                [yesOrNoBtn.layer setBorderWidth:0.5];
                [yesOrNoBtn.layer setBorderColor:[[UIColor hexStringToColor:@"999999"] CGColor]];
            }
            [_view addSubview:yesOrNoBtn];
        }
        
        
    }
    return self;
}
-(void)tapSelfAction
{
    [self removeFromSuperview];
}
-(void)setType:(BOOL)type
{
    _type = type;
    [_payBtnType2 setTitle:_type?@"支付宝支付":@"包年(￥50)" forState:(UIControlStateNormal)];
    [_payBtnType1 setTitle:_type?@"微信支付":@"包月(￥8)" forState:(UIControlStateNormal)];
    _types.text = _type?@"请选择支付方式。":@"请选择加入的会员类型。";
}
-(void)payBtnType1:(UIButton *)sender
{
    NSLog(@"%d===%d",_payBtnType1.selected,_payBtnType2.selected);
    switch (sender.tag)
    {
        case 110:
        {
            //包月(￥8)
            sender.selected = YES;
            UIButton *otherBtn = [_view viewWithTag:120];
            otherBtn.selected = NO;
        }
            break;
        case 120:
        {
            //包年(￥50)
            sender.selected = YES;
            UIButton *otherBtn = [_view viewWithTag:110];
            otherBtn.selected = NO;
        }
            break;

        case 100:
        {
            //取消
            [self removeFromSuperview];
        }
            break;
        case 101:
        {
            //确定
            if (self.chooseTypeBlock)
            {

                if (_payBtnType1.selected || _payBtnType2.selected) {
                    
                    if (_payBtnType1.selected) {
                        //包月
                      self.chooseTypeBlock(@"0");
                    }else
                    {
                        //包年
                       self.chooseTypeBlock(@"1");
                    }
                    [self removeFromSuperview];
                }
            }
        }
            break;
            
        default:
            break;
    }
}



@end


//简单提示View ************************************
@interface AlertViewSimp()
{
    UIView *_view;
    UIButton *_payBtnType1;
    UIButton *_payBtnType2;
}
@end
@implementation AlertViewSimp

-(void)show
{
    [[[UIApplication sharedApplication].delegate window]addSubview:self];
}

-(id)initWithTitle:(NSString *)title tips:(NSString *)tip buttonT1:(NSString *)t1 buttonT2:(NSString *)t2
{
    if (self = [super init])
    {
        
        UITapGestureRecognizer *tapSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelfAction)];
        [self addGestureRecognizer:tapSelf];
        self.frame = CGRectMake(0, 0, kMainWidth, kMainHeight);
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 532/2, 180)];
        _view.backgroundColor = [UIColor whiteColor];
        _view.center = self.center;
        _view.clipsToBounds = YES;
        _view.layer.cornerRadius = 13;
        [self addSubview:_view];
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _view.width, 44)];
        titles.text = title;
        titles.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
        titles.font = [UIFont systemFontOfSize:18];
        titles.textColor = [UIColor whiteColor];
        titles.textAlignment = NSTextAlignmentCenter;
        [_view addSubview:titles];
        
       UILabel *_types = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titles.frame)+30, _view.width, 15)];
        _types.text = tip;
        _types.adjustsFontSizeToFitWidth = YES;
        _types.font = [UIFont systemFontOfSize:17];
        _types.textAlignment = NSTextAlignmentCenter;
        [_view addSubview:_types];
        
        NSArray *tit = @[t1,t2];
        for (int i = 0; i<2; i++)
        {
            UIButton *yesOrNoBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+(90+46)*i, CGRectGetMaxY(_types.frame)+30, 90, 35)];
            [yesOrNoBtn setTitle:tit[i] forState:UIControlStateNormal];
            yesOrNoBtn.tag = 100+i;
            [yesOrNoBtn addTarget:self action:@selector(payBtnType1:) forControlEvents:(UIControlEventTouchUpInside)];
            yesOrNoBtn.backgroundColor = i==0?[UIColor whiteColor]:[UIColor hexStringToColor:KNavBarHexColor];
            yesOrNoBtn.clipsToBounds = YES;
            yesOrNoBtn.layer.cornerRadius = 6;
            yesOrNoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [yesOrNoBtn setTitleColor:i==0?[UIColor blackColor]:[UIColor whiteColor] forState:(UIControlStateNormal)];
            if (i==0)
            {
                [yesOrNoBtn.layer setBorderWidth:0.5];
                [yesOrNoBtn.layer setBorderColor:[[UIColor hexStringToColor:@"999999"] CGColor]];
            }
            [_view addSubview:yesOrNoBtn];
        }

    }
    return self;
}
-(void)payBtnType1:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
          //取消//会员中心
            if (_userEnter)
            {
                
            }
        }
            break;
        case 101:
        {
            if (self.sureblock)
            {
                self.sureblock();
            }
        }
            break;
        default:
            break;
    }
    [self removeFromSuperview];
}

-(void)tapSelfAction
{
  [self removeFromSuperview];
}
@end

//修改昵称View ************************************
@interface ChangeNmaeView()
{
    UIView *_view;
    UITextField *_inputField;
}
@end
@implementation ChangeNmaeView

-(void)show
{
    [[[UIApplication sharedApplication].delegate window]addSubview:self];
}

-(id)init
{
    if (self = [super init])
    {
        UITapGestureRecognizer *tapSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelfAction)];
        [self addGestureRecognizer:tapSelf];
        self.frame = CGRectMake(0, 0, kMainWidth, kMainHeight);
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 532/2, 180)];
        _view.backgroundColor = [UIColor whiteColor];
        _view.center = self.center;
        _view.clipsToBounds = YES;
        _view.layer.cornerRadius = 13;
        [self addSubview:_view];
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _view.width, 44)];
        titles.text = @"修改昵称";
        titles.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
        titles.font = [UIFont systemFontOfSize:18];
        titles.textColor = [UIColor whiteColor];
        titles.textAlignment = NSTextAlignmentCenter;
        [_view addSubview:titles];
        
        
        _inputField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titles.frame)+20, _view.width-40, 35)];
        [_inputField.layer setBorderWidth:0.5];
        [_inputField.layer setBorderColor:[[UIColor hexStringToColor:@"999999"] CGColor]];
        [_view addSubview:_inputField];
        
        NSArray *tit = @[@"取消",@"保存"];
        for (int i = 0; i<2; i++)
        {
            UIButton *yesOrNoBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+(90+46)*i, CGRectGetMaxY(_inputField.frame)+20, 90, 35)];
            [yesOrNoBtn setTitle:tit[i] forState:UIControlStateNormal];
            yesOrNoBtn.tag = 100+i;
            [yesOrNoBtn addTarget:self action:@selector(payBtnType1:) forControlEvents:(UIControlEventTouchUpInside)];
            yesOrNoBtn.backgroundColor = i==0?[UIColor whiteColor]:[UIColor hexStringToColor:KNavBarHexColor];
            yesOrNoBtn.clipsToBounds = YES;
            yesOrNoBtn.layer.cornerRadius = 6;
            yesOrNoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [yesOrNoBtn setTitleColor:i==0?[UIColor blackColor]:[UIColor whiteColor] forState:(UIControlStateNormal)];
            if (i==0)
            {
                [yesOrNoBtn.layer setBorderWidth:0.5];
                [yesOrNoBtn.layer setBorderColor:[[UIColor hexStringToColor:@"999999"] CGColor]];
            }
            [_view addSubview:yesOrNoBtn];
        }

    }
    return self;
}

-(void)payBtnType1:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 100:
        {
            //取消
            [self removeFromSuperview];
        }
            break;
        case 101:
        {
            //保存
            if (self.saveNameBlock && _inputField.text.length)
            {
                self.saveNameBlock(_inputField.text);
                [self removeFromSuperview];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)tapSelfAction
{
    [self endEditing:YES];
}

@end
