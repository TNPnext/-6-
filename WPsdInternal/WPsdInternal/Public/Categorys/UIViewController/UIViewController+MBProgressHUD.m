//
//  JZBaseViewController+MBProgressHUD.m
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"
#import <objc/runtime.h>

static char hudKey;

@implementation UIViewController (MBProgressHUD)

- (void)setHud:(MBProgressHUD *)hud
{
    objc_setAssociatedObject(self, &hudKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)hud
{
    MBProgressHUD *hud = objc_getAssociatedObject(self, &hudKey);
    return hud;
}

- (void)showLoadHUD
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.removeFromSuperViewOnHide = YES;
}

- (void)showLoadHUDWithText:(NSString *)text
{
    [self showLoadHUD];
    self.hud.labelText = text;
}

- (void)showLoadHUDOnWindow
{
    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    self.hud.removeFromSuperViewOnHide = YES;
}

- (void)showLoadHUDOnWindowWithText:(NSString *)text
{
    [self showLoadHUDOnWindow];
    self.hud.labelText = text;
}

- (void)dismissLoadHUD
{
    self.hud.hidden = YES;
    self.hud = nil;
}

- (void)dismissLoadHUDWithSuccessText:(NSString *)text
{
    if (!self.hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.animationType = MBProgressHUDAnimationZoom;
    self.hud.labelText = text;
    [self.hud hide:YES afterDelay:1.2];
    __weak typeof (self) weakSelf = self;
    [self.hud setCompletionBlock:^{
        weakSelf.hud = nil;
    }];
}

- (void)dismissLoadHUDWithFailureText:(NSString *)text
{
    [self dismissLoadHUDWithSuccessText:text];
}

- (void)dismissLoadHUDWithFailureText:(NSString *)text completion:(void (^)())completion
{
    if (!self.hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.animationType = MBProgressHUDAnimationZoom;
    self.hud.labelText = text;
    [self.hud hide:YES afterDelay:1.5];
    __weak typeof (self) weakSelf = self;
    [self.hud setCompletionBlock:^{
        weakSelf.hud = nil;
        if (completion) {
            completion();
        }
    }];
}

- (void)dismissLoadHUDWithSuccessText:(NSString *)text completion:(void (^)())completion
{
    [self dismissLoadHUDWithFailureText:text completion:completion];
}

- (void)dismissHudWithText:(NSString *)text textFont:(UIFont *)textFont interval:(CGFloat)interval yOffset:(CGFloat)yOffset completion:(void (^)())completion
{
    if (!self.hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = text;
    self.hud.labelFont = textFont;
    self.hud.yOffset   = yOffset;
    [self.hud hide:YES afterDelay:interval];
    __weak typeof (self) weakSelf = self;
    [self.hud setCompletionBlock:^{
        weakSelf.hud = nil;
        if (completion) {
            completion();
        }
    }];
    
    //    [[COHUDView shareHud] stop];
}

@end
