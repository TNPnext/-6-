//
//  WpsStatistcsManger.h
//  WPsdInternal
//
//  Created by wapushidai on 16/9/2.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WpsStatistcsClient.h"
#import "WpsAppModel.h"

@interface WpsStatistcsManger : NSObject
/*!
 *   @brief 程序首次安装发送信息
 */
+(void)WpsStatistcsFirstInstallationServiceKey:(NSString *)key;
/*!
 *   @brief 程序每次活跃发送信息
 */
+(void)WpsStatistcsEveryTimeInstallationServiceKey:(NSString *)key;
@end
