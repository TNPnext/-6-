//
//  UITabBar+Category.h
//  MyTest20131030
//
//  Created by Kings Yan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUTTON_BASE_TAG 3151

@protocol UITabBarButtonDelegate;

@interface UITabBar (Category)

@property (nonatomic, weak) id<UITabBarButtonDelegate> categoryDelegate;

- (void)setItemTitles:(NSArray*)titleArray images:(NSArray*)imageArray selectedImages:(NSArray*)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)bgImage;

- (void)setBadgeNum:(int)number atIndex:(int)index;

- (void)refreshTabTitles:(NSArray*)titles;
@end

@protocol UITabBarButtonDelegate <NSObject>

@optional

- (void)tabBar:(UITabBar*) tabBar buttonDidClickedAtIndex:(int)index;

@end
