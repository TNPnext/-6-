//
//  WpsConfigurationTool.h
//  WPsdInternal
//
//  Created by wapushidai on 16/9/5.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WpsStatistcsManger.h"
//友盟key
#define KUMKey @"574fabc767e58ed525001359"


@interface WpsConfigurationTool : NSObject
//第一次启动配置项目配置, key服务端分配的Key
+(void)wpsConfigurationServiceKey:(NSString *)key;
//激活配置,key服务端分配的Key
+(void)wpsConfigurationEveryTimeInstallationServiceKey:(NSString *)key;
@end
