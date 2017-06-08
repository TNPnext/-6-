//
//  JZBaseTableView.h
//  WPsdInternal
//
//  Created by Kings Yan on 16/9/9.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import "JZModelTableView.h"
#import "JFRefresh.h"
#import "JZBaseTableViewController.h"



/**
 *     该类继承与表格基础类，实现了表格基础类对于获取列表数据的定义、上拉下拉刷新功能的实现和简化获取数据的逻辑和简化对表格数据进行缓存的功能。在与工程项目业务分离的条件下十分贴近与业务的开发代码，很好的节省业务代码开发时间和与业务代码的分离。
 *   该类作为 UIView 的子类，用于 UIView 继承该类使用
 */
@interface JZBaseTableView : JZModelTableView
{
    NSString *_enablePullUpToRefreshLoadingText;
    NSString *_enablePullUpToRefreshBeforeLoadText;
    NSString *_enablePullUpToRefreshNilDataText;
    
    NSString *_enableNilModelsAlertTest;
    
    // extension
    UIView *_headPanel;
    UIView *_footPanel;
    
    UIRefreshControl *_refreshController;
}


/**
 *     上拉刷新的类型，默认 JZUpPushToRefreshTypeNormal （表格滑动到最后一条数据时，自动开始加载下一批表格数据。）
 */
@property (nonatomic, assign) JZUpPushToRefreshType upPushType;

/**
 *     表格数据支持上拉刷新时，配合表格获取列表数据的方法用于区分当前获取列表的批次。初始值0。
 */
@property (nonatomic, strong) NSString *currentOffSet;
@property (nonatomic, copy, readonly) NSString *offset;


/**
 *     表格刷新控件
 */
@property (nonatomic, strong) JFRefresh *refreashView;
@property (nonatomic, strong) UIRefreshControl *refreshController;

/**
 *     定义为当刷新控件是 slime 时才能使用， default is RGB(255, 133, 97).
 */
@property (nonatomic, strong) UIColor *slimeColor;

/**
 *     设置是否开启下拉刷新功能
 */
@property (nonatomic, assign) BOOL enablePullDownToRefresh;

/**
 *     设置是否开启上拉刷新功能
 */
@property (nonatomic, assign) BOOL enablePullUpToRefresh;

@property (nonatomic, strong) NSString *enablePullUpToRefreshLoadingText;     // <设置启用上拉刷新后
@property (nonatomic, strong) NSString *enablePullUpToRefreshBeforeLoadText;  //  在刷新前、刷新时和刷新后刷新控
@property (nonatomic, strong) NSString *enablePullUpToRefreshNilDataText;     //  件分别显示的文字。

@property (nonatomic, strong) NSString *enableNilModelsAlertTest;  // 当数据为0时提示用语

/**
 *      上拉刷新的控件
 */
@property (nonatomic, strong) UIButton *upRefreshButton;

/**
 *     表格数据支持上拉刷新时，
 */
@property (nonatomic, assign) BOOL hasMore;



/**
 *     复写该方法用于获取表格列表数据，并且在获取数据结束之后调用 - (void)finishDataFetchWithModels:(NSArray *)models hasMore:(BOOL)hasMore currentOffset:(NSString *)currentOffset 方法使表格进行刷新数据，
 *
 *     @param offset    当前表格获取列表的批次
 *     @param addtional 附加信息
 */
- (void)fetchDataWithOffset:(NSString *)offset addtional:(id)addtional __attribute__((objc_requires_super));

/**
 *     调用该方法使表格进行刷新界面，结合 - (void)fetchDataWithOffset:(NSString *)offset addtional:(id)addtional 方法一起使用，在 - (void)fetchDataWithOffset:(NSString *)offset addtional:(id)addtional 方法得到表格列表数据之后，再调用该方法让表格进行刷新。
 *
 *     @param models        表格列表数据
 *     @param hasMore       是否有下一批数据
 *     @param currentOffset 这次获取数据的批次
 */
- (void)finishDataFetchWithModels:(NSArray *)models hasMore:(BOOL)hasMore currentOffset:(NSString *)currentOffset __attribute__((objc_requires_super));

/**
 *     通过网络获取数据时，数据获取失败时候调用该方法。
 *
 *     @param error 网络获取失败的 error 对象。
 */
- (void)fetchFailedWithError:(NSError *)error;



/**
 *     刷新
 */
- (void)beginRefresh;

/**
 *     停止刷新
 */
- (void)stopRefresh;

/**
 *     下拉刷新
 */
- (void)beginDownPushRefreshing __attribute__((objc_requires_super));

/**
 *     上拉刷新
 */
- (void)beginUpPushToRefreshing __attribute__((objc_requires_super));

/**
 *     当前控制器刷新的类型
 */
@property (nonatomic, assign) JZRefreshType currentRefreshType;




// extension

/**
 *     tableheader 定义
 */
@property (nonatomic, strong) UIView *headPanel;

/**
 *     tablefooter 定义
 */
@property (nonatomic, strong) UIView *footPanel;



/**
 *     设置在返回表格列表数据失败之后是否显示缓存数据
 */
#pragma mark - extension archive list
@property (nonatomic, assign) BOOL isUseArchive; // default is No.
- (void)archiveListWithPath:(NSString *)path models:(NSArray *)models;
- (NSArray *)unArchiveListWithPath:(NSString *)path;
- (void)archiveCurrentList;
- (void)loadArchiveList;



@end

@interface JZBaseTableView (internet)

- (void)fetchDataFailureAtResetFetchWithFetchCount:(NSInteger)fetchCount offset:(NSString *)offset addtional:(id)addtional over:(void(^)())over;

@end
