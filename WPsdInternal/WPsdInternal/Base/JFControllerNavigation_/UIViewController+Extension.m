//
//  JZBaseViewController+Extension.m
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "YNavCustomButton.h"
#import "YNavCustomButtons.h"
#import "UIView+Category.h"
#import "JZDevice.h"
#import "JZMacro.h"
#import "UIImage+Extension.h"


@implementation UIViewController (Extension)

- (void)setNavigationBarHidde:(BOOL)hidde
{
    self.navigationController.navigationBar.hidden = hidde;
}

- (void)presentViewController:(UIViewController *)controller
{
    [self closeAFNetWork];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)presentViewControllerWithNoAnimation:(UIViewController *)controller
{
    [self closeAFNetWork];
    [self presentViewController:controller animated:NO completion:nil];
}

- (void)dismissView
{
    [self closeAFNetWork];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissViewWithNoAnimation
{
    [self closeAFNetWork];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)popView
{
    [self closeAFNetWork];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popViewWithNoAnimation
{
    [self closeAFNetWork];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)pushViewController:(UIViewController *)controller
{
    [self closeAFNetWork];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pushViewControllerWithNoAnimation:(UIViewController *)controller
{
    [self closeAFNetWork];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)popToRoot
{
    [self closeAFNetWork];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToRootWithNoAnimation
{
    [self closeAFNetWork];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


@end

#import <objc/runtime.h>

static char presentVcKey, presentCaptureKey, presentRectKey;

@implementation UIViewController (presentViewController)

- (void)setPresentVc:(UIViewController *)presentVc
{
    objc_setAssociatedObject(self, &presentVcKey, presentVc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)presentVc
{
    return objc_getAssociatedObject(self, &presentVcKey);
}

- (void)setPresentCapture:(UIImage *)presentCapture
{
    objc_setAssociatedObject(self, &presentCaptureKey, presentCapture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)presentCapture
{
    return objc_getAssociatedObject(self, &presentCaptureKey);
}

- (void)setPresentRect:(CGRect)presentRect
{
    objc_setAssociatedObject(self, &presentRectKey, [NSValue valueWithCGRect:presentRect], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)presentRect
{
    return [((NSValue *)objc_getAssociatedObject(self, &presentRectKey)) CGRectValue];
}

- (void)presentViewController:(UIViewController *)controller withAnimationView:(UIView *)view withTransformImage:(UIImage *)transform
{
    UIImageView *capture = [[UIImageView alloc] init];
    capture.image = (transform)? transform : [view capture];
    CGRect originRect = [self.view convertRect:view.frame toView:self.view.window];
    capture.frame = originRect;
    [self.view.window addSubview:capture];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        capture.frame = [UIScreen mainScreen].bounds;
//        capture.alpha = 0.1;
    } completion:^(BOOL finished) {
        
        [capture removeFromSuperview];
        // present View Controller.
        controller.presentVc = self;
        controller.presentRect = originRect;
        controller.presentCapture = capture.image;
        [self pushViewControllerWithNoAnimation:controller];
    }];
}

- (void)dismissViewControllerForPresentVc
{
    [self popViewWithNoAnimation];
    
    UIImageView *captureV = [[UIImageView alloc] init];
    captureV.image = self.presentCapture;
    captureV.frame = [UIScreen mainScreen].bounds;
//    captureV.alpha = 0.1;
    [((id <UIApplicationDelegate>)[UIApplication sharedApplication].delegate).window addSubview:captureV];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        captureV.frame = self.presentRect;
//        captureV.alpha = 1;
    } completion:^(BOOL finished) {
        [captureV removeFromSuperview];
    }];
}

@end

static char leftNavKey, rightNavKey, autoLoadLeftNavBtnKey;

@implementation UIViewController (NavigationControler)

- (void)setLeftNavBarStyle:(JZNavBarStyle)leftNavBarStyle
{
    objc_setAssociatedObject(self, &leftNavKey, [NSNumber numberWithInteger:leftNavBarStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JZNavBarStyle)leftNavBarStyle
{
    return [objc_getAssociatedObject(self, &leftNavKey) integerValue];
}

- (void)setRightNavBarStyle:(JZNavBarStyle)rightNavBarStyle
{
    objc_setAssociatedObject(self, &rightNavKey, [NSNumber numberWithInteger:rightNavBarStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JZNavBarStyle)rightNavBarStyle
{
    return [objc_getAssociatedObject(self, &rightNavKey) integerValue];
}

- (void)setAutoLoadLeftNavBtn:(BOOL)autoLoadLeftNavBtn
{
    objc_setAssociatedObject(self, &autoLoadLeftNavBtnKey, [NSNumber numberWithBool:autoLoadLeftNavBtn], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)autoLoadLeftNavBtn
{
    return [objc_getAssociatedObject(self, &autoLoadLeftNavBtnKey) boolValue];
}

- (void)defaultNavigationControllerSetting
{
    if (currentSystemVersion() >= 7.0) {
        
        self.edgesForExtendedLayout                                       = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars                             = NO;
        self.modalPresentationCapturesStatusBarAppearance                 = NO;
    }
    else{
        self.navigationController.navigationBar.layer.masksToBounds = YES;
        self.navigationController.navigationBar.clipsToBounds       = YES;
    }
    [self.navigationController.navigationBar setBarTintColor:RGB(63, 88, 152)];
    self.navigationController.navigationBar.backgroundColor = RGB(63, 88, 152);
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBarHidden       = NO;
//    self.navigationController.hidesBottomBarWhenPushed  = YES;
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] withSize:CGSizeMake(640, 100)];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setNeedsLayout];
//
//    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    

        NSDictionary *dic = @{
//                              UITextAttributeFont:[UIFont systemFontOfSize:JZNavBarTitleFontSize],
                              UITextAttributeTextColor : [UIColor whiteColor]
//                              UITextAttributeTextColor:RGB(52, 63, 83),
//                              UITextAttributeTextShadowColor:[UIColor clearColor]
                              };
    self.navigationController.navigationBar.titleTextAttributes = dic;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (self.autoLoadLeftNavBtn) {
        if (self.navigationController.viewControllers.count > 1 || self.presentingViewController) {
            self.navigationItem.leftBarButtonItem = [self leftBarButtonWithStyle:JZNavBarStyleBack];
        }
        else{
            self.navigationItem.leftBarButtonItem = [self leftBarButtonWithStyle:JZNavBarStylePersonalCneter];
        }
    }

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    // Do any additional setup after loading the view.
}

- (UIBarButtonItem *)leftBarButtonWithStyle:(JZNavBarStyle)barStyle
{
    self.leftNavBarStyle = barStyle;
    NSString *title = nil;
//    if (barStyle == JZNavBarStyleBack) {
//        
//        NSInteger indexInPushController = [self.navigationController.viewControllers indexOfObject:self];
//        if (indexInPushController > 0 && self.navigationController.viewControllers.count > indexInPushController) {
//            title = ((UIViewController *)self.navigationController.viewControllers[indexInPushController - 1]).title;
//        }
//    }
    UIBarButtonItem *barButton = [[self class] navBarButtonWithStyle:barStyle title:title position:JZNavCustomButtonLeft target:self action:@selector(leftNavButtonClicked:)];
    YNavCustomButton *customBtn = (YNavCustomButton *)barButton.customView;

    // 改变图标大小
    [self navBarCustomWithButtom:customBtn atPosition:JZNavCustomButtonLeft];
    return barButton;
}

- (NSArray *)leftBarButtonsWithStyles:(NSArray *)barStyles
{
    self.leftNavBarStyle = [barStyles[0] integerValue];
    
    NSMutableArray *items = [NSMutableArray new];
    for (int i = 0; i < barStyles.count; i ++) {
        
        UIBarButtonItem *item = [[self class] navBarButtonWithStyle:[barStyles[i] integerValue] title:nil position:JZNavCustomButtonLeft target:self action:@selector(leftNavButtonClicked:)];
        item.customView.tag = i + 100;
        [items addObject:item];
    }
    return items;
}

- (void)leftNavButtonClicked:(UIButton *)button
{
    if (self.navigationController.viewControllers.count > 1 || self.presentingViewController)
    {
        if (self.presentVc) {
            [self dismissViewControllerForPresentVc];
        }
        else if (self.navigationController.viewControllers.count > 1) {
            [self popView];
        }
        else{
            [self dismissView];
        }
    }
    else{
      
    }
}

- (void)leftNavButtonClickedForNoAnimation:(UIButton *)button
{
    if (self.navigationController.viewControllers.count > 1 || self.presentingViewController)
    {
        if (self.navigationController.viewControllers.count > 1) {
            [self popViewWithNoAnimation];
        }
        else{
            [self dismissViewWithNoAnimation];
        }
    }
    else{
      
    }
}

- (UIBarButtonItem *)rightBarButtonWithStyle:(JZNavBarStyle)barStyle
{
    self.rightNavBarStyle = barStyle;
    UIBarButtonItem *barButton = [[self class] navBarButtonWithStyle:barStyle
                                                               title:nil
                                                            position:JZNavCustomButtonRight
                                                              target:self
                                                              action:@selector(rightNavButtonClicked:)];
    YNavCustomButton *customBtn = (YNavCustomButton *)barButton.customView;

    // 改变图标大小
    [self navBarCustomWithButtom:customBtn atPosition:JZNavCustomButtonRight];
    return barButton;
}

- (NSArray *)rightBarButtonsWithStyles:(NSArray *)barStyles
{
    self.rightNavBarStyle = [barStyles[0] integerValue];
    
    NSMutableArray *items = [NSMutableArray new];
    for (int i = 0; i < barStyles.count; i ++) {
        
        UIBarButtonItem *item = [[self class] navBarButtonItemsWithStyle:[barStyles[i] integerValue]
                                                              title:nil
                                                           position:JZNavCustomButtonRight
                                                             target:self
                                                             action:@selector(rightNavButtonClicked:)];
        item.customView.tag = i + 200;
        YNavCustomButton *customBtn = (YNavCustomButton *)item.customView;
        
        // 改变图标大小
        [self navBarCustomWithButtom:customBtn atPosition:JZNavCustomButtonRight];
        [items addObject:item];
    }
    return items;
}

- (void)rightNavButtonClicked:(UIButton *)button
{
    // implemention in sub controller.
}

- (void)defaultControllerSetting
{
//    self.view.backgroundColor = RGB(236, 240, 243);
}

- (void)navBarCustomWithButtom:(YNavCustomButton *)customButton atPosition:(JZNavCustomButtonPosition)position
{
    // implement by sub controllers ..
    // example code .
    /*
    if (position == JZNavCustomButtonLeft) {
        
        switch (self.leftNavBarStyle) {
            case JZNavBarStyleBack: {
                
                [customButton setImage:[[UIImage imageNamed:@"back_hei"] tintColorWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                CGFloat imgOffset   = 0;
                CGFloat titleOffset = 0;
                customButton.width = 30;
                [customButton setImageEdgeInsets:UIEdgeInsetsMake(8.0, -imgOffset, 8.0, imgOffset)];
                [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -titleOffset, 0.0, titleOffset)];
                [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } break;
            default: {
                
            } break;
        }
    }
    else{
        customButton.clipsToBounds = NO;
        customButton.width = 30;
        switch (self.rightNavBarStyle) {
            case JZNavBarStyleBackText: {
                
                CGFloat imgOffset   = -5;
                CGFloat titleOffset = -5;
                customButton.titleLabel.font = [UIFont systemFontOfSize:15];
                customButton.width = 45;
                [customButton setImageEdgeInsets:UIEdgeInsetsMake(4, -imgOffset, 4, imgOffset)];
                [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -titleOffset, 0.0, titleOffset)];
                [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } break;
                
            default: {
                
                CGFloat imgOffset   = 0;
                CGFloat titleOffset = 5;
                [customButton setImageEdgeInsets:UIEdgeInsetsMake(4, -imgOffset, 4, imgOffset)];
                [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -titleOffset, 0.0, titleOffset)];
            } break;
        }
    }
     */
}

@end


@implementation UIViewController (NavigationBarHelp)

+ (UIBarButtonItem *)navBarButtonWithStyle:(JZNavBarStyle)barStyle title:(NSString *)title position:(JZNavCustomButtonPosition)position target:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc]initWithCustomView:[self navCustomButtonWithStyle:barStyle title:title position:position target:target
                                                                              action:action]];
}

+ (UIButton *)navCustomButtonWithStyle:(JZNavBarStyle)barStyle title:(NSString *)title position:(JZNavCustomButtonPosition)position target:(id)target action:(SEL)action
{
    NSString *imageName;
    NSString *highlightedImgName;
    
    switch (barStyle) {
        case JZNavBarStyleBack: {
            imageName          = @"back_hei";
            highlightedImgName = @"back_hei";
        } break;
        case JZNavBarStyleRefresh: {
            imageName          = @"xiaoxi-refresh-";
            highlightedImgName = @"xiaoxi-refresh-s-";
        } break;
        case JZNavBarStyleMenu: {
            imageName          = @"wenjian-more-";
            highlightedImgName = @"wenjian-more-s-";
        } break;
        case JZNavBarStyleAddFriend: {
            imageName = @"nav_btn_add";
        } break;
        case JZNavBarStylePersonalCneter: {
            imageName          = @"moren-@2X";
            highlightedImgName = @"dianji-@2x";
        } break;
        case JZNavBarStyleOK: {
            imageName = @"nav_btn_right";
        } break;
        case JZNavBarStylePlus: {
            imageName          = @"plus";
            highlightedImgName = @"plus";
        } break;
        case JZNavBarStyleSeek: {
            imageName = @"nav_btn_search";
        } break;
        case JZNavBarStyleSet: {
            imageName          = @"btn_set_f";
            highlightedImgName = @"btn_set_s";
        } break;
        case JZNavBarStyleGo: {
            imageName = @"nav_btn_next";
        } break;
        case JZNavBarStyleCollect: {
            imageName          = @"btn_title_collect_cancle_f";
            highlightedImgName = @"btn_title_collect_sure_s";
        } break;
        case JZNavBarStyleCollectOk: {
            imageName          = @"btn_title_collect_sure_f";
            highlightedImgName = @"btn_title_collect_sure_s";
        } break;
        case JZNavBarStyleShare: {
            imageName          = @"btn_titile_share_f";
            highlightedImgName = @"btn_titile_share_s";
        } break;
        case JZNavBarStyleDelete: {
            imageName          = @"btn_delete_f";
            highlightedImgName = @"btn_delete_s";
        } break;
        case JZNavBarStyleWaterFlow: {
            imageName          = @"waterflow";
            highlightedImgName = @"waterflow";
        } break;
        case JZNavBarStyleTable: {
            imageName          = @"table";
            highlightedImgName = @"table";
        } break;
        case JZNavBarStyleSend: {
            imageName          = @"send_blue";
            highlightedImgName = @"send_blue";
        } break;
        case JZNavBarStyleSearchIcon: {
            imageName          = @"search_icon";
            highlightedImgName = @"search_icon";
        } break;
        case JZNavBarStyleClose: {
            imageName          = @"btn_close_f";
            highlightedImgName = @"btn_close_s";
        } break;
        case JZNavBarStyleEquipementManagedOpen: {
            imageName          = @"equiOpen@3x";
            highlightedImgName = @"equiOpen@3x";
        } break;
        case JZNavBarStyleEquipementManagedClose: {
            imageName          = @"equiClose@3x";
            highlightedImgName = @"equiClose@3x";
        } break;
        case JZNavBarStyleAdd: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"添加"];
        } break;
        case JZNavBarStyleExit: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"关闭"];
        } break;
        case JZNavBarStyleSubmit: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"提交"];
        } break;
        case JZNavBarStyleDynamic: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"帖子"];
        } break;
        case JZNavBarStyleReport: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"发表"];
        } break;
        case JZNavBarStyleSave: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"保存"];
        } break;
        case JZNavBarStyleEdit: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"编辑"];
        } break;
        case JZNavBarStyleDone: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"完成"];
        } break;
        case JZNavBarStyleClassify: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"分类"];
        } break;
        case JZNavBarStyleTradePlus: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"贸易＋"];
        } break;
        case JZNavBarStyleSearch: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"搜索"];
        } break;
        case JZNavBarStyleCancel: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"取消"];
        } break;
        case JZNavBarStyleEquipmentDescription: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"设备详情"];
        } break;
        case JZNavBarStyleCancelOrder: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"取消订单"];
        } break;
        case JZNavBarStyleSort: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"排序"];
        } break;
        case JZNavBarStyleBackText: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"搜索"];
        } break;
        case JZNavBarStyleAddAddress: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"新增地址"];
        } break;
        case JZNavBarStylePresenceConsulation: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@"发表咨询"];
        } break;
        case JZNavBarStyleEmpty: {
            return [self navCustomButtonWithNormalImage:nil highlightedImage:nil position:position target:target action:action title:@""];
        } break;
            
        default: {
            imageName = @"";
        }
            break;
    }
    imageName = [[self class] configureImageNameForSystemVerison:imageName];
    highlightedImgName = [[self class] configureImageNameForSystemVerison:highlightedImgName];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"WPsdInternal" ofType:@"bundle"]];
    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png" inDirectory:@"Images"];
    if (imagePath) {
        
        NSString *highlightedImagePath = [bundle pathForResource:highlightedImgName ofType:@"png" inDirectory:@"Images"];
        return [self navCustomButtonWithNormalImage:[UIImage imageWithContentsOfFile:imagePath]
                                   highlightedImage:[UIImage imageWithContentsOfFile:highlightedImagePath]  position:position target:target
                                             action:action title:title];
    }
    else{
        return [self navCustomButtonWithNormalImage:[UIImage imageNamed:imageName]
                               highlightedImage:[UIImage imageNamed:highlightedImgName]  position:position target:target
                                         action:action title:title];
    }
}

