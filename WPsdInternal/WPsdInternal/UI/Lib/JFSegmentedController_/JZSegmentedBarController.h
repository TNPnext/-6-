//
//  JZSegmentedController.h
//  TestSegmentedController
//
//  Created by Kings Yan on 15/1/13.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JZSegmentedBar.h"

@protocol JZSegmentedBarControllerDelegate;
NS_CLASS_AVAILABLE_IOS(5_0) @interface JZSegmentedBarController : UIViewController <JZSegmentedBarDelegate, UIScrollViewDelegate>

@property (nonatomic, assign, readonly) JZSegmentedBarStyle barStyle;
@property (nonatomic, strong) JZSegmentedBar *segmentedBar;  // head theme.
@property (nonatomic, strong, readonly) UITabBar *tabBar; // only barStyle is JZSegmentedBarStyleTabbar availabel.
@property (nonatomic, strong, readonly) UIScrollView *scrollView;


- (instancetype)initWithStyle:(JZSegmentedBarStyle)style __attribute__((objc_designated_initializer));

@property (nonatomic, strong) NSMutableArray *viewControllers; // content view controllers.
@property (nonatomic, weak) id <JZSegmentedBarControllerDelegate> delegate;


// <The following value is only available in JZSegmentedBarStyleIndependent style.
@property (nonatomic, assign) CGFloat segmentedBarHeight; // default is 44.
@property (nonatomic, assign, getter = isSegmentedBarHidden) BOOL segmentedBarHidden; // default to NO

- (void)setSegmentedBarHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) BOOL selectedIndexAnimation;
@property (nonatomic, weak, readonly) UIViewController *currentViewController;

@property (nonatomic, assign) NSInteger previousSelectedIndex;

/*
 * when SegementBarTypeIndependentPanel set frame completed, implemention layoutSegementBarTypeIndependentPanel
 * block
 */
@property (nonatomic, copy) void (^layoutSegementBarTypeIndependentPanel)(UIView *);

/*
 * when SegementBar set frame is completed, implemention layoutSegementBarComplementedBlock block.
 */
@property (nonatomic, copy) void (^layoutSegementBarComplementedBlock)(UIView *);

@end

@interface UIViewController (JZSegmentedBarController)

- (JZSegmentedBarController *)segmentedBarController;
- (void)disableExpand;

@end

@interface UIViewController (attribute)

// set SegmentBarViewController's navigationBar information to parentController if parentViewController is exsit, default is NO;
@property (nonatomic, assign) BOOL transferNavigationBarContentToParentController;

@end


@protocol JZSegmentedBarControllerDelegate <NSObject>

@optional;
/* 
 * when scroll to first or last then continue, pan gesture callback continued.
 */
- (void)segmentedControllerSpecialPanGesture:(UIPanGestureRecognizer *)gesture;

@end 
