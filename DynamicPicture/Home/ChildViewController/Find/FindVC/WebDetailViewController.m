//
//  WebDetailViewController.m
//  DynamicPicture
//
//  Created by TNP on 2017/4/20.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "WebDetailViewController.h"
#import <MBProgressHUD.h>
#import "WEInformationNavBar.h"
@interface WebDetailViewController ()<UIWebViewDelegate>
{
    NSInteger _count;
}
@end

@implementation WebDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titt;
    _count = 1;
    if ([_titt isEqualToString:@"资讯详情"])
    {
        
        
        
       WEInformationNavBar *_navBar = [[WEInformationNavBar alloc] init];
        _navBar.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
        _navBar.lineColor = RGB(200, 199, 204);
        _navBar.titleView.text = _titt;
        _navBar.titleView.textColor = [UIColor whiteColor];
        _navBar.frame = CGRectMake(0, 20, self.view.width, KWENavBarH);
        [_navBar.rightBtn setImage:nil forState:UIControlStateNormal];
        //    [_navBar.rightBtn setTitle:@"  " forState:UIControlStateNormal];
        [_navBar.rightBtn setTitleColor:RGB(26, 28, 30) forState:UIControlStateNormal];
        [_navBar.leftBtn setImage:[UIImage imageNamed:@"download_btn_back"] forState:UIControlStateNormal];
        __weak __typeof(self) weakSelf = self;
        _navBar.leftBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        
        UIView *mark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _navBar.width, _navBar.bottom)];
        mark.backgroundColor = [UIColor hexStringToColor:KNavBarHexColor];
        [self.view addSubview:mark];
        [self.view addSubview:_navBar];
        UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kMainWidth, kMainHeight-64)];
        web.scalesPageToFit = YES;
        web.delegate = self;
        [self.view addSubview:web];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
        
    }else
    {
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight-64)];
    web.scalesPageToFit = YES;
    web.delegate = self;
    [self.view addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
    }
    //NSLog(@"-----------%@",request.URL.absoluteString);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (_count==1)
    {
      [MBProgressHUD showHUD:self.view showMessage:@"加载中..."];
    }
    _count++;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
