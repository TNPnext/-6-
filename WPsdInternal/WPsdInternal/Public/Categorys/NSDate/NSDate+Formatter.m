//
//  NSDate+Extension.m
//  VideoShare
//
//  Created by Kings Yan on 14-8-21.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)

- (NSString *)DD_
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"dd"];
	return [formatter stringFromDate:self];
}

- (NSString *)YYYY_MM_DD_hh_mm_ss
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	return [formatter stringFromDate:self];
}

- (NSString *)YYYY_MM_DD_hh_mm
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	return [formatter stringFromDate:self];
}

- (NSString *)hh_mm_ss
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"HH:mm:ss"];
	return [formatter stringFromDate:self];
}

- (NSString *)YYYY_MM_dd
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	return [formatter stringFromDate:self];
}

- (NSString *)YYYY_C_MM_C_dd_C_
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"yyyy年MM月dd日"];
	return [formatter stringFromDate:self];
}

- (NSString *)hh_mm
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"HH:mm"];
	return [formatter stringFromDate:self];
}

+ (NSString *)dateStringWithSecendNumberString:(NSString *)secendString
{
    int m = [secendString intValue];
    int hour   = m / 60 / 60 % 24;
    int minute = m / 60 % 60;
    int secend = m % 60;
    return [NSString stringWithFormat:@"%d:%d:%d",hour,minute, secend];
}

@end
