//
//  SDKConfig.m
//  Weather
//
//  Created by Kings Yan on 16/9/22.
//  Copyright © 2016年 cxmx. All rights reserved.
//

#import "ConfigSDK.h"
#import <UMMobClick/MobClick.h>

@interface ConfigSDK ()
    
@end

@implementation ConfigSDK

+ (instancetype)shareInstance
{
    static ConfigSDK *__single;
    static dispatch_once_t __once;
    
    dispatch_once(&__once, ^{
        __single = [[ConfigSDK alloc] init];
    });
    return __single;
}

+ (void)run
{
    [self setupUmengTrack];
}

#pragma mark - UMeng
+ (void)setupUmengTrack
{
    [MobClick setLogEnabled:NO];
    
}

@end
