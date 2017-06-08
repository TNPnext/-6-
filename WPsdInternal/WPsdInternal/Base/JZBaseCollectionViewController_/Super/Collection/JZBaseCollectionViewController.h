//
//  JZBaseCollectionViewController.h
//  GSJuZhang
//
//  Created by __Qing__ on 15/1/31.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZModelCollectionViewController.h"
#import "JZBaseTableViewController.h"

@interface JZBaseCollectionViewController : JZModelCollectionViewController
{
    NSString *_enablePullUpToRefreshLoadingText;
    NSString *_enablePullUpToRefreshBeforeLoadText;
    NSString *_enablePullUpToRefreshNilDataText;
    
    NSString *_enableNilModelsAlertTest;
    
    // extension
    UIView *_headPanel;
    UIView *_footPanel;
}
// default is COUpPushToRefreshTypeNormal.
@property (nonatomic, assign) JZUpPushToRefreshType upPushType;
@property (nonatomic, strong) NSString *currentOffSet;
@property (nonatomic, strong, readonly) NSString *offset;

//@property (nonatomic, strong) SRRefreshView *refreashView;
@property (nonatomic, assign) BOOL enablePullDownToRefresh;
@property (nonatomic, assign) BOOL enablePullUpToRefresh;

@property (nonatomic, strong) NSString *enablePullUpToRefreshLoadingText;     // <设置启用上拉刷新后
@property (nonatomic, strong) NSString *enablePullUpToRefreshBeforeLoadText;  //  在刷新前、刷新时和刷新后刷新控
@property (nonatomic, strong) NSString *enablePullUpToRefreshNilDataText;     //  件分别显示的文字。

@property (nonatomic, strong) NSString *enableNilModelsAlertTest;  // 当数据为0时提示用语
@property (nonatomic, strong) UIButton *upRefreshButton;
@property (nonatomic, assign) BOOL hasMore;

- (void)fetchDataWithOffset:(NSString *)offset addtional:(id)addtional __attribute__((objc_requires_super));
- (void)finishDataFetchWithModels:(NSArray *)models hasMore:(BOOL)hasMore currentOffset:(NSString *)currentOffset __attribute__((objc_requires_super));

- (void)beginRefresh;
- (void)stopRefresh;
- (void)beginDownPushRefreshing __attribute__((objc_requires_super));
- (void)beginUpPushToRefreshing __attribute__((objc_requires_super));

@property (nonatomic, assign) JZRefreshType currentRefreshType;

// extension

@property (nonatomic, strong) UIView *headPanel;
@property (nonatomic, strong) UIView *footPanel;

#pragma mark - extension archive list
@property (nonatomic, assign) BOOL isUseArchive; // default is No.
- (void)archiveListWithPath:(NSString *)path models:(NSArray *)models;
- (NSArray *)unArchiveListWithPath:(NSString *)path;
- (void)loadArchiveList;


@end

@interface JZBaseCollectionViewController (internet)

- (void)fetchDataFailureAtResetFetchWithFetchCount:(NSInteger)fetchCount offset:(NSString *)offset addtional:(id)addtional over:(void(^)())over;

@end
