//
//  QSNavCustomButton.h
//  VideoShare
//
//  Created by IOS_Doctor on 14-2-14.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import <UIKit/UIKit.h>

enum
{
    JZNavCustomButtonLeft,
    JZNavCustomButtonRight,
};

typedef int JZNavCustomButtonPosition;

NS_CLASS_AVAILABLE_IOS(5_0) @interface JZNavCustomButton : UIButton
{
    @private
    CGRect touchRect;
}

#if TARGET_OS_IPHONE
@property (nonatomic, assign, readonly) JZNavCustomButtonPosition position;

- (id)initWithFrame:(CGRect)frame position:(JZNavCustomButtonPosition)position __attribute__((objc_designated_initializer));

#endif
@end
