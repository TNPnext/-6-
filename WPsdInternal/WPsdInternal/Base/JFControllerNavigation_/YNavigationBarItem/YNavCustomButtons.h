//
//  QSNavCustomButton.h
//  VideoShare
//
//  Created by Kings Yan on 14-2-14.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YNavCustomButton.h"

NS_CLASS_AVAILABLE_IOS(5_0) @interface YNavCustomButtons : UIButton
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
