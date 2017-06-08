//
//  MBProgressHUD+NJ.m
//  Weather
//
//  Created by TNP on 16/6/22.
//  Copyright © 2016年 cxmx. All rights reserved.
//
#import "MBProgressHUD+NJ.h"

@implementation MBProgressHUD (NJ)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0f];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.label.font = [UIFont boldSystemFontOfSize:13];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    //    hud.dimBackground = NO;
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD:(MBProgressHUD *)hud
{
    [hud hideAnimated:YES];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}
//TNP  add
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)yesOrno showMessage:(NSString *)message afterDelay:(NSInteger)s successOrFail:(BOOL)yesORno completionShowMessage:(NSString *)succes completion:(void (^)())block
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:yesOrno];
    hud.label.text = message;
    [hud hideAnimated:yesOrno afterDelay:s];
    hud.completionBlock = ^{
        yesORno == YES?[MBProgressHUD showSuccess:succes]:[MBProgressHUD showError:succes];
        block();
    };
    return hud;
}
//TNP  add
+ (MBProgressHUD *)showHUD:(UIView *)view showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
   
    
    return hud;
}

//TNP  add request
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)yesOrno showMessage:(NSString *)message requestBlock:(void (^)(BOOL reqSucessOrFail))completionBlock afterDelay:(NSInteger)s succesShowMessage:(NSString *)succes failShowMessage:(NSString *)fail completion:(void (^)())block
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:yesOrno];
    hud.label.text = message;
    completionBlock = ^(BOOL reqSucessOrFail){
        [hud hideAnimated:YES afterDelay:s];
    reqSucessOrFail == YES?[MBProgressHUD showSuccess:succes]:[MBProgressHUD showError:fail];
        block();
    };
    return hud;
}
@end

