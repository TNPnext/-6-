//
//  UIButton+TabBar.h
//  horse
//
//  Created by Kings Yan on 14-10-03.
//  Copyright (c) 2014年 __IOS_Doctor__. All rights reserved.
//

#import "UIButton+TabBar.h"

@implementation UIButton (TabBar)

- (void)custom
{
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGPoint contentCenter = CGPointMake(CGRectGetMidX(contentRect), CGRectGetMidY(contentRect));
    CGRect titleRect = [self titleRectForContentRect:contentRect];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(16.5, - (CGRectGetMidX(titleRect) - contentCenter.x), -16.5, (CGRectGetMidX(titleRect) - contentCenter.x))];
}

@end
