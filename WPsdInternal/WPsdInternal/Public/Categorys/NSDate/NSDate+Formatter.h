//
//  NSDate+Extension.h
//  VideoShare
//
//  Created by Kings Yan on 14-8-21.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)


/**
 *     获取时间天数的字符串
 *
 *     @return 时间天数的字符串
 */
- (NSString *)DD_;

/**
 *     获取时间年月日小时分秒的字符串
 *
 *     @return 时间年月日小时分秒的字符串
 */
- (NSString *)YYYY_MM_DD_hh_mm_ss;

/**
 *     获取时间年月日小时分的字符串
 *
 *     @return 时间年月日小时分的字符串
 */
- (NSString *)YYYY_MM_DD_hh_mm;

/**
 *     获取时间小时分秒的字符串
 *
 *     @return 时间小时分秒的字符串
 */
- (NSString *)hh_mm_ss;

/**
 *     获取时间年月日的字符串
 *
 *     @return 时间年月日的字符串
 */
- (NSString *)YYYY_MM_dd;

/**
 *     获取时间yyyy年MM月dd日的字符串
 *
 *     @return 时间yyyy年MM月dd日的字符串
 */
- (NSString *)YYYY_C_MM_C_dd_C_;

/**
 *     获取时间小时分的字符串
 *
 *     @return 时间小时分的字符串
 */
- (NSString *)hh_mm;

/**
 *     用秒数字符串转换成小时分钟秒的时间字符串的方法
 *
 *     @param secendString 秒数
 *
 *     @return 小时分钟秒的时间字符串
 */
+ (NSString *)dateStringWithSecendNumberString:(NSString *)secendString;


@end
