//
//  PublicClass.h
//  FindJob
//
//  Created by Chengfj on 14-10-21.
//  Copyright (c) 2014年 RIMI. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *     定义用正则表达式或其他方式进行一些验证方法的工具类，提供一些用于验证的方法。
 */
@interface Validate : NSObject


/**
 *  验证邮箱格式
 *
 *  @param email 邮箱
 *
 *  @return 是否为正确的邮箱格式
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  验证手机号
 *
 *  @param mobile 手机号码
 *
 *  @return 是否为正确的手机号
 */
+ (BOOL)validateMobile:(NSString *)mobile;


@end
