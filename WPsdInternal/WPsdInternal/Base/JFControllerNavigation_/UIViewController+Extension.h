//
//  JZBaseViewController+Extension.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YNavCustomButton.h"


/**
     导航基础类默认设置导航 title 的字体大小
 */
#define JZNavBarTitleFontSize 18.5

/**
     导航基础类默认设置 UIBarButtonItem 按钮的字体大小
 */
#define JZNavBarItemFontSize  15

/**
     代表所有现实的自定义按钮的枚举，一个枚举值对应了一个自定义按钮样式。
 */
enum
{
    JZNavBarStyleEmpty  = 0,  //    空白，没有效果
    JZNavBarStyleGo,  //            🐶的图标
    JZNavBarStyleOK,  //            OK
    JZNavBarStyleSet,  //           设置
    JZNavBarStyleAdd,  //           添加
    JZNavBarStyleEdit   = 5,  //    编辑

    JZNavBarStyleDone,  //          Done
    JZNavBarStyleBack,  //          返回🐰
    JZNavBarStyleBackText,//        返回
    JZNavBarStyleExit,  //          关闭
    JZNavBarStyleSeek   = 10,  //   寻求
    
    JZNavBarStylePlus,  //              ➕
    JZNavBarStyleSave,  //              保存
    JZNavBarStyleSort,  //              分类
    JZNavBarStyleMenu,  //              菜单
    JZNavBarStyleShare  = 15,  //       共享
    
    JZNavBarStyleClose,  //              关闭
    JZNavBarStyleTable,  //              列表
    JZNavBarStyleSubmit,  //             提交
    JZNavBarStyleCancel,  //             取消
    JZNavBarStyleDelete = 20,   //       删除
    
    JZNavBarStyleReport,    //                   报告
    JZNavBarStyleCollect,   //                   收藏
    JZNavBarStyleRefresh,    //                  刷新
    JZNavBarStyleCollectOk,  //                  已收藏
    JZNavBarStyleAddFriend,   //                 添加朋友
    JZNavBarStyleWaterFlow,    //                瀑布流
    JZNavBarStyleAddAddress,   //                添加地址
    JZNavBarStyleCancelOrder,   //               取消订单
    JZNavBarStylePersonalCneter = 29,     //     个人中心
    JZNavBarStylePresenceConsulation,     //     发表咨询
    JZNavBarStyleEquipmentDescription,    //     设备详情
    JZNavBarStyleEquipementManagedOpen,   //     设备管理打开
    JZNavBarStyleEquipementManagedClose,  //     设备管理关闭
    JZNavBarStyleClassify,    //                 分类
    JZNavBarStyleTradePlus,   //                 贸易＋
    JZNavBarStyleSend,    //                     发送
    JZNavBarStyleSearch,   //                    搜索
    JZNavBarStyleSearchIcon,  //                 搜索 🐰
    JZNavBarStyleDynamic,  //                    动态
};

typedef NSInteger JZNavBarStyle;




/**
 *     控制器的切换简写方法类别
 */
@interface UIViewController (Extension)

/**
 *     设置导航块（UINavigationBar）隐藏
 *
 *     @param hidde 是否隐藏 YES真 NO假
 */
- (void)setNavigationBarHidde:(BOOL)hidde;

/**
 *     谈起和弹回视图控制器的方法简写。
 */
- (void)presentViewController:(UIViewController *)controller;
- (void)presentViewControllerWithNoAnimation:(UIViewController *)controller;
- (void)dismissView;
- (void)dismissViewWithNoAnimation;

/**
 *     推出和退回视图控制器的方法简写。
 */
- (void)pushViewController:(UIViewController *)controller;
- (void)pushViewControllerWithNoAnimation:(UIViewController *)controller;
- (void)popView;
- (void)popViewWithNoAnimation;
- (void)popToRoot;
- (void)popToRootWithNoAnimation;

@end




/**
 *     控制器的附加弹窗效果切换简写方法类别
 */
@interface UIViewController (presentViewController)

@property (nonatomic, strong) UIViewController *presentVc;
@property (nonatomic, strong) UIImage *presentCapture;
@property (nonatomic, assign) CGRect presentRect;

/**
 *     切换效果的方法
 *
 *     @param controller 被切换的控制器
 *     @param view       被切换动画的视图
 *     @param transform  切换动画过度时的图片对象
 */
- (void)presentViewController:(UIViewController *)controller withAnimationView:(UIView *)view withTransformImage:(UIImage *)transform;

@end




/**
 *     @author king Yan, 16-08-16 14:08:13
 *
 *     设置导航按钮方法的基础类别
 */
@interface UIViewController (NavigationControler)


/**
 *     记录左边导航按钮的枚举类型
 */
@property (nonatomic, assign) JZNavBarStyle leftNavBarStyle;

/**
 *     记录右边导航按钮的枚举类型
 */
@property (nonatomic, assign) JZNavBarStyle rightNavBarStyle;

