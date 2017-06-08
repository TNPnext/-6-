//
//  NSString+Version.h
//  DynamicPicture
//
//  Created by TNP on 17/1/20.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Version)
/**
 对比版本号（eg: 1.0.0 vs 2.0）
 */
- (NSComparisonResult)comparedWithVersion:(NSString *)aVersion;
@end
