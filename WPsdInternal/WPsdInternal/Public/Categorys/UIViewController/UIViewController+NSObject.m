//
//  UIViewController+Extension.m
//  WPsdInternal
//
//  Created by Kings Yan on 16/8/23.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import "UIViewController+NSObject.h"
#import "UIView+Category.h"

@implementation UIViewController (orientation)

- (void)setOrientationWithAnimationDuration:(CGFloat)duration complement:(void (^)(BOOL complete, UIDeviceOrientation orientation))complement
{
    self.view.window.backgroundColor = [UIColor blackColor];
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    id <UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    switch (orientation) {
        case 1: {
            [UIView animateWithDuration:duration animations:^{
                
                [self.view rotation_0];
                self.view.frame = window.bounds;
            } completion:^(BOOL finished) {
                if (complement) {
                    complement(YES, orientation);
                }
            }];
        } break;
        case 2: {
            [UIView animateWithDuration:duration animations:^{
                
                self.view.frame = CGRectMake(0, 0, window.height, window.width);
                self.view.centerX = window.width / 2;
                self.view.centerY = window.height / 2;
                [self.view rotation_180];
            } completion:^(BOOL finished) {
                if (complement) {
                    complement(YES, orientation);
                }
            }];
        } break;
        case 3: {
            [UIView animateWithDuration:duration animations:^{
                
                self.view.frame = CGRectMake(0, 0, window.height, window.width);
                self.view.centerX = window.width / 2;
                self.view.centerY = window.height / 2;
                [self.view rotation_90];
            } completion:^(BOOL finished) {
                if (complement) {
                    complement(YES, orientation);
                }
            }];
        } break;
        case 4: {
            [UIView animateWithDuration:duration animations:^{
                
                self.view.frame = CGRectMake(0, 0, window.height, window.width);
                self.view.centerX = window.width / 2;
                self.view.centerY = window.height / 2;
                [self.view rotation_270];
            } completion:^(BOOL finished) {
                if (complement) {
                    complement(YES, orientation);
                }
            }];
        } break;
            
        default: {
            if (complement) {
                complement(NO, orientation);
            }
        } break;
    }
}

@end

@implementation UIViewController (NSObject)

- (void)setInterfaceOrientationWithInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:orientation] forKey:@"orientation"];
}

@end
