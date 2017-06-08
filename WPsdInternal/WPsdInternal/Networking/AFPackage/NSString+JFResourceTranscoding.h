//
//  NSString+JFResourceTranscoding.h
//  WAF
//
//  Created by Kings Yan on 15/11/25.
//  Copyright © 2015年 西安交大捷普网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JFResourceTranscoding)

/**
 *     验证字符串是否包含中文
 *
 *     @return 字符串是否包含中文
 */
- (BOOL)isContainChinese;

@end
