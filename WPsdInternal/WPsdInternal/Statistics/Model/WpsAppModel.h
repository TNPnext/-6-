//
//  WpsAppModel.h
//  WPsdInternal
//
//  Created by wapushidai on 16/9/2.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "WpsAppInfo.h"
#import "JZDevice.h"
#import "UIDevice+VKKeychainIDFV.h"
#import "JZMapHelp.h"
#import "JZMacro.h"

@interface WpsAppModel : NSObject
+ (WpsAppModel *)AppModel;
//app名称
@property (nonatomic,copy)NSString *appName;
//app版本号
@property (nonatomic,copy)NSString *appVersion;
//app在服务器端所指向的Key  例子：安卓助手安卓版11 app_key为11
@property (nonatomic,copy)NSString *app_key;
//APP所指向的型号  1是安卓，2是IOS
@property (nonatomic,copy)NSString *appType;
//APP所运行的网络环境
@property (nonatomic,copy)NSString *appInternet;
//APP网络运营商
@property (nonatomic,copy)NSString *appInternetType;
//app下载的渠道ID IOS只有Appstore
@property (nonatomic,copy)NSString *appQid;
//设备唯一标识
@property (nonatomic,copy)NSString *uuid;
//设备名称
@property (nonatomic,copy)NSString *phone_name;
//用户位置信息
@property (nonatomic,copy)NSString *postion;
//用户程序总数
@property (nonatomic,copy)NSString *appcount;
//手机引用列表
@property (nonatomic,copy)NSString *applist;
//手机型号
@property (nonatomic,copy)NSString *phone_model;
//系统版本
@property (nonatomic,copy)NSString *system_version;
//短信条数
@property (nonatomic,copy)NSString *phone_message;
//1 新安装 2 启动
@property (nonatomic,copy)NSString *contype;

@end
