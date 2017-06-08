//
//  JZScrollParallaxEffectTool.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/3/31.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



/**
 *     表格 head 或者 footer 视图视差效果枚举
 */
typedef NS_ENUM(NSUInteger, JZScrollParallaxEffect)
{
    JZScrollParallaxEffect1 = 0,  //    .1
    JZScrollParallaxEffect2 = 1,  //    .2
    JZScrollParallaxEffect3 = 3,  //    .3
};



/**
 *     表格 head 或者 footer 视图视差效果工具类
 */
@interface JZScrollParallaxEffectTool : NSObject


/**
 *    head 视图视差效果方法
 *
 *     @param style        视差效果的枚举
 *     @param scroll       表格对象
 *     @param parallaxView head 或被执行视差效果的对象
 */
+ (void)parallaxEffectForHeaderWithStyle:(JZScrollParallaxEffect)style scroll:(UIScrollView *)scroll parallaxView:(UIView *)parallaxView;

/**
 *     footer 视图视差效果方法
 *
 *     @param style        视差效果的枚举
 *     @param scroll       表格对象
 *     @param parallaxView footer 或被执行视差效果的对象
 */
+ (void)parallaxEffectForFooterWithStyle:(JZScrollParallaxEffect)style scroll:(UIScrollView *)scroll parallaxView:(UIView *)parallaxView;


@end



/**
 *     辅助该类的计算 frame 值的工具类，被该类调用。
 */
@interface UIView (jzscrollparallaxeffectframe)
//sets frame.origin.y = top;
@property (nonatomic) CGFloat jzscrollparallaxeffecttop;
//sets frame.size.height = height;
@property (nonatomic) CGFloat jzscrollparallaxeffectheight;
@end
