
//
//  LogInViewController.m
//  Jest
//
//  Created by 段振伟 on 16/4/19.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "LogInViewController.h"
#import "RegisterViewController.h"
#import "FindPassWordViewController.h"
#import "LoginTextField.h"
#import "TNPTool.h"
#import "M_Tool.h"
#import <UIImage+Extension.h>
#import "UserModel.h"
@interface LogInViewController ()
@property (nonatomic, weak) LoginTextField *userNameTextField;
@property (nonatomic, weak) LoginTextField *passwordTextField;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UIButton *forgetButton;
@property (nonatomic, weak) UIButton *loginButton;
@property (nonatomic, weak) UIButton *registerButton;
@property (nonatomic, weak) UILabel *fastLabel;
@property (nonatomic, weak) UIButton *qqLogin;
@property (nonatomic, weak) UIButton *wechatLogin;
@property (nonatomic, weak) UIButton *weiboLogin;
@end

@implementation LogInViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.userNameTextField.text = KOutStandDate(@"phoneTNP");
    //[self.tabBarController removeFromParentViewController];
    //*****************自动填写用户名密码****************
    //self.userNameTextField.text=@"17723117102";
    //self.passwordTextField.text=@"qwe123";
    //************************************************
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)]];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.frame = CGRectMake(0, -64, kMainWidth, kMainHeight - 64);
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[[UIImage imageNamed:@"btn_logIn_exit"] tintColorWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[[UIImage imageNamed:@"btn_logIn_exit"] tintColorWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    settingButton.frame = CGRectMake(0, 0, settingButton.currentBackgroundImage.size.width, settingButton.currentBackgroundImage.size.width);
    [settingButton addTarget:self action:@selector(clickSetting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    self.navigationItem.leftBarButtonItem = setting;
    
    [self setupInputTextField];
    [self setupForgetButton];
    [self setupLoginRegisterButton];
}
- (void)didTapView{
    [self.view endEditing:YES];
}
- (void)clickSetting
{
    
    [self pushLoginSuccess];
}
-(void)pushLoginSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setupInputTextField{
    CGFloat userNameY = 0;
    if (IS_IPHONE_4) {
        userNameY = 0 + 20;
    }else{
        userNameY = 0 + 50;
    }
    
    LoginTextField *userNameTextField = [[LoginTextField alloc] initWithFrame:CGRectMake(20, userNameY, kMainWidth - 2 * 20, 35)];
    userNameTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView *userImageView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"login_ico_account"] tintColorWithColor:[UIColor hexStringToColor:KNavBarHexColor]]];
    userNameTextField.leftView = userImageView;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    userNameTextField.placeholder = @"手机号";
    userNameTextField.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:userNameTextField];
    self.userNameTextField = userNameTextField;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userNameTextField.frame) + 5, kMainWidth - 2 * 20, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    self.line = line;
    
    LoginTextField *passwordTextField = [[LoginTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userNameTextField.frame) + 10, kMainWidth - 2 * 20, 35)];
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.secureTextEntry = YES;
//    passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    UIImageView *passwordImageView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"login_ico_key"] tintColorWithColor:[UIColor hexStringToColor:KNavBarHexColor]]];
    passwordTextField.leftView = passwordImageView;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"密码";
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passwordTextField.frame) + 5, kMainWidth - 2 * 20, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    self.line1 = line1;
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(25, CGRectGetMaxY(self.line1.frame) + 20, 20, 20);
    [checkBtn setImage:TImg(@"checked_agree") forState:(UIControlStateNormal)];
    //[checkBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    /** 我已同意 */
    UILabel *agreeLabel = [[UILabel alloc] init];
    agreeLabel.frame = CGRectMake(CGRectGetMaxX(checkBtn.frame)+5, CGRectGetMaxY(self.line1.frame) + 15, 60, 30);
    agreeLabel.text = @"我已同意";
    agreeLabel.textColor = [UIColor grayColor];
    agreeLabel.font = [UIFont systemFontOfSize:14];
    agreeLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:agreeLabel];
    
    /** 马桶段子协议 */
    UIButton *agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreementBtn.frame = CGRectMake(CGRectGetMaxX(agreeLabel.frame)-10, CGRectGetMaxY(self.line1.frame) + 15, 100, 30);
    agreementBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    agreementBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [agreementBtn setTitle:@"《服务协议》" forState:UIControlStateNormal];
    [agreementBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:UIControlStateNormal];
    //[agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreementBtn];
}

