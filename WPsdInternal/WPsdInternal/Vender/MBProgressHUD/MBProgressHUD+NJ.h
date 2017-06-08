//
//  MBProgressHUD+NJ.h
//  Weather
//
//  Created by TNP on 16/6/22.
//  Copyright © 2016年 cxmx. All rights reserved.
//
#import "MBProgressHUD.h"
@interface MBProgressHUD (NJ)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD:(MBProgressHUD *)hud;
+ (void)hideHUDForView:(UIView *)view;
//TNP add
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)yesOrno showMessage:(NSString *)message afterDelay:(NSInteger)s successOrFail:(BOOL)yesORno completionShowMessage:(NSString *)succes completion:(void (^)())block;
//TNP add InternetRequest
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)yesOrno showMessage:(NSString *)message requestBlock:(void (^)(BOOL reqSucessOrFail))completionBlock afterDelay:(NSInteger)s succesShowMessage:(NSString *)succes failShowMessage:(NSString *)fail completion:(void (^)())block;
//TNP add
+ (MBProgressHUD *)showHUD:(UIView *)view showMessage:(NSString *)message;
@end

