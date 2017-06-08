//
//  JZModelBinding.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//  该类用于定义表格基础类使用的 cell 基础类的头文件定义，表格基础类所使用的 cell 基础类必须执行该协议的定义，来实现表格基础类框架的设计。
//

#import <Foundation/Foundation.h>
#import "JFBaseModel.h"

@protocol JZModelBinding <NSObject>


@property (nonatomic, strong) JFBaseModel *model;

/**
 *     记录 cell 自身在表格中的 NSIndexPath.row 的索引位置。
 */
@property (nonatomic, assign) NSUInteger idx;

/**
 *     记录 cell 自身在表格中的 NSIndexPath.section 的索引位置。
 */
@property (nonatomic, assign) NSUInteger sectionIdx;

/**
 *     在iOS8 之前的系统设置的自定义表格分割线的定义，适用于 iOS8 之前的版本。iOS8 以上系统对表格分割线的设置直接在表格控制器中实现。
 */
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, assign) CGFloat separatorViewLeft;
@property (nonatomic, assign) CGFloat separatorViewHeight;
//    set display separatorView, default is YES
@property (nonatomic, assign) BOOL isApearSeparatorView;
@property (nonatomic, strong) UIColor *separatorViewColor;

/**
 *     复写改变 cell 类自身在表格控制器中所占的高度。
 *
 *     @param model 被表格基础类调用时会返回当前 cell对象 对应的 JFBaseModel类的子类对象，用于设置返回不同的高度。
 *
 *     @return cell 在表格中所占的高度。
 */
+ (CGFloat)heightWithModel:(JFBaseModel *)model;


@end
