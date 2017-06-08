//
//  JZMacro.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#ifndef TestSegmentedController_JZMacro_h
#define TestSegmentedController_JZMacro_h



#pragma mark - __FILE_SYSTEM__
/**
 *     返回沙盒路径的宏定义
 */
#define sandBoxPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]

/**
 *     返回沙盒临时路径的宏定义
 */
#define sandBoxTempPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]


#pragma mark - __VERSION_SYSTEM__
/**
 *     返回应用版本号
 */
#define BundleVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
/**
 *     返回应用名称
 */
#define BundleName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

/**
 *     返回应用 build 版本号
 */
#define BuildVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]


#pragma mark - __UIKit__
/**
 *     设置颜色的宏定义
 *
 *     @param r r
 *     @param g g
 *     @param b b
 *
 *     @return UIColor 对象
 */
#define RGB(r,g,b) RGBA(r,g,b,1)

/**
 *     设置颜色和透明度的宏定义
 *
 *     @param r r
 *     @param g g
 *     @param b b
 *     @param a 透明度
 *
 *     @return UIColor 对象
 */
#define RGBA(r,g,b,a) [UIColor \
colorWithRed:r/255.0    \
green:g/255.0           \
blue:b/255.0 alpha:a]


///**
// *     自定义 NSLog 宏，在控制台输出附加一个图案
// */
//#define NSLog(format, ...) do {     \
//fprintf(stderr, "<%s : %d> %s\n",   \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
//__LINE__, __func__);    \
//(NSLog)((format), ##__VA_ARGS__);   \
//fprintf(stderr, "\n ----------------------\n/ Hello Kings Yan Day! \\\n\\ my Macro Log ~       /\n ----------------------\n           \\\n            \\    ^__^\n                 (OO)\__________\n                 (__)\\          )\\/\\\n                     ||_______ _)\n                     ||       W |\n       YYy           ww        ww\n"); \
//} while (0)



#endif
