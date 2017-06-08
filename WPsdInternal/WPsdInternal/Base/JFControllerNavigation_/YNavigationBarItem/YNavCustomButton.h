//
//  QSNavCustomButton.h
//  VideoShare
//
//  Created by Kings Yan on 14-2-14.
//  Copyright (c) 2014年 juche. All rights reserved.
//
//  导航按钮（UIBarButtonItem）自定义button类；配合导航基础类主体类别一起使用，一般不需要使用这个类直接来做自定义导航按钮，由使用导航基础类的方法
//  leftBarButtonWithStyle:(JZNavBarStyle)barStyle 传递 JZNavBarStyle 枚举值来实现自定义按钮的功能。
//

#import <UIKit/UIKit.h>

enum
{
    // 定义导航按钮类自己属于左边还是右边的枚举
    JZNavCustomButtonLeft,             //           左边
    JZNavCustomButtonRight,            //           右边
};

typedef int JZNavCustomButtonPosition; //           枚举类型



NS_CLASS_AVAILABLE_IOS(5_0) @interface YNavCustomButton : UIButton
{
    @private
    CGRect touchRect;
}

//  只在iPhone sdk 上可以使用
#if TARGET_OS_IPHONE
@property (nonatomic, assign, readonly) JZNavCustomButtonPosition position;



/**
 *     @author king Yan, 16-08-16 14:08:58
 *
 *     默认的初使方法
 *
 *     @param frame    frame
 *     @param position 左右位置的枚举类型
 *
 *     @return 这个类的对象
 */
- (id)initWithFrame:(CGRect)frame position:(JZNavCustomButtonPosition)position __attribute__((objc_designated_initializer));

#endif
@end