- (void)setupForgetButton{
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    NSMutableAttributedString *forget = [[NSMutableAttributedString alloc] initWithString:forgetButton.titleLabel.text];
    [forget addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, forget.length)];
    CGFloat maxForgetWidth = 100;
    CGRect forgetRect = [forget boundingRectWithSize:CGSizeMake(maxForgetWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    forgetButton.titleLabel.attributedText = forget;
    [forgetButton addTarget:self action:@selector(clickForgetButton) forControlEvents:UIControlEventTouchUpInside];
    CGFloat forgetH = 20;
    CGFloat forgetY = CGRectGetMaxY(self.line1.frame) + 20;
    CGFloat forgetW = forgetRect.size.width;
    CGFloat forgetX = kMainWidth - forgetW - 20;
    forgetButton.frame = CGRectMake(forgetX, forgetY, forgetW, forgetH);
    [self.view addSubview:forgetButton];
    self.forgetButton = forgetButton;
}
- (void)clickForgetButton{
    FindPassWordViewController *findPassword = [[FindPassWordViewController alloc] init];
    [self.navigationController pushViewController:findPassword animated:YES];
//    JLog(@"忘记密码");
}
- (void)setupLoginRegisterButton{
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    [login setTitle:@"登        录" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    login.titleLabel.font = [UIFont systemFontOfSize:17];
    login.layer.cornerRadius = 5.0f;
    login.clipsToBounds = YES;
    CGFloat loginX = 20;
    CGFloat loginW = self.view.frame.size.width - 2 * loginX;
    CGFloat loginH = 44;
    
    CGFloat loginY = CGRectGetMaxY(self.forgetButton.frame) + (kMainHeight<=480?40:50);
    login.frame = CGRectMake(loginX, loginY, loginW, loginH);
    [self.view addSubview:login];
    self.loginButton = login;
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = [UIColor whiteColor];
    [registerButton setTitle:@"注        册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
    registerButton.layer.cornerRadius = 5.0f;
    registerButton.clipsToBounds = YES;
    registerButton.layer.borderWidth = 0.5;
    if (IS_IPHONE_6) {
        registerButton.layer.borderWidth = 1;
    }
    registerButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    CGFloat registerX = 20;
    CGFloat registerW = self.view.frame.size.width - 2 * registerX;
    CGFloat registerH = 44;
    CGFloat registerY = CGRectGetMaxY(self.loginButton.frame) + 20;
    registerButton.frame = CGRectMake(registerX, registerY, registerW, registerH);
    [self.view addSubview:registerButton];
    self.registerButton = registerButton;
}
- (void)clickLogin{
    [self.view endEditing:YES];
    if (!self.userNameTextField.text.length) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }else if (!self.passwordTextField.text.length){
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }else{
        if (![self.userNameTextField validatePhone:self.userNameTextField.text]) {
            [MBProgressHUD showError:@"请输入正确的手机号"];
            return;
        }else{
            
            if ([self.userNameTextField.text isEqualToString:@"17723117102"] && [self.passwordTextField.text isEqualToString:@"123456"])
            {
                MBProgressHUD *hud = [MBProgressHUD showHUD:self.view showMessage:@"登录中..."];
                [hud hideAnimated:YES afterDelay:2.5];
                hud.completionBlock = ^{
                    [MBProgressHUD showSuccess:@"登录成功!"];
                    if (![M_Tool getUserInfo])
                    {
                        UserModel *model = [UserModel new];
                        model.username = self.userNameTextField.text;
                        model.money = @"10000";
                        [M_Tool saveUserInfo:model];
                    }
                    [M_Tool setLoginStaute:YES];
                    TPostNotification(@"loginchange", nil, nil);
                    [self clickSetting];
                };
 
            }else
            {
                [MBProgressHUD showSuccess:@"请检查账号和密码是否正确"];
            }
            
        }
    }
}
- (void)clickRegister{
    RegisterViewController *registerVc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
//    JLog(@"点击注册");
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
