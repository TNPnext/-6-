//
//  MeViewController.m
//  DynamicPicture
//
//  Created by TNP on 17/3/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.

//个人中心页面

#import "MeViewController.h"
#import "MLoginView.h"
#import "CollectionViewController.h"
#import "TabBar.h"
#import "TabBarButton.h"
#import "MainTarbarViewController.h"
#import <UIButton+WebCache.h>
#import "UserModel.h"
#import "DPHttpTool.h"
#import "AboutUsViewController.h"
#import "WebDetailViewController.h"
#import "LogInViewController.h"
#import "TNPTool.h"
#import "SuggestionViewController.h"
#import "BuyRecordViewController.h"
#import "PayViewController.h"
#import "TakeOutViewController.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView  *_maimTaleView;
    UserModel *_userModel;
    UILabel *_userName;
    UIButton *_editBtn;
    UIButton *_headBtn;
    UIButton *_loginBtn;
    NSArray *titles;
    UILabel *_moneyLabel;
}
@end

@implementation MeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _userModel = [M_Tool getUserInfo];
    if ([M_Tool isLogin])
    {
       _moneyLabel.text = [NSString stringWithFormat:@"余额:%@元",_userModel.money];
    }
    [_maimTaleView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    titles = @[@"购彩记录",@"我的收藏",@"清除缓存",@"版本信息",@"我要好评",@"意见反馈",@"关于我们"];
    
    self.navigationItem.title = @"会员中心";
    TAddObserverNotification(@selector(loginSucess), @"loginchange", nil);
    [self initViews];
    
}
-(void)loginout
{
    [M_Tool setLoginStaute:NO];
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"headLogo"];
    MBProgressHUD *hud = [MBProgressHUD showHUD:self.view showMessage:@"退出中..."];
    [hud hideAnimated:YES afterDelay:2.5];
    hud.completionBlock = ^{
        [MBProgressHUD showSuccess:@"退出成功!"];
        self.navigationItem.rightBarButtonItem = nil;
        [self.view removeAllSubviews];
        [self initViews];
    };
}
-(void)loginSucess
{
    [self.view removeAllSubviews];
    [self initViews];
}
-(void)initViews
{
    
    _userModel = [M_Tool getUserInfo];
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, [M_Tool isLogin]?150+44+30:150)];

    if ([M_Tool isLogin])
    {
        UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [settingButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
        settingButton.titleLabel.font = [UIFont systemFontOfSize:15];
        settingButton.frame = CGRectMake(0, 0, 80, 30);
        [settingButton addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
        self.navigationItem.rightBarButtonItem = setting;
        
    //头像
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //_headBtn.backgroundColor = [UIColor lightGrayColor];
    [_headBtn addTarget:self action:@selector(vipBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _headBtn.frame = CGRectMake(self.view.centerX-50, 10, 100, 100);
    _headBtn.clipsToBounds = YES;
    _headBtn.tag = 99;
    _headBtn.layer.cornerRadius = 50;
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"btn_man"]];
    [headV addSubview:_headBtn];
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"headLogo"];
    if (data) {
        [_headBtn setBackgroundImage:[UIImage imageWithData:data] forState:(UIControlStateNormal)];

    }
    
    _userName = [[UILabel alloc]init];
    
    [headV addSubview:_userName];
    
    _editBtn = [[UIButton alloc]init];
    //_editBtn.backgroundColor = [UIColor redColor];
    _editBtn.tag = 100;
    [_editBtn setImage:[UIImage imageNamed:@"btn_editor"] forState:(UIControlStateNormal)];
    [_editBtn addTarget:self action:@selector(vipBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headV addSubview:_editBtn];
    
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, kMainWidth, 30)];
        _moneyLabel.text = [NSString stringWithFormat:@"余额:%@元",_userModel.money];
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        [headV addSubview:_moneyLabel];
        
        NSArray *titA = @[@"充值",@"提现"];
        NSArray *imgA = @[@"recharge",@"withdraw"];
        for (int i = 0; i<2; i++)
        {
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame = CGRectMake((kMainWidth/2)*i, 180, kMainWidth/2, 44);
            [addBtn setImage:[UIImage imageNamed:imgA[i]] forState:(UIControlStateNormal)];
            [addBtn setTitle:titA[i] forState:(UIControlStateNormal)];
            [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            addBtn.tag = i;
            addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
            addBtn.backgroundColor = [UIColor whiteColor];
            [headV addSubview:addBtn];
            if (i==1) {
                [addBtn addtionVarticalLineWithSross:0.5 withLeft:0 withColor:[UIColor grayColor]];
            }
        }
        [headV addtionHorizontalLineWithSross:0.5 withTop:180 withColor:[UIColor grayColor]];
        [headV addtionHoriaontalLineWithSross:0.5 withLeft:0 withColor:[UIColor grayColor]];
    [self upDateFrame];
    }else
    {
        //头像
       _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        _loginBtn.frame = CGRectMake((kMainWidth-150)/2, (150-44)/2, 150, 44);
        [_loginBtn setTitle:@"立即登录" forState:(UIControlStateNormal)];
        _loginBtn.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _loginBtn.clipsToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
        [headV addSubview:_loginBtn];
        
    }
    
    _maimTaleView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight-64-49) style:UITableViewStylePlain];
    _maimTaleView.delegate = self;
    _maimTaleView.dataSource = self;
    //_maimTaleView.scrollEnabled = NO;
    _maimTaleView.separatorColor = [UIColor whiteColor];
    [self.view addSubview:_maimTaleView];
    _maimTaleView.tableHeaderView = headV;
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor grayColor];
    line.frame = CGRectMake(0, 150, kMainWidth, 0.5);
    [headV addSubview:line];
    
    
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_maimTaleView.frame), kMainWidth, kMainHeight-CGRectGetMaxY(_maimTaleView.frame))];
    downView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.view addSubview:downView];
    
}
-(void)addClick:(UIButton *)sender
{
    if (!sender.tag)
    {
        PayViewController *collVc = [[PayViewController alloc]init];
        [self.navigationController pushViewController:collVc animated:YES];
    }else
    {
        TakeOutViewController *collVc = [[TakeOutViewController alloc]init];
        [self.navigationController pushViewController:collVc animated:YES];
    }
}

