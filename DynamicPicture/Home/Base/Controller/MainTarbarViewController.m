//
//  MainTarbarViewController.m
//  MoivePlace
//
//  Created by TNP on 17/2/10.
//  Copyright © 2017年 cxmx. All rights reserved.
//

#import "MainTarbarViewController.h"
#import "TabBar.h"
#import "YSNavigationController.h"
#import "MainViewController.h"
#import "MFindViewController.h"
#import "ZiXunMViewController.h"
#import "SearchViewController.h"
#import "MeViewController.h"
#import "DynamicPictureListViewController.h"
#import "ADModel.h"
#import "MJExtension.h"
#import "MYConstant.h"
#import "MLoginView.h"
#import <Public_h.h>
#import "TLSearchWebController.h"
#import "M_mainViewController.h"
#import "TogetherBViewController.h"
@interface MainTarbarViewController ()<TabBarDelegate>

@end

@implementation MainTarbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //每次启动 登录默认为未登录
    //[M_Tool setLoginStaute:NO];
    
    //设置状态栏白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 初始化tabbar
    [self setupTabbar];
    self.tabBar.translucent = NO;
    [self setupAllChildViewControllers];
}
/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    TabBar *customTabBar = [[TabBar alloc] init];
    
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    //[self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    //[self.tabBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews)
    {
        if ([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
}
- (void)setupAllChildViewControllers
{
    /** 首页 */
    M_mainViewController *TVVC = [[M_mainViewController alloc] init];
    [self setupChildViewController:TVVC title:@"首页" imageName:@"home" selectedImageName:@"home_select"];
    

    
    /** 福利 */
    DynamicPictureListViewController *FindVC = [[DynamicPictureListViewController alloc] init];
    [self setupChildViewController:FindVC title:@"开奖" imageName:@"lottery" selectedImageName:@"lottery_select"];
    

    /**  走势*/
    TogetherBViewController *MainPageVC = [[TogetherBViewController alloc] init];
    [self setupChildViewController:MainPageVC title:@"合买" imageName:@"togetherbuy" selectedImageName:@"togetherbuy_select"];

    
    /** 个人中心 */
    MeViewController *meVC = [[MeViewController alloc] init];
    [self setupChildViewController:meVC title:@"我" imageName:@"me_icon" selectedImageName:@"me_icon_select"];
    
    
    
}

- (void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{

    self.selectedIndex = to;
   
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];

    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];

    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 2.包装一个导航控制器
    YSNavigationController *nav = [[YSNavigationController alloc] initWithRootViewController:childVc];
    nav.navigationBar.barTintColor = [UIColor colorWithHexString:KNavBarHexColor];
    
    if ([childVc isKindOfClass:[M_mainViewController class]])
    {
     nav.navigationBarHidden = YES;
    }else
    {
       nav.navigationBarHidden = NO;
    }
    
    [self addChildViewController:nav];
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
