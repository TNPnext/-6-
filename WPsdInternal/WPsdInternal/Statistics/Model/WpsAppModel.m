//
//  WpsAppModel.m
//  WPsdInternal
//
//  Created by wapushidai on 16/9/2.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import "WpsAppModel.h"

@implementation WpsAppModel
+ (WpsAppModel *)AppModel;
{
    WpsAppModel *model = [WpsAppModel new];
    model.app_key = KAppkey;
    model.appQid = KAppQid;
    model.appType = KAppType;
    model.system_version =  [NSString stringWithFormat:@"%f",currentSystemVersion()];
    model.phone_name = currentDeviceIOSModel();
    model.uuid = [UIDevice VKKeychainIDFV];
    model.phone_model = currentDeviceModl();
    model.appVersion = BundleVersion;
    model.appName = BundleName;
    model.appInternet = [self networktype];
    model.appInternetType = [self getcarrierName];
    
    return model;
}


//获取网络运营商
+ (NSString *)getcarrierName
{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry=[carrier carrierName];
    //NSLog(@"[carrier isoCountryCode]==%@,[carrier allowsVOIP]=%d,[carrier mobileCountryCode=%@,[carrier mobileCountryCode]=%@",[carrier isoCountryCode],[carrier allowsVOIP],[carrier mobileCountryCode],[carrier mobileNetworkCode]);
    if(currentCountry == nil || [currentCountry isEqualToString:@""])
    {
        return @"未知";
    }
    return currentCountry;
}

//获取当前网络方法
+ (NSString *)networktype
{
    NSArray *subviews = [[[[UIApplication sharedApplication]
                           valueForKey:@"statusBar"]
                           valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews)
    {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
        {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue])
    {
        case 0:
            
            break;
            
        case 1:
           return @"2G";
            break;
            
        case 2:
            return @"3G";
            break;
            
        case 3:
            return @"4G";
            break;
            
        case 4:
            return @"LTE";
            break;
            
        case 5:
           return @"WIFI";
            break;
            
            
        default:
            break;
    }
    return @"未知网络";
}
@end