-(void)loginBtnClick
{
    [self.navigationController pushViewController:[LogInViewController new] animated:YES];
}
//
-(void)upDateFrame
{
    _userModel = [M_Tool getUserInfo];
   
   CGFloat nameW = [M_Tool getRectWithStr:_userModel.username];

    _userName.frame = CGRectMake(self.view.centerX-15-nameW/2, 115, nameW, 30);
    _userName.text = _userModel.username;
    _editBtn.frame = CGRectMake(CGRectGetMaxX(_userName.frame), 115, 30, 30);
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float cacheSize = [[SDWebImageManager sharedManager].imageCache getSize] / 1024.0 / 1024.0;
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;

//    // 视频缓存路径
    float videoCache = [self folderSizeAtPath:cachePath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
        UILabel *cache = [[UILabel alloc]init];
        cache.frame = CGRectMake(kMainWidth-155, 0, 150, 44);
        cache.textAlignment = NSTextAlignmentRight;
        cache.font = [UIFont systemFontOfSize:14];
        
        cache.tag = 120;
        [cell.contentView addSubview:cache];
    }
    UILabel *cacheL = [cell.contentView viewWithTag:120];
    
    if (indexPath.row == 2 ||indexPath.row == 3)
    {
        cell.accessoryType = 0;
        if (indexPath.row == 3)
        {
            
           cacheL.text = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]];
        }else
        {
        cacheL.text = [NSString stringWithFormat:@"%.2fM",cacheSize +videoCache];
        }
        
    }else
    {
        [cacheL removeFromSuperview];
        cell.accessoryType = 1;
    }
    cell.textLabel.text = titles[indexPath.row];
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor hexStringToColor:@"999999"];
    line.frame = CGRectMake(0, 44, kMainWidth, 0.5);
    [cell.contentView addSubview:line];

    cell.selectionStyle = 0;
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        if ([M_Tool isLogin]) {
            //
        BuyRecordViewController *collVc = [[BuyRecordViewController alloc]init];
        [self.navigationController pushViewController:collVc animated:YES];
        }else
        {
            [self loginBtnClick];
        }
    }
   else if (indexPath.row == 1)
    {
        if ([M_Tool isLogin]) {
            CollectionViewController *collVc = [[CollectionViewController alloc]init];
            [self.navigationController pushViewController:collVc animated:YES];
        }else
        {
            [self loginBtnClick];
            
        }
        
    }else if (indexPath.row == 2)
    {
        //清除缓存
         [[SDWebImageManager sharedManager].imageCache clearDisk];
        
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        [[NSFileManager defaultManager]removeItemAtPath:cachePath error:nil];
        [_maimTaleView reloadData];
        [MBProgressHUD showSuccess:@"清理成功"];
    }else if (indexPath.row == 4)
    {
      [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/%E5%BD%A9%E7%A5%A8%E5%A4%A7%E5%B8%88-%E6%8F%90%E4%BE%9B%E6%9C%80%E7%B2%BE%E5%87%86%E7%9A%84%E5%BD%A9%E7%A5%A8%E5%88%86%E6%9E%90/id1229062188?l=zh&ls=1&mt=8"]];
    }
    else if (indexPath.row == 5)
    {
        [self.navigationController pushViewController:[SuggestionViewController new] animated:YES];
    }
    else if (indexPath.row == 6)
    {
        [self.navigationController pushViewController:[AboutUsViewController new] animated:YES];
    }
}
-(void)vipBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 99:
        {
          //头像
            UIAlertController *alerVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *ac = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
            [alerVc addAction:ac];
            UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self openPhotoCamera:1];
            }];
            [alerVc addAction:ac1];
            UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self openPhotoCamera:0];
            }];
            [alerVc addAction:ac2];
            [self presentViewController:alerVc animated:YES completion:nil];
        }
            break;
        case 100:
        {
            //昵称
            ChangeNmaeView *changeView = [[ChangeNmaeView alloc]init];
            changeView.saveNameBlock = ^(NSString *name){
                _userModel.username = name;
                [M_Tool saveUserInfo:_userModel];
                [self upDateFrame];
                [self changeNameRequet:name];
            };
            [[[UIApplication sharedApplication].delegate window]addSubview:changeView];
        }
            break;
        case 101:
        {
            //加入会员
            PayView *changeView = [[PayView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
            changeView.type = NO;
            changeView.chooseTypeBlock = ^(NSString *type){
                //包年
                if ([type boolValue])
                {
                    
                }
                else
                {
                    //包月
                }
                //支付方式
                PayView *ppView = [[PayView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
                ppView.type = YES;
                ppView.chooseTypeBlock = ^(NSString *type){
                    //微信支付
                    if (![type boolValue])
                    {
                        
                    }
                    else
                    {
                        //支付宝支付
                    }
                    
                    
                };
                [[[UIApplication sharedApplication].delegate window]addSubview:ppView];
                
            };
            [[[UIApplication sharedApplication].delegate window]addSubview:changeView];
            
        }
            break;
        case 102:
        {
            //退出
            [[NSNotificationCenter defaultCenter]postNotificationName:KloginOutKey object:nil];
        }
            break;
        default:
            break;
    }
}

-(void)openPhotoCamera:(NSInteger)number
{
    
    UIImagePickerController *imagePickCtr = [[UIImagePickerController alloc] init];
    [imagePickCtr.navigationBar setBarTintColor:[UIColor hexStringToColor:KNavBarHexColor]];
    imagePickCtr.delegate = self;
    imagePickCtr.allowsEditing = YES;
    if (number== 1)
    {
        imagePickCtr.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:imagePickCtr animated:YES completion:nil];
    }
    else
    {
        imagePickCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickCtr animated:YES completion:nil];
        
    }
 
}

/**
 *  图片选择控制器代理方法
 *  上传头像，修改头像
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [_headBtn setBackgroundImage:info[@"UIImagePickerControllerEditedImage"] forState:(UIControlStateNormal)];
    
   NSData *imgData = UIImageJPEGRepresentation(info[@"UIImagePickerControllerEditedImage"],0.1);
    [[NSUserDefaults standardUserDefaults]setObject:imgData forKey:@"headLogo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    MBProgressHUD *hud = [MBProgressHUD showHUD:picker.view showMessage:@"上传中..."];
    [hud hideAnimated:YES afterDelay:2.5];
    hud.completionBlock = ^{
        [MBProgressHUD showSuccess:@"上传成功!"];
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (picker.navigationItem.leftBarButtonItem.title == NULL || picker.navigationItem.leftBarButtonItem.title==nil)
    {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [picker popViewControllerAnimated:YES];
    }
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString *)folderPath
{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}
//单个文件的大小

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
-(void)changeNameRequet:(NSString *)name
{
//    [DPHttpTool postNewNameWithName:name success:^(NSURLSessionDataTask *task, id result) {
//        NSLog(@"ChangeNameresult====%@",result);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"changnaneerror====%@",error);
//    }];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