+ (UIButton *)navCustomButtonWithNormalImage:(UIImage *)image
                            highlightedImage:(UIImage *)highlightedImg
                                    position:(JZNavCustomButtonPosition)position
                                      target:(id)target
                                      action:(SEL)action
                                       title:(NSString *)title
{
    YNavCustomButton *customBtn = [[YNavCustomButton alloc] initWithFrame:CGRectZero position:position];
    [customBtn setTitle:title forState:UIControlStateNormal];
    customBtn.titleLabel.font = [UIFont systemFontOfSize:JZNavBarItemFontSize];
    [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customBtn setTitleColor:RGB(44, 159, 252) forState:UIControlStateHighlighted];
    [customBtn setTitleColor:RGB(44, 159, 252) forState:UIControlStateSelected];
    [customBtn setImage:image forState:UIControlStateNormal];
    [customBtn setImage:highlightedImg forState:UIControlStateHighlighted];
    [customBtn setImage:highlightedImg forState:UIControlStateSelected];
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGFloat barItemHeight = 44;
    CGFloat width = [customBtn.titleLabel.text sizeWithFont:customBtn.titleLabel.font constrainedToSize:CGSizeMake(100, barItemHeight) lineBreakMode:NSLineBreakByCharWrapping].width - 5;
    (width + image.size.width > 50)? (width += 20,width += image.size.width) : (width = 50);
    customBtn.frame = CGRectMake(0, 0, width, barItemHeight);
    customBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    return customBtn;
}

