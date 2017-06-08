//
//  JZBaseModle.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineObj.h"
#import "SSObjectBase.h"
#import "NSObject+Helper.h"

@interface JZBaseModle : SSObjectBase

/**
 *     初始和解析 JSON 数据的方法
 *
 *     @param data JSON
 *
 *     @return 模型对象
 */
- (id)init:(NSDictionary *)data;

/**
 *     解析 JSON 数据的方法
 *
 *     @param data JSON
 *
 *     @return 模型对象
 */
- (void)loadData:(NSDictionary*)data;


/**
 *     生成模型对应的 JSON 数据
 *
 *     @return JSON
 */
- (NSDictionary *)getObjDictionary;


/**
 *     生成模型对应的 JSON 字符串
 *
 *     @return JSON 字符串
 */
- (NSString *)getObjJsonStr;

@end
