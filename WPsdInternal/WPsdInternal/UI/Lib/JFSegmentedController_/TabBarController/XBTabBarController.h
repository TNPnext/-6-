//
//  TabBarController.h
//  MyTest20131030
//
//  Created by Kings Yan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XBTabBarControllerDelegate;

@interface XBTabBarController : UITabBarController

@property (nonatomic, weak) id<XBTabBarControllerDelegate> xbDelegate;

@property (nonatomic, assign) NSInteger previousSelectedIndex;

- (id)initWithControllers:(NSArray*)controllers tabBarItemTitles:(NSArray*)titleArray images:(NSArray*)imageArray selectedImages:(NSArray*)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)bgImage;

- (id)initContainsMiddleButtonWithControllers:(NSArray*)controllers tabBarItemTitles:(NSArray*)titleArray images:(NSArray*)imageArray selectedImages:(NSArray*)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)bgImage;

- (void)setTabBarItemTitles:(NSArray*)titleArray images:(NSArray*)imageArray selectedImages:(NSArray*)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)bgImage;

- (void)setTabBarItemContainsMiddleButtonTitles:(NSArray *)titleArray images:(NSArray *)imageArray selectedImages:(NSArray *)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage *)bgImage;

- (void)setTabBarBadgeNum:(int)number atIndex:(int)index;

- (void)refreshTabBarTitles:(NSArray *)titleArray;

@end

@protocol XBTabBarControllerDelegate <NSObject>

@optional

- (void)xbTabBar:(XBTabBarController*)tabBarController didSelectedItem:(NSInteger)index;

@end
