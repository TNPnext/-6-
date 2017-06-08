//
//  WpsConfigurationTool.m
//  WPsdInternal
//
//  Created by wapushidai on 16/9/5.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import "WpsConfigurationTool.h"

@implementation WpsConfigurationTool
//@brief 配置友盟
+(void)configurationUmeng;
{
//    [MobClick setLogEnabled:YES];
//    UMConfigInstance.appKey = KUMKey;
//    UMConfigInstance.secret = @"secretstringaldfkals";
//    [MobClick startWithConfigure:UMConfigInstance];
}
//项目配置
+(void)wpsConfigurationServiceKey:(NSString *)key;
{
    //调用统计
    [WpsStatistcsManger WpsStatistcsFirstInstallationServiceKey:key];
    [self configurationUmeng];
}

//激活配置
+(void)wpsConfigurationEveryTimeInstallationServiceKey:(NSString *)key;
{
    [WpsStatistcsManger WpsStatistcsEveryTimeInstallationServiceKey:key];
}

@end
