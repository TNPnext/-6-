//
//  FindPassWordViewController.m
//  Jest
//
//  Created by 段振伟 on 16/4/19.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "TNPTool.h"
#import <UIImage+Extension.h>
#import "LoginTextField.h"
@interface FindPassWordViewController ()
@property (nonatomic, weak) LoginTextField *phoneNumberTextField;
@property (nonatomic, weak) LoginTextField *verifyNumberTextField;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UIButton *confirmButton;
@property (nonatomic, weak) UIButton *getVerifyButton;
@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupInputTextField];
    [self setupConfirmButton];
}
- (void)setupInputTextField{
    CGFloat userNameY = 0;
    if (IS_IPHONE_4) {
        userNameY = 0 + 20;
    }else{
        userNameY = 0 + 50;
    }
    
    UIButton *getVerifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getVerifyButton.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    [getVerifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    getVerifyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [getVerifyButton addTarget:self action:@selector(clickGetVerifyButton:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableAttributedString *getVerify = [[NSMutableAttributedString alloc] initWithString:getVerifyButton.titleLabel.text];
    [getVerify addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, getVerify.length)];
    CGFloat maxGetVerifyWidth = 80;
    CGRect getVerifyRect = [getVerify boundingRectWithSize:CGSizeMake(maxGetVerifyWidth, 30) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    getVerifyButton.titleLabel.attributedText = getVerify;
    getVerifyButton.layer.cornerRadius = 3.0f;
    getVerifyButton.clipsToBounds = YES;
    CGFloat getVerifyW = getVerifyRect.size.width + 20;
    CGFloat getVerifyH = 30;
    
    LoginTextField *phoneNumberTextField = [[LoginTextField alloc] initWithFrame:CGRectMake(20, userNameY, kMainWidth - 2 * 20 - getVerifyW - 20, 30)];
    phoneNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView *userImageView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"login_ico_account"] tintColorWithColor:[UIColor hexStringToColor:KNavBarHexColor]]];
    phoneNumberTextField.leftView = userImageView;
    phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneNumberTextField.placeholder = @"手机号";
    [self.view addSubview:phoneNumberTextField];
    self.phoneNumberTextField = phoneNumberTextField;
    
    
    CGFloat getVerifyY = CGRectGetMaxY(self.phoneNumberTextField.frame) - getVerifyH;
    CGFloat getVerifyX = CGRectGetMaxX(self.phoneNumberTextField.frame) + 20;
    getVerifyButton.frame = CGRectMake(getVerifyX, getVerifyY, getVerifyW, getVerifyH);
    [self.view addSubview:getVerifyButton];
    self.getVerifyButton = getVerifyButton;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(phoneNumberTextField.frame) + 5, kMainWidth - 2 * 20, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    self.line = line;
    
    LoginTextField *verifyNumberTextField = [[LoginTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line.frame) + 10, kMainWidth - 2 * 20, 30)];
    verifyNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifyNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    UIImageView *passwordImageView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"login_ico_key"] tintColorWithColor:[UIColor hexStringToColor:KNavBarHexColor]]];
    verifyNumberTextField.leftView = passwordImageView;
    verifyNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    verifyNumberTextField.placeholder = @"验证码";
    [self.view addSubview:verifyNumberTextField];
    self.verifyNumberTextField = verifyNumberTextField;
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(verifyNumberTextField.frame) + 5, kMainWidth - 2 * 20, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    self.line1 = line1;
}
- (void)clickGetVerifyButton:(UIButton *)sender{
    if (![self.phoneNumberTextField validatePhone:self.phoneNumberTextField.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }else{
        // 点击了获取验证码
        

                __block int timeout=59; //倒计时时间
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if(timeout<=0){ //倒计时结束，关闭
                        dispatch_source_cancel(_timer);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //设置界面的按钮显示 根据自己需求设置
                            [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                            sender.userInteractionEnabled = YES;
                        });
                    }else{
                        int seconds = timeout % 60;
                        NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //设置界面的按钮显示 根据自己需求设置
                            //NSLog(@"____%@",strTime);
                            [UIView beginAnimations:nil context:nil];
                            [UIView setAnimationDuration:1];
                            [sender setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                            [UIView commitAnimations];
                            sender.userInteractionEnabled = NO;
                        });
                        timeout--;
                    }
                });
                dispatch_resume(_timer);
                
                return ;
    }
}
- (void)setupConfirmButton{
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
    [confirmButton setTitle:@"确        定" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:17];
    confirmButton.layer.cornerRadius = 5.0f;
    confirmButton.clipsToBounds = YES;
    CGFloat registerX = 20;
    CGFloat registerW = self.view.frame.size.width - 2 * registerX;
    CGFloat registerH = 40;
    CGFloat registerY = CGRectGetMaxY(self.line1.frame) + 80;
    confirmButton.frame = CGRectMake(registerX, registerY, registerW, registerH);
    [self.view addSubview:confirmButton];
    self.confirmButton = confirmButton;
}
- (void)clickConfirmButton{
    if (![self.phoneNumberTextField validatePhone:self.phoneNumberTextField.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }else if (!self.verifyNumberTextField.text.length){
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }else{
        
        
    }
    
}
//- (void)registerNotice:(NSString *)info{
//    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.opacity = 0.5;
//    HUD.delegate = self;
//    HUD.mode = MBProgressHUDModeText;
//    HUD.labelText = info;
//    [HUD hide:YES afterDelay:1.5];
//}
//- (void)hudWasHidden:(MBProgressHUD *)hud{
//    [hud removeFromSuperview];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
