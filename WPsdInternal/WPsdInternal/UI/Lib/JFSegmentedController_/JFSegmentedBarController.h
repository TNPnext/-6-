//
//  JFSegmentedBarController.h
//  WAF
//
//  Created by Kings Yan on 15/9/28.
//  Copyright © 2015年 西安交大捷普网络科技有限公司. All rights reserved.
//

#import "JZSegmentedBarController.h"


enum
{
    JFSegmentedBarControllerSegmentedMenuStatusClose = 0,
    JFSegmentedBarControllerSegmentedMenuStatusOpen,
};

typedef char JFSegmentedBarControllerSegmentedMenuStatus;


@protocol JZSegmentedBarControllerCategoryDelegate;
NS_CLASS_AVAILABLE_IOS(5_0) @interface JFSegmentedBarController : JZSegmentedBarController

@property (nonatomic, weak) id<JZSegmentedBarControllerCategoryDelegate> xbDelegate;

- (instancetype)initWithControllers:(NSArray *)controllers tabBarItemTitles:(NSArray *)titleArray
                             images:(NSArray *)imageArray selectedImages:(NSArray *)selectedImageArray
                        tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage *)bgImage;


// Segmented menu.
@property (nonatomic, assign, readonly) JFSegmentedBarControllerSegmentedMenuStatus segmentedMenuStatus;
@property (nonatomic, assign, readonly) BOOL segmentedMenuLoading;
- (void)openSegmentedMenuWithImage:(UIImage *)img;
- (void)closeSegmentedMenu;
@property (nonatomic, copy) void (^segmentedBarMenuDidOpen)(JFSegmentedBarController *);
@property (nonatomic, copy) void (^segmentedBarMenuDidClose)(JFSegmentedBarController *);
// Default is NO; When segmentedMenu is Opening to display titles.
@property (nonatomic, assign) BOOL hiddenTitle;
// Default is YES; When segmentedmenu is Opening to view content can interaction.
@property (nonatomic, assign) BOOL contentInteractionAtSegmentedMenuLoading;

// NavigationBar parallax effect, When segmentedBarStyle is JZSegmentedBarTabBar is available, Default is YES.
@property (nonatomic, assign) BOOL parallaxEnable;

@property (nonatomic, strong) UIViewController *mainEquipmentManagedController;
@property (nonatomic, strong) UIViewController *mainInformationController;
@property (nonatomic, strong) UIViewController *mainTechnologySupportController;
@property (nonatomic, strong) UIViewController *mainMeController;

@end

@protocol JZSegmentedBarControllerCategoryDelegate <NSObject>

@optional
- (void)xbTabBar:(JZSegmentedBarController *)tabBarController didSelectedItem:(NSInteger)index;

@end