+ (UIBarButtonItem *)navBarButtonItemsWithStyle:(JZNavBarStyle)barStyle title:(NSString *)title position:(JZNavCustomButtonPosition)position target:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc]initWithCustomView:[self navCustomButtonItemsWithStyle:barStyle title:title position:position target:target
                                                                                   action:action]];
}

+ (UIButton *)navCustomButtonItemsWithStyle:(JZNavBarStyle)barStyle title:(NSString *)title position:(JZNavCustomButtonPosition)position target:(id)target action:(SEL)action
{
    NSString *imageName;
    NSString *highlightedImgName;
    switch (barStyle) {
        case JZNavBarStyleBack: {
            imageName          = @"return1.png";
            highlightedImgName = @"return1.png";
        } break;
        case JZNavBarStyleAddFriend: {
            imageName = @"nav_btn_add";
        } break;
        case JZNavBarStyleMenu: {
            imageName          = @"btn_menu_f";
            highlightedImgName = @"btn_menu_s";
        } break;
        case JZNavBarStyleOK: {
            imageName = @"nav_btn_right";
        } break;
        case JZNavBarStylePlus: {
            imageName = @"nav_btn_friend";
        } break;
        case JZNavBarStyleSeek: {
            imageName = @"nav_btn_search";
        } break;
        case JZNavBarStyleSet: {
            imageName          = @"btn_set_f";
            highlightedImgName = @"btn_set_s";
        } break;
        case JZNavBarStyleGo: {
            imageName = @"nav_btn_next";
        } break;
        case JZNavBarStylePersonalCneter: {
            imageName          = @"btn_menu_profile_f";
            highlightedImgName = @"btn_menu_profile_s";
        } break;
        case JZNavBarStyleCollect: {
            imageName          = @"btn_title_collect_cancle_f";
            highlightedImgName = @"btn_title_collect_cancle_s";
        } break;
        case JZNavBarStyleCollectOk: {
            imageName          = @"btn_title_collect_sure_f";
            highlightedImgName = @"btn_title_collect_sure_s";
        } break;
        case JZNavBarStyleShare: {
            imageName          = @"btn_titile_share_f";
            highlightedImgName = @"btn_titile_share_s";
        } break;
        case JZNavBarStyleDelete: {
            imageName          = @"btn_delete_f";
            highlightedImgName = @"btn_delete_s";
        } break;
        case JZNavBarStyleClose: {
            imageName          = @"btn_close_f";
            highlightedImgName = @"btn_close_s";
        } break;
        case JZNavBarStyleSend: {
            imageName          = @"send_white";
            highlightedImgName = @"send_white";
        } break;
        case JZNavBarStyleSearchIcon: {
            imageName          = @"search_icon";
            highlightedImgName = @"search_icon";
        } break;
        default: {
            imageName = @"";
        }
            break;
    }
    imageName = [[self class] configureImageNameForSystemVerison:imageName];
    highlightedImgName = [[self class] configureImageNameForSystemVerison:highlightedImgName];
    highlightedImgName = [[self class] configureImageNameForSystemVerison:highlightedImgName];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"WPsdInternal" ofType:@"bundle"]];
    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png" inDirectory:@"Images"];
    if (imagePath) {
        
        NSString *highlightedImagePath = [bundle pathForResource:highlightedImgName ofType:@"png" inDirectory:@"Images"];
        return [self navCustomButtonItemsWithNormalImage:[UIImage imageWithContentsOfFile:imagePath]
                                        highlightedImage:[UIImage imageWithContentsOfFile:highlightedImagePath]  position:position target:target
                                                  action:action title:title];
    }
    else{
        return [self navCustomButtonItemsWithNormalImage:[UIImage imageNamed:imageName]
                                    highlightedImage:[UIImage imageNamed:highlightedImgName]  position:position target:target
                                              action:action title:title];
    }
}

