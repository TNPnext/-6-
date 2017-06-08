//
//  ADWebViewController.m
//  DynamicPicture
//
//  Created by TNP on 17/1/21.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "ADWebViewController.h"
#import "ADModel.h"
#import "MJExtension.h"
#import "WEInformationNavBar.h"
@interface ADWebViewController ()
{
    WEInformationNavBar *_navBar;
    ADModel *_ADModel;
}
@end

@implementation ADWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSDictionary *ADdic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ADData"];
     _ADModel= [ADModel mj_objectWithKeyValues:ADdic];
    [self setupNavBar];
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kMainWidth, kMainHeight-64)];
    [self.view addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urls?_urls:_ADModel.ad_url]]];
    
}
- (void)setupNavBar
{
    _navBar = [[WEInformationNavBar alloc] init];
    _navBar.backTintColor = [UIColor whiteColor];
    _navBar.titleColor = [UIColor blackColor];
    _navBar.lineColor = RGB(200, 199, 204);
    _navBar.titleView.text = _titles?_titles:_ADModel.ad_title;
    _navBar.titleView.textColor = [UIColor blackColor];
    _navBar.frame = CGRectMake(0, 20, self.view.width, KWENavBarH);
    [_navBar.rightBtn setImage:nil forState:UIControlStateNormal];
    //    [_navBar.rightBtn setTitle:@"  " forState:UIControlStateNormal];
    [_navBar.rightBtn setTitleColor:RGB(26, 28, 30) forState:UIControlStateNormal];
    [_navBar.leftBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    __weak __typeof(self) weakSelf = self;
    _navBar.leftBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    UIView *mark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _navBar.width, _navBar.bottom)];
    mark.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mark];
    [self.view addSubview:_navBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
