//
//  WpsStatistcsManger.m
//  WPsdInternal
//
//  Created by wapushidai on 16/9/2.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import "WpsStatistcsManger.h"
#import "WpsAppModel.h"

@implementation WpsStatistcsManger
/*!
 *   @brief 程序首次安装发送信息
 */
+(void)WpsStatistcsFirstInstallationServiceKey:(NSString *)key;
{
    WpsAppModel *model = [WpsAppModel AppModel];
    model.app_key = key;
    [WpsStatistcsClient WpsStatistcsFirstInstallationAppModel:model];
}
/*!
 *   @brief 程序每次活跃发送信息
 */
+(void)WpsStatistcsEveryTimeInstallationServiceKey:(NSString *)key;
{
    WpsAppModel *model = [WpsAppModel AppModel];
    model.app_key = key;
    [WpsStatistcsClient WpsStatistcsEveryTimeInstallationAppModel:model];
}
@end
