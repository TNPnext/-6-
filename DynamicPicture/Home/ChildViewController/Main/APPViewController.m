//
//  APPViewController.m
//  DynamicPicture
//
//  Created by TNP on 2017/4/20.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "APPViewController.h"
#import "RNCachingURLProtocol.h"
#import "MNetworkManager.h"
@interface APPViewController ()<UIWebViewDelegate>
{
    UIWebView *web;
}
@end

@implementation APPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
    web.delegate = self;
    web.scalesPageToFit = YES;//http://ny999.net
    [self.view addSubview:web];//http://www.555c9.com/Index/h5.html#/home
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://c6cai66.com"]]];
    [MNetworkManager getAppUrlSuccess:^(id data) {
        
        if (data[@"wapurl"]==nil || [data[@"wapurl"] isKindOfClass:[NSNull class]])
        {
            
        }else
        {
          [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:data[@"wapurl"]]]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)addClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            [web goBack];
        }
            break;
        case 1:
        {
          [web goForward];
        }
            break;
        case 2:
        {
          [web reload];
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
    }
    NSLog(@"-----------%@",request.URL.absoluteString);
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