+ (UIButton *)navCustomButtonItemsWithNormalImage:(UIImage *)image
                                 highlightedImage:(UIImage *)highlightedImg
                                         position:(JZNavCustomButtonPosition)position
                                           target:(id)target
                                           action:(SEL)action
                                            title:(NSString *)title
{
    YNavCustomButtons *customBtn = [[YNavCustomButtons alloc] initWithFrame:CGRectZero position:position];
    [customBtn setTitle:title forState:UIControlStateNormal];
    customBtn.titleLabel.font = [UIFont systemFontOfSize:JZNavBarItemFontSize];
    [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customBtn setTitleColor:RGB(44, 159, 252) forState:UIControlStateHighlighted];
    [customBtn setTitleColor:RGB(44, 159, 252) forState:UIControlStateSelected];
    [customBtn setImage:image forState:UIControlStateNormal];
    [customBtn setImage:highlightedImg forState:UIControlStateHighlighted];
    [customBtn setImage:highlightedImg forState:UIControlStateSelected];
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGFloat barItemHeight = 44;
    CGFloat width = [customBtn.titleLabel.text sizeWithFont:customBtn.titleLabel.font constrainedToSize:CGSizeMake(100, barItemHeight) lineBreakMode:NSLineBreakByCharWrapping].width - 5;
    (width + image.size.width > 50)? (width += 20,width += image.size.width) : (width = 50);
    customBtn.frame = CGRectMake(0, 0, width, barItemHeight);
    customBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    return customBtn;
}

