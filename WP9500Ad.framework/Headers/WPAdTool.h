//
//  WPAdView.h
//  WPAdSDK
//
//  Created by wpsd on 2016/12/7.
//  Copyright © 2016年 wpsd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AdType){
    kAdTypeInApp     = 0,  //内插屏广告
    kAdTypeBanner    = 2,  //轮播器广告
    kAdTypeSplash    = 7,  //开屏广告
    kAdTypeIFStream  = 8,  //信息流广告
    kAdTypeIFBanner  = 9,  //单张图片广告
    kAdTypeNone      = 100 //不是广告
};

typedef NS_ENUM(NSInteger, EventID){
    AD_EVT_SHOW  = 1000,
    AD_EVT_CLICK = 2000,
    AD_EVT_CLOSE = 3000
};

@class WPAdTool;
@protocol WPAdToolDelegate <NSObject>

/**
 回调广告的展示、点击和关闭事件
 
 @param EvtID 事件ID
 @param param 当前事件对应的广告信息
 */
- (void)onAdEvent:(NSInteger)EvtID withParam:(NSDictionary *)param;

@end

@interface WPAdTool : NSObject

/**
 是否开启开屏广告(默认为NO)
 */
@property (assign, nonatomic, getter=isLaunchAdEnabled) BOOL appLaunchAdEnable;

/**
 是否开启后台进入app时显示的广告(默认为NO)
 */
@property (assign, nonatomic, getter=isAppEnterForgroundAdValid) BOOL appEnterForgroundAdEnable;

@property (weak, nonatomic) id<WPAdToolDelegate> delegate;

/**
 单例

 @return 实例对象
 */
+ (instancetype)shareInstance;

/**
 配置appKey

 @param appKey 官网申请的key值，标识唯一用户
 */
- (void)setAppKey:(NSString *)appKey;

/**
 在控制器中添加广告，广告默认是屏幕宽度，高度为宽度的1/4

 @param containerView 放入广告的容器
 @param adY 广告模块顶部的Y值
 @param adType 广告类型，添加固定广告只支持kAdTypeBanner、kAdTypeIFBanner和kAdTypeIFStream三种广告，传入参数错误会抛异常
 */
- (void)addAdToView:(UIView *)containerView originY:(CGFloat)adY adType:(AdType)adType;

/**
 在控制器中添加广告，广告默认是屏幕宽度，高度为宽度的1/4

 @param containerView 放入广告的容器
 @param adY 广告模块底部的Y值
 @param adType 广告类型，添加固定广告只支持kAdTypeBanner、kAdTypeIFBanner和kAdTypeIFStream三种广告，传入参数错误会抛异常
 */
- (void)addAdToView:(UIView *)containerView bottomY:(CGFloat)adY adType:(AdType)adType;

/*注：以下方法可以多次混合调用，但只会执行最后一次调用*/

/**
 在TableView中添加广告模块

 @param tableView 要加入广告的TableView
 @param row 要将广告插入哪一行
 @param adType 广告类型，tableView广告只支持kAdTypeIFBanner和kAdTypeIFStream两种广告，传入其他参数会抛异常
 */
- (void)addAdToTableView:(UITableView *)tableView row:(NSInteger)row   adType:(AdType)adType;

/**
 在TableView中添加广告模块

 @param tableView 要加入广告的TableView
 @param rows 数组内元素必须为数值或数值字符，否则会抛异常
 @param adType 广告类型，tableView广告只支持kAdTypeIFBanner和kAdTypeIFStream两种广告，传入其他参数会抛异常
 */
- (void)addAdToTableView:(UITableView *)tableView rows:(NSArray *)rows adType:(AdType)adType;

/**
 在TableView中添加广告模块

 @param tableView 要加入广告的TableView
 @param row 广告插入位置的row
 @param section 广告插入位置的section
 @param adType 广告类型，tableView广告只支持kAdTypeIFBanner和kAdTypeIFStream两种广告，传入其他参数会抛异常
 */
- (void)addAdToTableView:(UITableView *)tableView row:(NSInteger)row   section:(NSInteger)section adType:(AdType)adType;

/**
 在TableView中添加广告模块

 @param tableView 要加入广告的TableView
 @param rows 数组内元素必须为数值或数值字符，否则会抛异常
 @param section 广告插入位置的section
 @param adType 广告类型，tableView广告只支持kAdTypeIFBanner和kAdTypeIFStream两种广告，传入其他参数会抛异常
 */
- (void)addAdToTableView:(UITableView *)tableView rows:(NSArray *)rows section:(NSInteger)section adType:(AdType)adType;

@end
