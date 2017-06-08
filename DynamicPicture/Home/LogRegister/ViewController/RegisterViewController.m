//
//  RegisterViewController.m
//  Jest
//
//  Created by 段振伟 on 16/4/19.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginTextField.h"
#import "TNPTool.h"
#import <UIImage+Extension.h>
@interface RegisterViewController ()
{
    BOOL isAgreement;
}
@property (nonatomic, weak) LoginTextField *userNameTextField;
@property (nonatomic, weak) LoginTextField *passwordTextField;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UIButton *hasAccountButton;
@property (nonatomic, weak) UIButton *registerButton;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isAgreement = NO;
    self.title = self.isBound?@"绑定":@"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)]];
    [self setupInputTextField];
    if (!self.isBound) {
        [self setupHasAccountButton];
    }
    [self setupLoginRegisterButton];
    
}
- (void)didTapView{
    [self.view endEditing:YES];
}
- (void)setupInputTextField{
    CGFloat userNameY = 0;
    if (IS_IPHONE_4) {
        userNameY = 0 + 20;
    }else{
        userNameY = 0 + 50;
    }
    LoginTextField *userNameTextField = [[LoginTextField alloc] initWithFrame:CGRectMake(20, userNameY, kMainWidth - 2 * 20, 30)];
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
    
    LoginTextField *passwordTextField = [[LoginTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userNameTextField.frame) + 10, kMainWidth - 2 * 20, 30)];
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    UIImageView *passwordImageView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"login_ico_key"] tintColorWithColor:[UIColor hexStringToColor:KNavBarHexColor]]];
    passwordTextField.leftView = passwordImageView;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"密码";
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passwordTextField.frame) + 5, kMainWidth - 2 * 20, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    self.line1 = line1;
}
- (void)setupHasAccountButton{
    UIButton *hasAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hasAccountButton setTitle:@"已有账号?" forState:UIControlStateNormal];
    [hasAccountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    NSMutableAttributedString *hasAccount = [[NSMutableAttributedString alloc] initWithString:hasAccountButton.titleLabel.text];
    [hasAccount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, hasAccount.length)];
    CGFloat maxForgetWidth = 100;
    CGRect hasAccountRect = [hasAccount boundingRectWithSize:CGSizeMake(maxForgetWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    hasAccountButton.titleLabel.attributedText = hasAccount;
    [hasAccountButton addTarget:self action:@selector(clickHasAccountButton) forControlEvents:UIControlEventTouchUpInside];
    CGFloat hasAccountH = 20;
    CGFloat hasAccountY = CGRectGetMaxY(self.line1.frame) + 20;
    CGFloat hasAccountW = hasAccountRect.size.width;
    CGFloat hasAccountX = kMainWidth - hasAccountW - 20;
    hasAccountButton.frame = CGRectMake(hasAccountX, hasAccountY, hasAccountW, hasAccountH);
    [self.view addSubview:hasAccountButton];
    self.hasAccountButton = hasAccountButton;
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(25, CGRectGetMaxY(self.line1.frame) + 20, 20, 20);
    [checkBtn setImage:TImg(@"unchecked_agree") forState:(UIControlStateNormal)];
    [checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    [agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreementBtn];
    
    
}
-(void)checkBtnClick:(UIButton *)sender
{
    isAgreement = !isAgreement;
    self.registerButton.userInteractionEnabled = isAgreement;
    self.registerButton.backgroundColor =!isAgreement?[UIColor lightGrayColor]:[UIColor hexStringToColor:KNavBarHexColor];
    [sender setImage:isAgreement?TImg(@"checked_agree"):TImg(@"unchecked_agree") forState:(UIControlStateNormal)];
}
-(void)agreementBtnClick
{
    //[self.navigationController pushViewController:[AgreementViewController new] animated:YES];
}
- (void)clickHasAccountButton{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setupLoginRegisterButton{
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    [registerButton setTitle:self.isBound?@"绑        定":@"注        册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
    registerButton.layer.cornerRadius = 5.0f;
    registerButton.clipsToBounds = YES;
    CGFloat registerX = 20;
    CGFloat registerW = self.view.frame.size.width - 2 * registerX;
    CGFloat registerH = 40;
    CGFloat registerY = CGRectGetMaxY(self.line1.frame) + 60;
    registerButton.frame = CGRectMake(registerX, registerY, registerW, registerH);
    [self.view addSubview:registerButton];
    self.registerButton = registerButton;
    self.registerButton.userInteractionEnabled = self.isBound;
}
- (void)clickRegister{
    [self.view endEditing:YES];
    if (![self.userNameTextField validatePhone:self.userNameTextField.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }else if (![self.passwordTextField checkPassword:self.passwordTextField.text]){
        [MBProgressHUD showError:@"密码限制为6-15位字母与数字的组合"];
        return;
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUD:self.view showMessage:@"请稍等..."];
        [hud hideAnimated:YES afterDelay:2];
        hud.completionBlock = ^{
            [MBProgressHUD showSuccess:@"注册成功！请牢记账号和密码"];
            [self clickHasAccountButton];
        };
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