/**
 *     设置是否自动加载昨天的导航按钮对象，如果自动加载时在左边的导航按钮位置至少存在一个导航自定义按钮的对象。
 */
@property (nonatomic, assign) BOOL autoLoadLeftNavBtn;

/**
 *     返回左边导航自定义按钮的方法
 *
 *     @param barStyle 通过枚举返回对应的按钮样式
 *
 *     @return 被设置好的导航按钮对象
 */
- (UIBarButtonItem *)leftBarButtonWithStyle:(JZNavBarStyle)barStyle __attribute__((objc_requires_super));

/**
 *     返回左边导航自定义按钮数组的方法
 *
 *     @param barStyles 通过枚举数组返回对应的样式
 *
 *     @return 被设置好的导航按钮对象数组
 */
- (NSArray *)leftBarButtonsWithStyles:(NSArray *)barStyles;

/**
 *     返回右边导航自定义按钮的方法
 *
 *     @param barStyle 通过枚举返回对应的按钮样式
 *
 *     @return 被设置好的导航按钮对象
 */
- (UIBarButtonItem *)rightBarButtonWithStyle:(JZNavBarStyle)barStyle;
/**
 *     返回右边导航自定义按钮数组的方法
 *
 *     @param barStyles 通过枚举数组返回对应的样式
 *
 *     @return 被设置好的导航按钮对象数组
 */
- (NSArray *)rightBarButtonsWithStyles:(NSArray *)barStyles;

/**
 *     复写方法接收左边自定义按钮的点击事件，默认会返回上一级控制器。
 */
- (void)leftNavButtonClicked:(UIButton *)button;

/**
 *     复写方法接收左边自定义按钮的点击事件，默认返回上一级控制器时没有动画效果。
 */
- (void)leftNavButtonClickedForNoAnimation:(UIButton *)button;

/**
 *     复写方法接收右边自定义按钮的点击事件。
 */
- (void)rightNavButtonClicked:(UIButton *)button;

/**
 *     在工程项目基础控制器类中默认调用该方法来实现对导航控制器的默认设置。
 */
- (void)defaultNavigationControllerSetting;

/**
 *     在工程项目基础控制器类中默认调用该方法来实现对控制器类的默认设置。
 */
- (void)defaultControllerSetting;

/**
 *     复写该方法用于在自定义导航按钮被初始设置好之后修改按钮属性
 */
- (void)navBarCustomWithButtom:(YNavCustomButton *)customButton atPosition:(JZNavCustomButtonPosition)position;


@end




/**
 *    辅助设置导航按钮方法的基础类别，返回自定义 YNavCustomButton 的按钮，属于被该类别调用的类和方法，一般不被使用。要是想用这个方法返回自定义按钮也可以。
 */
@interface UIViewController (NavigationBarHelp)

+ (UIBarButtonItem *)navBarButtonWithStyle:(JZNavBarStyle)barStyle
                                     title:(NSString *)title
                                  position:(JZNavCustomButtonPosition)position
                                    target:(id)target
                                    action:(SEL)action;

+ (UIButton *)navCustomButtonWithStyle:(JZNavBarStyle)barStyle
                                 title:(NSString *)title
                              position:(JZNavCustomButtonPosition)position
                                target:(id)target
                                action:(SEL)action;

+ (UIButton *)navCustomButtonWithNormalImage:(UIImage *)image
                            highlightedImage:(UIImage *)highlightedImg
                                    position:(JZNavCustomButtonPosition)position
                                      target:(id)target action:(SEL)action
                                       title:(NSString *)title;

+ (UIBarButtonItem *)navBarButtonItemsWithStyle:(JZNavBarStyle)barStyle title:(NSString *)title position:(JZNavCustomButtonPosition)position target:(id)target action:(SEL)action;

+ (UIButton *)navCustomButtonItemsWithStyle:(JZNavBarStyle)barStyle title:(NSString *)title position:(JZNavCustomButtonPosition)position target:(id)target action:(SEL)action;

+ (UIButton *)navCustomButtonItemsWithNormalImage:(UIImage *)image
                                 highlightedImage:(UIImage *)highlightedImg
                                         position:(JZNavCustomButtonPosition)position
                                           target:(id)target
                                           action:(SEL)action
                                            title:(NSString *)title;

+ (NSString *)configureImageNameForSystemVerison:(NSString *)name;

@end





/**
 *     辅助控制器的切换简写方法类别，实现当控制器切换时关闭未完成的 AFNetworing 网络请求和系统状态栏的网络加载状态。
 */
//#define UnReachiableNetWorkAlertCountArchivePath [sandBoxPath stringByAppendingPathComponent:@"invalideNetWork_alertCount"]
@interface UIViewController (AFNetWork)


- (void)closeAFNetWork;

//- (void)recordInvalideNetWorkAlertCount;
//
//- (NSInteger)currentInvalideNetWorkAlertCount;
//
//- (void)resetInvalideNetWorkAlertCount;


@end
