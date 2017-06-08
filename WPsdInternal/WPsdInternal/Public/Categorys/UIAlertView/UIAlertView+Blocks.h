//
//  UIAlertView+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

@interface UIAlertView (Blocks)


/**
 *     对 UIAlertView 进行实例的方法，配合 RIButtoniItem 来实现用闭包返回点击回调的功能，提高业务代码的可读性和实现的灵活性。
 *
 *     @param inTitle            标题名
 *     @param inCancelButtonItem 带闭包回调的按钮
 *     @param inDestructiveItem  带闭包回调的按钮
 *     @param inOtherButtonItems 带闭包回调的按钮（多参）
 *
 *     @return UIAlertView 类的实例
 */
-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *     添加一个按钮，用闭包体作为点击回调。
 *
 *     @param item 带闭包回调的按钮
 *
 *     @return 按钮的索引值
 */
- (NSInteger)addButtonItem:(RIButtonItem *)item;


@end