+ (NSString *)configureImageNameForSystemVerison:(NSString *)name
{
    NSString *imgName = name;
    if (currentSystemVersion() >= 8) {
        imgName = [imgName stringByAppendingString:@""];
    }
    return imgName;
}

+ (UIImage *)_fillImage:(UIImage *)image
{
    if (image) {
//        if (currentSystemVersion() < 7) {
//            image = [UIImage imageWithImage:image withSize:CGSizeMake(26, 26)];
//        }
//        else{
//            image = [UIImage imageWithImage:image withSize:CGSizeMake(26, 26)];
//        }
    }
    return image;
}

@end

@implementation UIViewController (AFNetWork)

- (void)closeAFNetWork
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    [[JZHTTPClient sharedClient].operationQueue cancelAllOperations];
}

//- (void)recordInvalideNetWorkAlertCount
//{
//    NSUInteger count = [self currentInvalideNetWorkAlertCount];
//    count ++;
//    [[NSFileManager defaultManager] createFileAtPath:UnReachiableNetWorkAlertCountArchivePath contents:[NSKeyedArchiver archivedDataWithRootObject:[NSNumber numberWithInteger:count]] attributes:nil];
//}
//
//- (NSInteger)currentInvalideNetWorkAlertCount
//{
//    NSNumber *count = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSFileManager defaultManager] contentsAtPath:UnReachiableNetWorkAlertCountArchivePath]];
//    if (count != nil) {
//        return [count integerValue];
//    }
//    else{
//        return 0;
//    }
//}
//
//- (void)resetInvalideNetWorkAlertCount
//{
//    NSInteger number = 0;
//    [[NSFileManager defaultManager] createFileAtPath:UnReachiableNetWorkAlertCountArchivePath contents:[NSKeyedArchiver archivedDataWithRootObject:[NSNumber numberWithInteger:number]] attributes:nil];
//}

@end

