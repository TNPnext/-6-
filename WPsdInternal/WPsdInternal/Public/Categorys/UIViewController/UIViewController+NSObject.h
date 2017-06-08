//
//  UIViewController+Extension.h
//  WPsdInternal
//
//  Created by Kings Yan on 16/8/23.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (orientation)


- (void)setOrientationWithAnimationDuration:(CGFloat)duration complement:(void(^)(BOOL complete, UIDeviceOrientation orientation))complement;


@end



@interface UIViewController (NSObject)


- (void)setInterfaceOrientationWithInterfaceOrientation:(UIInterfaceOrientation)orientation;


@end
