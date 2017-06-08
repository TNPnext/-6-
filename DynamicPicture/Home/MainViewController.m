//
//  MainViewController.m
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "MainViewController.h"
#import "DynamicPictureListViewController.h"
#import "SelectedItemViewController.h"
#import "APIs.h"
#import "CategoryModel.h"
#import "UINavigationBar+style.h"

NSString *CATEGORY_CONTROLLERS_CACHE_KEY = @"CATEGORY_CACHE_KEY";

@interface MainViewController ()

@end

@implementation MainViewController

- (void)mainBaseScrollViewScollEndableNotification:(NSNotification *)notification
{
    BOOL flag = [notification.object boolValue];
    self.segmentedBarController.scrollView.scrollEnabled = !flag;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"videoslider" object:nil];
}

- (void)loadView
{
    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainBaseScrollViewScollEndableNotification:) name:@"videoslider" object:nil];
    
    self.navigationController.navigationBarHidden = YES;
    
    NSArray *controllers = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSFileManager defaultManager] contentsAtPath:[sandBoxPath stringByAppendingPathComponent:CATEGORY_CONTROLLERS_CACHE_KEY]]];
    
    if (!controllers || controllers.count == 0) {
        [self fetchData];
    }
    else{
        [self exchangeContrllersWithCategorys:controllers];
    }
}

- (void)exchangeContrllersWithCategorys:(NSArray *)categorys
{
    if (!categorys || categorys.count == 0) {
        return;
    }
    if (_segmentedBarController) {
    
        [_segmentedBarController.view removeFromSuperview];
        [_segmentedBarController removeFromParentViewController];
    }
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    NSMutableArray *titles = [NSMutableArray new];
    NSMutableArray *selectedCategorys = [NSMutableArray new];
    BOOL isContain = NO;
    for (CategoryModel *model in categorys) {
        if ([model.category isEqualToString:@"推荐"]) {
            isContain = YES;
            break;
        }
    }
    NSMutableArray *newCategory = [NSMutableArray arrayWithArray:categorys];
    if (!isContain) {
        CategoryModel *model = [CategoryModel new];
        model.category = @"推荐";
        model.recommend = @"1";
        model.base_id = @"0";
        [newCategory insertObject:model atIndex:0];
    }
    for (CategoryModel *model in newCategory) {
        if (model.category && ![model.category isEqualToString:@""] && [model.recommend integerValue] == 1) {
            
            DynamicPictureListViewController *me = [[DynamicPictureListViewController alloc] init];
            //me.categoryModel = model;
            [viewControllers addObject:me];
            [titles addObject:model.category];
            [selectedCategorys addObject:model];
        }
    }
    
    [[NSFileManager defaultManager] createFileAtPath:[sandBoxPath stringByAppendingPathComponent:CATEGORY_CONTROLLERS_CACHE_KEY] contents:[NSKeyedArchiver archivedDataWithRootObject:selectedCategorys] attributes:nil];
    
    _segmentedBarController = [[JZSegmentedBarController alloc] initWithStyle:JZSegmentedBarStyleEmbeddedInNavigationBar];
    _segmentedBarController.viewControllers = [NSMutableArray arrayWithArray:viewControllers];
    _segmentedBarController.segmentedBar.titles = titles;
    _segmentedBarController.selectedIndexAnimation = YES;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:_segmentedBarController];
    navi.navigationBar.tintColor = [UIColor clearColor];
    
    [navi willMoveToParentViewController:self];
    [self addChildViewController:navi];
    [navi didMoveToParentViewController:self];
    [self.view addSubview:navi.view];
    
    _segmentedBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"jiahao"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rigthTapped:)];
    if (currentSystemVersion() >= 7.0) {
        
        _segmentedBarController.edgesForExtendedLayout                                       = UIRectEdgeNone;
        _segmentedBarController.extendedLayoutIncludesOpaqueBars                             = NO;
        _segmentedBarController.modalPresentationCapturesStatusBarAppearance                 = NO;
    }
    else{
        _segmentedBarController.navigationController.navigationBar.layer.masksToBounds = YES;
        _segmentedBarController.navigationController.navigationBar.clipsToBounds       = YES;
    }
    [_segmentedBarController.navigationController.navigationBar setBarTintColor:[UIColor hexStringToColor:@"#D43D3D"]];
    [_segmentedBarController.navigationController.navigationBar setTranslucent:NO];
}

- (void)rigthTapped:(UIBarButtonItem *)sender
{
    [self pushViewController:[SelectedItemViewController new]];
}

- (void)fetchData
{
    __weak typeof(self) weakSelf = self;
    [[APIs shareInstance] getCategoryListOffset:nil success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            [weakSelf exchangeContrllersWithCategorys:responseObject];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
