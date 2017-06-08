//
//  JZBaseCollectionViewController.m
//  GSJuZhang
//
//  Created by __Qing__ on 15/1/31.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZBaseCollectionViewController.h"
#import "UIView+Category.h"
#import "JZMacro.h"
#import "NSString+Extension.h"

@interface JZBaseCollectionViewController () //<SRRefreshDelegate>

@property (nonatomic, strong, readwrite) NSString *offset;

@end

@implementation JZBaseCollectionViewController

@synthesize
//refreashView = _refreashView,
isUseArchive = _isUseArchive,
headPanel = _headPanel,
footPanel = _footPanel,
upRefreshButton = _upRefreshButton;

- (id)init
{
    if (self = [super init]) {
        self.enablePullUpToRefreshBeforeLoadText = @" 摸一摸!加载更多 ";
        self.enablePullUpToRefreshLoadingText    = @" 加载更多... ";
        self.enablePullUpToRefreshNilDataText    = @" 没有更多了 ";
        self.enableNilModelsAlertTest            = @"";
        self.isUseArchive = NO;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    if (self.enablePullDownToRefresh) {
        //        _refreashView = [[SRRefreshView alloc] init];
        //        _refreashView.delegate = self;
        //        _refreashView.upInset = 0;
        //        _refreashView.slimeMissWhenGoingBack = YES;
        //        _refreashView.slime.bodyColor = RGB(255, 133, 97);
        //        _refreashView.slime.skinColor = RGB(255, 133, 97);
        //        _refreashView.slime.lineWith = 1;
        //        _refreashView.slime.shadowBlur = 4;
        //        _refreashView.slime.shadowColor = [UIColor clearColor];
        //        [self.tableView addSubview:_refreashView];
    }
}

- (void)fetchDataWithOffset:(NSString *)offset addtional:(id)addtional
{
    self.offset = offset;
}

- (void)finishDataFetchWithModels:(NSArray *)models hasMore:(BOOL)hasMore currentOffset:(NSString *)currentOffset
{
    [self stopRefresh];
    
    if (self.enablePullUpToRefresh) {
        if (hasMore == NO) {
            self.hasMore = hasMore;
        }
        else{
            self.hasMore = (models.count > 0);
        }
//        self.collectionView.tableFooterView = [self productedRefreashButtonWithHasMore:self.hasMore offset:currentOffset cuurentCount:[models count]];
    }
    if ([self.currentOffSet isEqualToString:@"0"]) {
        self.models = [NSMutableArray arrayWithArray:models];
    }
    else if ([self.currentOffSet intValue] > 0) {
        [self.models addObjectsFromArray:models];
    }
    if (!models || [models count] == 0) {
        if (self.models.count == 0) {
            self.view.alert = _enableNilModelsAlertTest;
        }
        [self.collectionView reloadData];
        return;
    }
    else {
        if (self.isUseArchive == YES) {
            [self archiveListWithPath:[sandBoxPath stringByAppendingPathComponent:NSStringFromClass([self class])] models:models];
        }
    }
    if (currentOffset) {
        self.currentOffSet = currentOffset;
    }
    else{
        self.currentOffSet = self.offset;
    }
    self.view.alert = nil; // < implemented extension viewController category
    
    [self.collectionView reloadData];
}

- (void)beginRefresh
{
    self.currentRefreshType = JZRefreshTypeNormal;
    self.offset = @"0";
    self.currentOffSet = @"0";
    [self fetchDataWithOffset:self.offset addtional:nil];
}

- (void)beginDownPushRefreshing
{
    //    self.offset = @"0";
    //    self.currentOffSet = @"0";
    //    self.currentRefreshType = CORefreshTypeDownPush;
    //    _action = [COApiHelp postActionWithRel:COApiRel_Action_DownSelf dataArray:self.coData.postAction];
    //    if (!_action) {
    //        _action = _postaction;
    //    }
    [self fetchDataWithOffset:self.offset addtional:nil];
}

- (void)stopRefresh
{
    //    if (self.enablePullDownToRefresh && _refreashView.loading == YES) {
    //        [_refreashView endRefresh];
    //    }
}

#pragma mark - Table FooterView Make Methods.

- (UIButton *)productedRefreashButtonWithHasMore:(BOOL)hasMore
                                          offset:(NSString *)offset
                                    cuurentCount:(NSUInteger)currentCount
{
    if (!_enablePullUpToRefresh) {
        return nil;
    }
    // maked difference attribute set to display.
    _upRefreshButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 40)];
    _upRefreshButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _upRefreshButton.backgroundColor = self.collectionView.backgroundColor;
    _upRefreshButton.titleLabel.layer.masksToBounds = YES;
    _upRefreshButton.titleLabel.layer.borderColor = RGB(156, 156, 156).CGColor;
    _upRefreshButton.titleLabel.layer.borderWidth = 1;
    _upRefreshButton.titleLabel.layer.cornerRadius = 8;
    [_upRefreshButton setTitleColor:RGB(156, 156, 156) forState:UIControlStateNormal];
    if (hasMore) {
        [_upRefreshButton setTitle:_enablePullUpToRefreshBeforeLoadText forState:UIControlStateNormal];
    }
    else{
        [_upRefreshButton setTitle:_enablePullUpToRefreshNilDataText forState:UIControlStateNormal];
    }
    _upRefreshButton.titleLabel.width = [_upRefreshButton.titleLabel sizeThatFits:CGSizeMake(1000, 50)].width + 30;
    if (hasMore  && self.upPushType == JZUpPushToRefreshTypeTapped) {
        [_upRefreshButton addTarget:self action:@selector(refreashTableBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (([offset isEqualToString:@"0"] || !offset) && currentCount == 0  && self.models.count == 0) {
        return nil;
    }
    return _upRefreshButton;
}

- (void)refreashTableBtnTapped:(UIButton *)sender
{
    [sender setTitle:_enablePullUpToRefreshLoadingText forState:UIControlStateNormal];
    [self beginUpPushToRefreshing];
}

- (void)beginUpPushToRefreshing
{
    //    self.currentRefreshType = CORefreshTypeUpPush;
    self.currentOffSet = [NSString stringWithFormat:@"%lu", self.models.count];
    [self fetchDataWithOffset:self.currentOffSet addtional:nil];
}

#pragma mark - Override Super.

- (void)configureCell:(UICollectionViewCell<JZCollectionModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath
{
    [super configureCell:cell forIndexPath:indexPath];
    JZCollectionViewModelCell *modelCell = (JZCollectionViewModelCell *)cell;
    modelCell.idx = indexPath.row;
    
    // upload.
    if (indexPath.row == [self.models count] - 1 && self.enablePullUpToRefresh) {
        if (self.hasMore && self.upPushType == JZUpPushToRefreshTypeNormal) {
            [_upRefreshButton setTitle:_enablePullUpToRefreshLoadingText forState:UIControlStateNormal];
            [self beginUpPushToRefreshing];
        }
    }
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//  
//}

#pragma mark - SRRefreash Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    [_refreashView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    [_refreashView scrollViewDidEndDraging];
}

//- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
//{
//    [self beginDownPushRefreshing];
//}

#pragma mark - help

- (void)archiveListWithPath:(NSString *)path models:(NSArray *)models
{
    [[NSFileManager defaultManager] createFileAtPath:path contents:[NSKeyedArchiver archivedDataWithRootObject:models] attributes:nil];
}

- (NSArray *)unArchiveListWithPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSFileManager defaultManager] contentsAtPath:path]];
}

- (void)loadArchiveList
{
    if (self.models.count == 0) {
        NSArray *models = [self unArchiveListWithPath:[sandBoxPath stringByAppendingPathComponent:NSStringFromClass([self class])]];
        self.currentOffSet = @"0";
        [self finishDataFetchWithModels:models hasMore:YES currentOffset:@"0"];
    }
}

@end

@implementation JZBaseCollectionViewController (internet)

- (void)fetchDataFailureAtResetFetchWithFetchCount:(NSInteger)fetchCount offset:(NSString *)offset addtional:(id)addtional over:(void (^)())over
{
    if (addtional && [addtional isKindOfClass:[NSString class]] && [((NSString *)addtional) isPureInt]) {
        NSInteger count = [((NSString *)addtional) integerValue];
        if (count < fetchCount) {
            [self fetchDataWithOffset:offset addtional:[NSString stringWithFormat:@"%ld", count + 1]];
        }
        else{
            if (over) {
                over();
            }
        }
    }
    else{
        [self fetchDataWithOffset:offset addtional:@"1"];
    }
}

@end
