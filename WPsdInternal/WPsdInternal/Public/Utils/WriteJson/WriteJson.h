//
//  NSArrayToJsonArray.h
//  JZ_DEMO
//
//  Created by John Duan on 15/1/5.
//  Copyright (c) 2015年 JohnDuan. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *     定义生成 JSON 方法的工具类，提供生成 JSON 的一些方法供调用。
 */
@interface WriteJson : NSObject


+ (NSString *)resourceWithArray:(NSArray *)array;


@end
