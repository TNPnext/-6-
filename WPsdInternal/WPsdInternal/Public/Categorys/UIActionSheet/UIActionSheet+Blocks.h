//
//  UIActionSheet+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 1/5/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

@interface UIActionSheet (Blocks) <UIActionSheetDelegate>


/**
 *     对 UIActionSheet 进行实例的方法，配合 RIButtoniItem 来实现用闭包返回点击回调的功能，提高业务代码的可读性和实现的灵活性。
 *
 *     @param inTitle            标题名
 *     @param inCancelButtonItem 带闭包回调的按钮
 *     @param inDestructiveItem  带闭包回调的按钮
 *     @param inOtherButtonItems 带闭包回调的按钮（多参）
 *
 *     @return UIActionSheet 类的实例
 */
- (id)initWithTitle:(NSString *)inTitle cancelButtonItem:(RIButtonItem *)inCancelButtonItem destructiveButtonItem:(RIButtonItem *)inDestructiveItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *     添加一个按钮，用闭包体作为点击回调。
 *
 *     @param item 带闭包回调的按钮
 *
 *     @return 按钮的索引值
 */
- (NSInteger)addButtonItem:(RIButtonItem *)item;

/** This block is called when the action sheet is dismssed for any reason.
 */
@property (copy, nonatomic) void(^dismissalAction)();


@end
