//
//  JZComplierMacro.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#ifndef Cooking_QSComplierMacro_h
#define Cooking_QSComplierMacro_h



/**
 *     执行 perform 方法时用于编译消除警告的宏
 *
 *     @param target 执行 perform 方法的对象
 *     @param action SEL
 *     @param object object
 *
 *     @return 对应执行 perform 方法的返回
 */
#pragma mark - perform -

#define NoWarningPerformSelector(target, action, object) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[target performSelector:action withObject:object]; \
_Pragma("clang diagnostic pop") \



#endif
