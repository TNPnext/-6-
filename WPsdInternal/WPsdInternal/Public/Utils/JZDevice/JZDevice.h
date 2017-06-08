//
//  JZObjHelp.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



/**
 *     iOS 设备型号常量
 */
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE;  //              iPhone
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_3G;  //           iphone3g
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_3GS;  //          iPhone3gs
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_4;    //          iPhone4
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_4S;   //          iPhone4s
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_5;    //          iphone5
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_5C;   //          iphone5c
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_5S;   //          iphone5s
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_6;    //          iphone6
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPHONE_6PLUS;   //       iphone6plus
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPOD_TOUCH_4;   //       ipod touch 4
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPOD_TOUCH_5;   //       ipod touch 5
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPOD_TOUCH_3;   //       ipod touch 3
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPOD_TOUCH_2;   //       ipod touch 2
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPOD_TOUCH;    //        ipod touch
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPAD_3;   //             ipad 3
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPAD_2;   //             ipad 2
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPAD_1;   //             ipad 1
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPAD_MINI;   //          ipad mini
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IPAD_AIR;    //          ipad air

FOUNDATION_EXPORT NSString *const JZ_DEVICE_IOS_MODEL_IPAD;   //      ipad
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IOS_MODEL_IPHONE;   //    iphone
FOUNDATION_EXPORT NSString *const JZ_DEVICE_IOS_MODEL_IPOD_TOUCH;  // ipod touch



/**
 *     获取设备型号、设备类型为iPhone或者iPad和iPod touch、系统版本、屏幕宽和高
 */
@interface JZDevice : NSObject


#pragma mark - __System__
/**
 *     当前系统版本
 */
CGFloat currentSystemVersion();

/**
 *     当前屏幕宽
 */
CGFloat currentScreenWidth();

/**
 *     当前屏幕高
 */
CGFloat currentScreenHeight();

/**
 *     当前设备类型
 */
NSString * currentDeviceModl();

/**
 *     当前设备型号
 */
NSString * currentDeviceIOSModel();


#pragma mark - __String__

NSString * NSStringFromFloat(float floatV);
NSString * NSStringFromInt(int intV);



@end
