//
//  JZBaseTableViewController.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZBaseTableViewController.h"
#import "NSString+Extension.h"
#import "JZMacro.h"
#import "UIView+Category.h"
// JFSegmentedBarController Addition!...
//#import "JFSegmentedBarController.h"

@interface JZBaseTableViewController () //<SRRefreshDelegate>

@property (nonatomic, strong, readwrite) NSString *offset;

@end

@implementation JZBaseTableViewController
{
    CGFloat _panBeganRange;
}

@synthesize
//refreashView = _refreashView,
isUseArchive = _isUseArchive,
headPanel = _headPanel,
footPanel = _footPanel,
upRefreshButton = _upRefreshButton;

- (id)init
{
    if (self = [super init]) {
        
        self.enablePullUpToRefreshBeforeLoadText = @" 刷新更多 ";
        self.enablePullUpToRefreshLoadingText    = @" 正在载入... ";
        self.enablePullUpToRefreshNilDataText    = @" 没有更多 ";
        self.enableNilModelsAlertTest            = @"";
        self.isUseArchive = NO;
        self.slimeColor = RGB(214, 0, 217);
        _refreshControllerTintColor = RGB(100, 106, 125);
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.separatorColor = [UIColor clearColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if (self.enablePullDownToRefresh) {
        
//        _refreashView = [[YRefresh alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 60)];
//        __weak typeof(self) weakSelf = self;
//        _refreashView.beginRefresh = ^{
//            [weakSelf beginRefresh];
//        };
//        [self.tableView insertSubview:_refreashView atIndex:0];
        
        self.refreshController = [[UIRefreshControl alloc] init];
        [_refreshController addTarget:self action:@selector(beginRefresh) forControlEvents:UIControlEventValueChanged];
        _refreshController.tintColor = _refreshControllerTintColor;
        [self.tableView addSubview:_refreshController];
#if DEBUG
//        NSLog(@"%f, %f", _refreashView.top, _refreashView.height);
#endif
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
        self.tableView.tableFooterView = [self productedRefreashButtonWithHasMore:self.hasMore offset:currentOffset cuurentCount:[models count]];
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
        [self.tableView reloadData];
        return;
    }
    else {
        if (self.isUseArchive == YES && [self.offset isEqualToString:@"0"]) {
            [self archiveCurrentList];
        }
    }
    if (currentOffset) {
        self.currentOffSet = currentOffset;
    }
    else{
        self.currentOffSet = self.offset;
    }
    self.view.alert = nil; // < implemented extension viewController category
    
    [self.tableView reloadData];
}

- (void)fetchFailedWithError:(NSError *)error
{
    if (self.enablePullDownToRefresh) {
        [self stopRefresh];
    }
    if (self.isUseArchive == YES && [self.offset isEqualToString:@"0"]) {
        [self loadArchiveList];
    }
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
    //..
    [self beginRefresh];
}

- (void)stopRefresh
{
    [_refreashView stopRfresh];
    if (_enablePullDownToRefresh && _refreshController.refreshing) {
        [_refreshController endRefreshing];
    }
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
    _upRefreshButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 20)];
    _upRefreshButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _upRefreshButton.backgroundColor = [UIColor clearColor];
    _upRefreshButton.titleLabel.layer.masksToBounds = YES;
//    _upRefreshButton.titleLabel.layer.borderColor = RGB(156, 156, 156).CGColor;
//    _upRefreshButton.titleLabel.layer.borderWidth = 1;
//    _upRefreshButton.titleLabel.layer.cornerRadius = 8;
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
- (void)configureCell:(UITableViewCell<JZModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath
{
    [super configureCell:cell forIndexPath:indexPath];
    JZModelCell *modelCell = (JZModelCell *)cell;
    modelCell.idx = indexPath.row;
    modelCell.sectionIdx = indexPath.section;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.models count] - 1 && self.enablePullUpToRefresh) {
        if (self.hasMore && self.upPushType == JZUpPushToRefreshTypeNormal) {
            
            [_upRefreshButton setTitle:_enablePullUpToRefreshLoadingText forState:UIControlStateNormal];
            [self beginUpPushToRefreshing];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SRRefreash Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreashView scrollDidScroll:scrollView];
}
//
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreashView scrollDidEndDragging:scrollView];
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

- (void)archiveCurrentList
{
    [self archiveListWithPath:[sandBoxPath stringByAppendingPathComponent:NSStringFromClass([self class])] models:self.models];
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

@implementation JZBaseTableViewController (internet)

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
