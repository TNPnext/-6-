//
//  JZBaseViewController+MBProgressHUD.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+NJ.h"

@interface UIViewController (MBProgressHUD)

@property (nonatomic, strong) MBProgressHUD *hud;

- (void)showLoadHUD;
- (void)showLoadHUDWithText:(NSString *)text;
- (void)showLoadHUDOnWindow;
- (void)showLoadHUDOnWindowWithText:(NSString *)text;
- (void)dismissLoadHUD;
- (void)dismissLoadHUDWithSuccessText:(NSString *)text;
- (void)dismissLoadHUDWithFailureText:(NSString *)text;
- (void)dismissLoadHUDWithSuccessText:(NSString *)text completion:(void(^)())completion;
- (void)dismissLoadHUDWithFailureText:(NSString *)text completion:(void(^)())completion;
- (void)dismissHudWithText:(NSString *)text textFont:(UIFont *)textFont interval:(CGFloat)interval
                   yOffset:(CGFloat)yOffset completion:(void (^)())completion;

@end
