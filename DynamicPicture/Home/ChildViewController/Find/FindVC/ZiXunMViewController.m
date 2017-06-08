//
//  ZiXunMViewController.m
//  DynamicPicture
//
//  Created by TNP on 2017/4/26.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "ZiXunMViewController.h"
#import "MFindViewController.h"
#import "JZSegmentedBarController.h"
#import "YSNavigationController.h"
@interface ZiXunMViewController ()
@property (nonatomic, strong) JZSegmentedBarController *segmentedBarController;
@end

@implementation ZiXunMViewController

- (void)mainBaseScrollViewScollEndableNotification:(NSNotification *)notification
{
    BOOL flag = [notification.object boolValue];
    self.segmentedBarController.scrollView.scrollEnabled = !flag;
}


- (void)loadView
{
    [super loadView];
    self.navigationItem.title = @"资讯中心";
    
    self.navigationController.navigationBarHidden = YES;
    
    [self exchangeContrllersWithCategorys];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)exchangeContrllersWithCategorys
{
    NSArray *arr = @[@"头条",@"行业",@"动态",@"双色球",@"大乐透",@"竞技彩",@"篮球",@"易眼金睛",@"3D",@"体彩其他",@"胜负彩"];
    NSArray *codes = @[@"toutiao",@"hangye",@"dongtai",@"ssq",@"dlt",@"jingcai",@"lancai",@"yiyan",@"3d",@"pl3",@"sfc"];
    if (_segmentedBarController) {
        
        [_segmentedBarController.view removeFromSuperview];
        [_segmentedBarController removeFromParentViewController];
    }
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    
    NSMutableArray *selectedCategorys = [NSMutableArray new];
    
    
    for (int i = 0;i<codes.count;i++) {
        NSString *model =codes[i];
        
       
        MFindViewController *me = [[MFindViewController alloc] init];
       
        me.urls = codes[i];
        [viewControllers addObject:me];
        [selectedCategorys addObject:model];
        
    }
    _segmentedBarController = [[JZSegmentedBarController alloc] initWithStyle:JZSegmentedBarStyleEmbeddedInNavigationBar];
    _segmentedBarController.viewControllers = [NSMutableArray arrayWithArray:viewControllers];
    _segmentedBarController.segmentedBar.titles = arr;
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
