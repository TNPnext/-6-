//
//  NSDate+Extension.h
//  Pods
//
//  Created by Kings Yan on 16/4/18.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)


/**
 *     返回加上指定月份后的时间
 *
 *     @param month 月份
 *
 *     @return 加上指定月份后的时间
 */
- (NSDate *)addComponentWithMonth:(NSUInteger)month;

/**
 *     返回加上指定天数后的时间
 *
 *     @param month 天数
 *
 *     @return 加上指定天数后的时间
 */
- (NSDate *)addComponentWithDays:(NSUInteger)days;

/**
 *     返回加上指定小时后的时间
 *
 *     @param month 小时
 *
 *     @return 加上指定小时后的时间
 */
- (NSDate *)addComponentWithHour:(NSUInteger)hour;

/**
 *     获取小时的值
 *
 *     @return 小时
 */
- (NSInteger)getHour;

/**
 *     获取分钟的值
 *
 *     @return 分钟
 */
- (NSInteger)getMinute;

/**
 *     比较两个时间对象相差多少个小时
 *
 *     @param date 另一个时间对象
 *
 *     @return 两个时间对象相差多少个小时的值
 */
- (NSInteger)compareDaysWithDateObject:(NSDate *)date;

/**
 *     返回时间字符串的方法
 *
 *     @param formate 时间格式
 *
 *     @return 时间字符串
 */
- (NSString *)getDateStringWithFormatter:(NSString *)formate;


@end
