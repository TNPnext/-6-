//
//  NSString+Version.m
//  DynamicPicture
//
//  Created by TNP on 17/1/20.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "NSString+Version.h"

@implementation NSString (Version)
/**
 对比版本号（eg: 1.0.0 vs 2.0）
 //NSOrderedAscending左边的操作对象小于右边的对象。
  NSOrderedDescending左边的操作对象大于右边的对象。
 */
- (NSComparisonResult)comparedWithVersion:(NSString *)aVersion{
    
    NSInteger oriPointCount = self.length - [self stringByReplacingOccurrencesOfString:@"." withString:@""].length;
    NSInteger aftPointCount = aVersion.length - [aVersion stringByReplacingOccurrencesOfString:@"." withString:@""].length;
    
    NSString *oriVer = [self stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *aftVer = [aVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    NSString *zero = @"00";
    NSString *oriAppendingStr = [zero substringWithRange:NSMakeRange(0, 2 - oriPointCount)];
    NSString *aftAppendingStr = [zero substringWithRange:NSMakeRange(0, 2 - aftPointCount)];
    
    oriVer = [oriVer stringByAppendingString:oriAppendingStr];
    aftVer = [aftVer stringByAppendingString:aftAppendingStr];
    
    return [oriVer compare:aftVer];
}
@end
