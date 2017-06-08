//
//  SelectedItemViewController.m
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "SelectedItemViewController.h"
#import "WEInformationNavBar.h"
#import "SelectedItemCell.h"
#import "APIs.h"
#import "CategoryModel.h"
#import "MainViewController.h"
#import "DynamicPictureListViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface SelectedItemViewController ()

@end

@implementation SelectedItemViewController
{
    WEInformationNavBar *_navBar; //导航栏
}

- (void)loadView
{
    [super loadView];
    
    //居左约束
    UICollectionViewLeftAlignedLayout *leftAlignedLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
    leftAlignedLayout.minimumLineSpacing = 4;                          //最小行间距
    leftAlignedLayout.minimumInteritemSpacing = 4;                     //最小列间距
    leftAlignedLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);  //网格上左下右间距
    self.collectionViewLayout = leftAlignedLayout;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:leftAlignedLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.collectionView];
    
    // should implection after self.collectionView instanced.
    [self loadCellModelMapping];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    self.collectionView.top += _navBar.bottom;
    self.collectionView.height -= _navBar.bottom;
    self.collectionViewLayout.minimumInteritemSpacing = 0;
    self.collectionViewLayout.minimumLineSpacing = 0;
    [self beginRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //NSLog(@"----------------------------------------acccccccc");
    [self performSelector:@selector(updateNavBarRightBtnStyle) withObject:nil afterDelay:0.15];
}

- (void)updateNavBarRightBtnStyle
{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    ani.fromValue = 0;
    ani.toValue = @(M_PI_4);
    ani.duration = 0.15;
    ani.fillMode = kCAFillModeForwards;
    ani.removedOnCompletion = NO;
    [_navBar.rightBtn.layer addAnimation:ani forKey:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    _navBar.rightBtn.transform = CGAffineTransformIdentity;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self exchangeMainCategoryItem];
}

- (void)exchangeMainCategoryItem
{
    NSMutableArray *categorys = [NSMutableArray new];
    for (CategoryModel *model in self.models) {
        if (model.category && ![model.category isEqualToString:@""] && [model.recommend integerValue] == 1) {
            [categorys addObject:model];
        }
    }
//    if (categorys.count > 0) {
//        [((MainViewController *)self.navigationController.viewControllers[0]) exchangeContrllersWithCategorys:categorys];
//    }
}

- (void)setupNavBar
{
    _navBar = [[WEInformationNavBar alloc] init];
    _navBar.backTintColor = [UIColor blackColor];
    _navBar.titleColor = [UIColor blackColor];
    _navBar.lineColor = [UIColor clearColor];
    _navBar.titleView.text = @"全部栏目";
    _navBar.frame = CGRectMake(0, 20, self.view.width, KWENavBarH);
    __weak __typeof(self) weakSelf = self;
    _navBar.leftBlock = ^{
        
    };
    _navBar.rightBlock = ^(UIButton *rightBtn){   //点击导航栏右边按钮
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    UIView *mark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _navBar.width, _navBar.bottom)];
    mark.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mark];
    [self.view addSubview:_navBar];
}

#pragma mark - Override Super

- (void)loadCellModelMapping
{
    [super registerModelClass:[CategoryModel class] mappedCellClass:[SelectedItemCell class] reuseIdentifier:NSStringFromClass([CategoryModel class])];
}

- (void)fetchDataWithOffset:(NSString *)offset addtional:(id)addtional
{
    [super fetchDataWithOffset:offset addtional:addtional];
    
    [[APIs shareInstance] getCategoryListOffset:nil success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *categorys = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSFileManager defaultManager] contentsAtPath:[sandBoxPath stringByAppendingPathComponent:CATEGORY_CONTROLLERS_CACHE_KEY]]];
            for (CategoryModel *category in responseObject) {
                
                category.recommend = @"0";
                for (CategoryModel *model in categorys) {
                    if (category.category && model.category && [category.category isEqualToString:model.category]) {
                        category.recommend = @"1";
                    }
                }
            }
            [super finishDataFetchWithModels:responseObject hasMore:NO currentOffset:offset];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)configureCell:(UICollectionViewCell<JZCollectionModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath
{
    [super configureCell:cell forIndexPath:indexPath];
 
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = self.models[indexPath.row];
    if (!model.recommend || ![model.recommend isEqualToString:@"1"]) {
        model.recommend = @"1";
    }
    else{
        model.recommend = @"0";
    }
    [self.collectionView reloadData];
}

@end
