//
//  RIButtonItem.h
//  Shibui
//
//  Created by Kings Yan on 1/12/11.
//  modify By IOS_Doctor on 2014-10-27
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *       需配合 UIAlertView+Blocks 或 UIActionSheet+Blocks 或其他基于该类实现的工具类使用，
 *    提供了为 UIAlertView+Blocks 或 UIActionSheet+Blocks 或其他基于该类实现的工具类提供按钮和点击后回调的简洁调用方法。
 */
@interface RIButtonItem : NSObject
{
    NSString *label;
    void (^action)();
}


/**
 *     定义的按钮 title 属性
 */
@property (retain, nonatomic) NSString *label;
/**
 *     定义的按钮点击回调闭包属性
 */
@property (copy, nonatomic) void (^action)();


/**
 *     初始方法
 *
 *     @return 该类的对象
 */
+ (id)item;

/**
 *     初始方法，并且指定一个按钮的 title
 *
 *     @param inLabel 按钮的 title
 *
 *     @return 该类设置好的对象
 */
+ (id)itemWithLabel:(NSString *)inLabel;

/**
 *     初始方法，并且指定一个按钮的 title 和按钮点击后的回调闭包方法体
 *
 *     @param inLabel 按钮的 title
 *
 *     @param action 按钮点击回调的闭包方法体
 *
 *     @return 该类设置好的对象
 */
+ (id)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action;


@end

