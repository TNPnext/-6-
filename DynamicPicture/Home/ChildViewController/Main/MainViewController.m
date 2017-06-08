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
#import "SearModel.h"
#import "MoveViewController.h"
#import "MJExtension.h"
NSString *CATEGORY_CONTROLLERS_CACHE_KEY = @"CATEGORY_CACHE_KEY";

@interface MainViewController ()

@end

@implementation MainViewController

- (void)mainBaseScrollViewScollEndableNotification:(NSNotification *)notification
{
    BOOL flag = [notification.object boolValue];
    self.segmentedBarController.scrollView.scrollEnabled = !flag;
}


- (void)loadView
{
    [super loadView];
    //self.title = @"开奖预测";
    
    self.navigationController.navigationBarHidden = NO;

    [self exchangeContrllersWithCategorys];
}

- (void)exchangeContrllersWithCategorys
{
    NSArray *_dataArr = @[@[@{@"playtype":@"1039",@"lottype":@"1001",@"title":@"杀三码"},@{@"playtype":@"1040",@"lottype":@"1001",@"title":@"杀六码"},@{@"playtype":@"1041",@"lottype":@"1001",@"title":@"杀十码"},@{@"playtype":@"1042",@"lottype":@"1001",@"title":@"独胆"},@{@"playtype":@"1044",@"lottype":@"1001",@"title":@"三胆"},@{@"playtype":@"1045",@"lottype":@"1001",@"title":@"篮球杀五码"},@{@"playtype":@"1046",@"lottype":@"1001",@"title":@"篮球定三胆"},@{@"playtype":@"1047",@"lottype":@"1001",@"title":@"篮球定五胆"},@{@"playtype":@"1037",@"lottype":@"1001",@"title":@"篮球杀号"}],
  @[@{@"playtype":@"1038",@"lottype":@"1002",@"title":@"杀二码"},@{@"playtype":@"1042",@"lottype":@"1002",@"title":@"独胆"},@{@"playtype":@"1043",@"lottype":@"1002",@"title":@"双胆"},@{@"playtype":@"1044",@"lottype":@"1002",@"title":@"三胆"},@{@"playtype":@"1050",@"lottype":@"1002",@"title":@"个位杀二码"},@{@"playtype":@"1051",@"lottype":@"1002",@"title":@"十位杀二码"},@{@"playtype":@"1052",@"lottype":@"1002",@"title":@"百位杀二码"}],
  @[@{@"playtype":@"1039",@"lottype":@"1003",@"title":@"杀三码"},@{@"playtype":@"1040",@"lottype":@"1003",@"title":@"杀六码"},@{@"playtype":@"1041",@"lottype":@"1003",@"title":@"杀十码"},@{@"playtype":@"1042",@"lottype":@"1003",@"title":@"独胆"},@{@"playtype":@"1043",@"lottype":@"1003",@"title":@"双胆"}],
  @[@{@"playtype":@"1055",@"lottype":@"1004",@"title":@"第一位杀二码"},@{@"playtype":@"1056",@"lottype":@"1004",@"title":@"第二位杀二码"},@{@"playtype":@"1057",@"lottype":@"1004",@"title":@"第三位杀二码"},@{@"playtype":@"1058",@"lottype":@"1004",@"title":@"第四位杀二码"},@{@"playtype":@"1059",@"lottype":@"1004",@"title":@"第五位杀二码"},@{@"playtype":@"1060",@"lottype":@"1004",@"title":@"第六位杀二码"},@{@"playtype":@"1061",@"lottype":@"1004",@"title":@"第七位杀二码"}],
  @[@{@"playtype":@"1038",@"lottype":@"1005",@"title":@"杀二码"},@{@"playtype":@"1042",@"lottype":@"1005",@"title":@"独胆"},@{@"playtype":@"1043",@"lottype":@"1005",@"title":@"双胆"},@{@"playtype":@"1044",@"lottype":@"1005",@"title":@"三胆"},@{@"playtype":@"1050",@"lottype":@"1005",@"title":@"个位杀二码"},@{@"playtype":@"1051",@"lottype":@"1005",@"title":@"十位杀二码"},@{@"playtype":@"1052",@"lottype":@"1005",@"title":@"百位杀二码"}],@[@{@"playtype":@"1050",@"lottype":@"1006",@"title":@"个位杀二码"},@{@"playtype":@"1051",@"lottype":@"1006",@"title":@"十位杀二码"},@{@"playtype":@"1052",@"lottype":@"1006",@"title":@"百位杀二码"},@{@"playtype":@"1053",@"lottype":@"1006",@"title":@"千位杀二码"},@{@"playtype":@"1054",@"lottype":@"1006",@"title":@"万位杀二码"}],
  @[@{@"playtype":@"1039",@"lottype":@"1007",@"title":@"杀三码"},@{@"playtype":@"1040",@"lottype":@"1007",@"title":@"杀六码"},@{@"playtype":@"1041",@"lottype":@"1007",@"title":@"杀十码"},@{@"playtype":@"1042",@"lottype":@"1007",@"title":@"独胆"},@{@"playtype":@"1043",@"lottype":@"1007",@"title":@"双胆"},@{@"playtype":@"1048",@"lottype":@"1007",@"title":@"后区杀二码"},@{@"playtype":@"1049",@"lottype":@"1007",@"title":@"后区定六码"}]];
    
    NSArray *titleArray = @[@"双色球",@"福彩3D", @"七乐彩",@"七星彩",@"排列三",@"排列五",@"超级大乐透"];
    if (_segmentedBarController) {
    
        [_segmentedBarController.view removeFromSuperview];
        [_segmentedBarController removeFromParentViewController];
    }
    
    NSArray *arr = _dataArr[_selectIndex];
    NSArray *modelsArr = [SearModel mj_objectArrayWithKeyValuesArray:arr];
    
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    
    NSMutableArray *selectedCategorys = [NSMutableArray new];
    
    
    for (int i = 0;i<modelsArr.count;i++)
    {
        SearModel *model = modelsArr[i];
        MoveViewController *move = [[MoveViewController alloc] init];
        move.model = model;
        move.titles = titleArray[_selectIndex];
        [viewControllers addObject:move];
        [selectedCategorys addObject:model.title];
//        
    }
    _segmentedBarController = [[JZSegmentedBarController alloc] initWithStyle:JZSegmentedBarStyleEmbeddedInNavigationBar];
    _segmentedBarController.viewControllers = [NSMutableArray arrayWithArray:viewControllers];
    _segmentedBarController.segmentedBar.titles = selectedCategorys;
    _segmentedBarController.selectedIndexAnimation = YES;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:_segmentedBarController];
    navi.navigationBar.tintColor = [UIColor clearColor];
    
    [navi willMoveToParentViewController:self];
    [self addChildViewController:navi];
    [navi didMoveToParentViewController:self];
    [self.view addSubview:navi.view];
    
    //_segmentedBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"jiahao"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rigthTapped:)];
    if (currentSystemVersion() >= 7.0) {
        
        _segmentedBarController.edgesForExtendedLayout                                       = UIRectEdgeNone;
        _segmentedBarController.extendedLayoutIncludesOpaqueBars                             = NO;
        _segmentedBarController.modalPresentationCapturesStatusBarAppearance                 = NO;
    }
    else{
        _segmentedBarController.navigationController.navigationBar.layer.masksToBounds = YES;
        _segmentedBarController.navigationController.navigationBar.clipsToBounds       = YES;
    }
    [_segmentedBarController.navigationController.navigationBar setBarTintColor:[UIColor hexStringToColor:KNavBarHexColor]];
    [_segmentedBarController.navigationController.navigationBar setTranslucent:NO];
}

- (void)rigthTapped:(UIBarButtonItem *)sender
{
    //[self pushViewController:[SelectedItemViewController new]];
}


@end
