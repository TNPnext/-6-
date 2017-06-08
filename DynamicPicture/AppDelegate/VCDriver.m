//
//  VCDrive.m
//  WAF
//
//  Created by  Kings Yan on 15/9/14.
//  Copyright (c) 2015年 西安交大捷普网络科技有限公司. All rights reserved.
//

#import "VCDriver.h"
#import "MainViewController.h"
#import "MainTarbarViewController.h"
#import "APPViewController.h"
#import "TNPTool.h"
#import "RNCachingURLProtocol.h"
@interface VCDriver () <UIGestureRecognizerDelegate>

@end

@implementation VCDriver

+ (instancetype)shareInstance
{
    static VCDriver *__single;
    static dispatch_once_t __once;
    
    dispatch_once(&__once, ^{
        __single = [[VCDriver alloc] init];
    });
    return __single;
}

+ (void)run
{
    id <UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]]; //注册UIWebView缓存
    
    int time1 = [[NSDate date] timeIntervalSince1970];
    int time2 = 1496504246;//6.3
    if (time2-time1>0)
    {
//        if ([TOutDate(@"haveLunch") boolValue])
//        {
            MainTarbarViewController *navi = [MainTarbarViewController new];
            delegate.window.rootViewController = navi;
//        }else
//        {
//            AppGuideViewController *navi = [AppGuideViewController new];
//            delegate.window.rootViewController = navi;
//        }
    }else
    {
      APPViewController *navi = [APPViewController new];
        delegate.window.rootViewController = navi;
    }
    //NSLog(@"---------%d",time1);
    
    
    
    
    
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
