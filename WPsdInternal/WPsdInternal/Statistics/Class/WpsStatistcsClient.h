//
//  WpsStatistcsClient.h
//  WPsdInternal
//
//  Created by wapushidai on 16/9/2.
//  Copyright © 2016年 wapushidai. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "JZHTTPClient.h"
#import "JZMacro.h"
#import "WpsStatistcsPublic.h"
#import "WpsAppModel.h"
#import "SignatureTool.h"

//API接口
#define KWpsStatistcsAPI @"http://api.tj.anzhuo.com"
//#define KWpsStatistcsTestAPI @"http://testapi.tongji.com"

@interface WpsStatistcsClient : JZHTTPClient

/*!
 *   @brief 程序首次安装发送信息
 *
 *   @param model app所有信息
 */
+(void)WpsStatistcsFirstInstallationAppModel:(WpsAppModel *)model;
/*!
 *   @brief 程序每次活跃发送信息
 *
 *   @param model app所有信息
 */
+(void)WpsStatistcsEveryTimeInstallationAppModel:(WpsAppModel *)model;

@end
