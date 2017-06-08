//
//  TabBarController.m
//  MyTest20131030
//
//  Created by Kings Yan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import "XBTabBarController.h"
#import "UITabBar+Category.h"
#import "TabButton.h"

@interface XBTabBarController()<UITabBarButtonDelegate>

@property (nonatomic,assign) BOOL hasMidButton;

@end

@implementation XBTabBarController

- (id)initWithControllers:(NSArray*)controllers tabBarItemTitles:(NSArray*)titleArray images:(NSArray*)imageArray selectedImages:(NSArray*)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)bgImage
{
    self = [super init];
    if (self) {
        [self setViewControllers:controllers];
        [self setTabBarItemTitles:titleArray images:imageArray selectedImages:selectedImageArray tabBarWidth:barWidth backgroundImage:bgImage];
    }
    
    return self;
}

- (id)initContainsMiddleButtonWithControllers:(NSArray*)controllers tabBarItemTitles:(NSArray*)titleArray images:(NSArray*)imageArray selectedImages:(NSArray*)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)bgImage
{
    self = [super init];
    if (self) {
        [self setViewControllers:controllers];
        [self setTabBarItemContainsMiddleButtonTitles:titleArray images:imageArray selectedImages:selectedImageArray tabBarWidth:barWidth backgroundImage:bgImage];
    }
    
    return self;
}

- (void)setTabBarItemTitles:(NSArray*)titleArray images:(NSArray*)imageArray selectedImages:(NSArray*)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)bgImage
{
    self.tabBar.categoryDelegate = self;
    [self.tabBar setItemTitles:titleArray images:imageArray selectedImages:selectedImageArray tabBarWidth:barWidth backgroundImage:bgImage];
}

- (void)setTabBarItemContainsMiddleButtonTitles:(NSArray *)titleArray images:(NSArray *)imageArray selectedImages:(NSArray *)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage *)bgImage
{
    self.hasMidButton = YES;
    [self setTabBarItemTitles:titleArray images:imageArray selectedImages:selectedImageArray tabBarWidth:barWidth backgroundImage:bgImage];
}

#pragma mark - TabBar Category Delegate Method.

- (void)tabBar:(UITabBar *)tabBar buttonDidClickedAtIndex:(int)index
{
    NSInteger controllerIndex;
    if (self.hasMidButton) {
        if (index > self.viewControllers.count/2) {
            controllerIndex = index-1;
        }
        else if (index < self.viewControllers.count/2) {
            controllerIndex = index;
        }
        else{
            controllerIndex = -1;
        }
    }
    else{
        controllerIndex = index;
    }
    [self selectTabBarWithIndex:controllerIndex];
}
#pragma mark -

- (void)selectTabBarWithIndex:(NSInteger)controllerIndex
{
    
    // mid button clicked
    if (controllerIndex == -1) {
//        if ([self.xbDelegate respondsToSelector:@selector(tabBarControllerMidButtonDidTaped:)]) {
//            [self.xbDelegate tabBarControllerMidButtonDidTaped:self];
//        }
        return;
    }
    if ([self.xbDelegate respondsToSelector:@selector(xbTabBar:didSelectedItem:)]) {
        [self.xbDelegate xbTabBar:self didSelectedItem:controllerIndex];
    }
    
    NSInteger tapIndex;
    if (self.hasMidButton) {
        if (controllerIndex >= self.viewControllers.count/2) {
            tapIndex = controllerIndex+1;
        }
        else{
            tapIndex = controllerIndex;
        }
    }
    else{
        tapIndex = controllerIndex;
    }
    
//    if (controllerIndex == self.selectedIndex) {
//        return;
//    }
    
    NSInteger tapSelectedIndex;
    if (self.hasMidButton) {
        if (self.selectedIndex >= self.viewControllers.count/2) {
            tapSelectedIndex = self.selectedIndex+1;
        }
        else{
            tapSelectedIndex = self.selectedIndex;
        }
    }
    else{
        tapSelectedIndex = self.selectedIndex;
    }
    
    int i = tapSelectedIndex + BUTTON_BASE_TAG;
    UIView *v = [self.tabBar viewWithTag:i];
    if ([v isMemberOfClass:[TabButton class]]) {
        TabButton *button = (TabButton*)v;
//        button.userInteractionEnabled = YES;
        button.selected = NO;
    }
    
    v = [self.tabBar viewWithTag:tapIndex + BUTTON_BASE_TAG];
    if ([v isMemberOfClass:[TabButton class]]) {
        TabButton *button = (TabButton*)v;
//        button.userInteractionEnabled = NO;
        button.selected = YES;
    }
    if (!self.selectedIndex) {
        self.previousSelectedIndex = controllerIndex;
    }
    else{
        self.previousSelectedIndex = self.selectedIndex;
    }
    [super setSelectedIndex:controllerIndex];
}

- (void)setButtonSelected:(TabButton*)button
{
    button.userInteractionEnabled = NO;
    button.selected = YES;
}

- (void)setTabBarBadgeNum:(int)number atIndex:(int)index
{
    [self.tabBar setBadgeNum:number atIndex:index];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self selectTabBarWithIndex:selectedIndex];
}

- (void)refreshTabBarTitles:(NSArray *)titleArray
{
    [self.tabBar refreshTabTitles:titleArray];
}

- (BOOL)shouldAutorotate
{
    return NO;
}


@end
