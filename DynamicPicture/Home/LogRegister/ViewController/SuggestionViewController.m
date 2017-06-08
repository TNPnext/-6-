//
//  SuggestionViewController.m
//  Jest
//
//  Created by 段振伟 on 16/4/14.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "SuggestionViewController.h"
#import "CharaterInputView.h"


@interface SuggestionViewController ()<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImageView *_uploadImgV;
    UITextField *_qqNumber;
    NSString   *_imageUrl;
    BOOL  _isHaveImage;
}
@property (nonatomic, weak)CharaterInputView *charaterInputView;

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isHaveImage = NO;
    self.title = @"意见反馈";
    self.view.backgroundColor  = [UIColor whiteColor];
    
    UIBarButtonItem *submit = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    //    UIBarButtonItem *sub = [UIBarButtonItem alloc] initWithCustomView:<#(nonnull UIView *)#>;
    self.navigationItem.rightBarButtonItem = submit;
    
    // 编辑视图
    [self setupEditingView];
    
//    [self.charaterInputView becomeFirstResponder];
}
- (void)submit
{
    if (_charaterInputView.text.length > 500) {
        [MBProgressHUD showError:@"内容限制500字"];
    }else
    {
    if (self.charaterInputView.text.length)
    {
        [MBProgressHUD showSuccess:@"多谢您的反馈～我们会及时查看的！"];
    }
    else
    {
        [MBProgressHUD showError:@"请输入文字"];
    }
    }
}
-(void)uploadContent
{
    

}

// 编辑视图
- (void)setupEditingView{
    
    CharaterInputView *charaterInputView = [[CharaterInputView alloc] initWithFrame:CGRectMake(10, 10, kMainWidth-20, 100)];
    charaterInputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:charaterInputView];
    self.charaterInputView = charaterInputView;
    self.charaterInputView.placeholderLabel.frame = CGRectMake(5, 2, kMainWidth, 30);
    self.charaterInputView.placeholder = @"请填写反馈意见,谢谢!";
    self.charaterInputView.alwaysBounceVertical = YES;
    self.charaterInputView.delegate = self;
    
    
    
    
}
-(void)addImageClick
{
    UIActionSheet *actionSteet = [[UIActionSheet alloc] init];
    actionSteet.delegate = self;
    [actionSteet addButtonWithTitle:@"从手机相册选取"];
    [actionSteet addButtonWithTitle:@"取消"];
    [actionSteet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0)
    {
        [self openCameraLibray];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
/**
 *  打开相机
 */
- (void)openCameraLibray{
    UIImagePickerController *imagePickCtr = [[UIImagePickerController alloc] init];
    imagePickCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePickCtr.delegate = self;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [self presentViewController:imagePickCtr animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 1.销毁图片选择控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    _uploadImgV.image = info[UIImagePickerControllerOriginalImage];
    _isHaveImage = YES;
    //处理图片上传到服务器 旋转问题
    // UIImage *resultImage = [self fixOrientation:image];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.charaterInputView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - keyboardF.size.height);
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.charaterInputView.frame = self.view.bounds;
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.charaterInputView becomeFirstResponder];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
