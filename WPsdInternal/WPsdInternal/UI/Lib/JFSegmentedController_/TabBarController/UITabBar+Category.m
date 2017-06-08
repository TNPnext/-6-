//
//  UITabBar+Category.m
//  MyTest20131030
//
//  Created by Kings Yan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import "UITabBar+Category.h"
#import <objc/runtime.h>
#import "TabButton.h"
#import "XBBadgeView.h"
#import "UIButton+TabBar.h"
#import "JZDevice.h"

static const char *categoryDelegateKey = "categoryDelegate";

@implementation UITabBar (Category)

- (void)setItemTitles:(NSArray*)titleArray images:(NSArray*)imageArray selectedImages:(NSArray*)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage*)bgImage
{
    for (UIView *v in self.subviews) {
        if ([v isMemberOfClass:NSClassFromString(@"UITabBarButton")]) {
//            v.hidden = YES;
            [v removeFromSuperview];
        }
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
        
        self.backgroundImage = [[UIImage alloc] init];
        [self setShadowImage:[[UIImage alloc] init]];
    }
    
//    self.backgroundColor = [UIColor whiteColor];
    self.barTintColor = [UIColor whiteColor];

    if (bgImage) {
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:bgImage];
        bg.frame = self.bounds;
        [self addSubview:bg];
    }
    
    if (barWidth <= 0) {
        barWidth = self.frame.size.width;
    }
    if (currentDeviceIOSModel() == JZ_DEVICE_IOS_MODEL_IPAD) {
        barWidth = 450;
    }
    
    
    CGFloat widthEach = barWidth/titleArray.count;
    for (int i = 0; i < titleArray.count; i++) {
        
        TabButton *button = [[TabButton alloc] initWithFrame:CGRectMake(i*widthEach + ((self.frame.size.width - barWidth) / 2), -5, widthEach, self.frame.size.height + 5)];
        button.tag = BUTTON_BASE_TAG + i;
        if (imageArray.count > i) {
            [button setImage:imageArray[i] forState:UIControlStateNormal];
        }
        if (selectedImageArray.count > i) {
            [button setImage:selectedImageArray[i] forState:UIControlStateHighlighted];
        }
        if (selectedImageArray.count > i) {
            [button setImage:selectedImageArray[i] forState:UIControlStateSelected];
        }
        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button custom];
        
        [self addSubview:button];
        if (i == 0) {
            
//            button.userInteractionEnabled = NO;
            button.selected = YES;
        }
    }
}

- (void)refreshTabTitles:(NSArray*)titles
{
    for (int i = 0; i < titles.count; ++i) {
        UIView *view = [self viewWithTag:BUTTON_BASE_TAG+i];
        if ([view isMemberOfClass:[TabButton class]]) {

            TabButton *b = (TabButton*)view;
            [b setTitle:titles[i] forState:UIControlStateNormal];
        }
    }
}


- (void)setBadgeNum:(int)number atIndex:(int)index
{
    UIView *v = [self viewWithTag:index + BUTTON_BASE_TAG];
    if ([v isMemberOfClass:[TabButton class]]) {

        TabButton *button = (TabButton*)v;
        [button setBadgeNum:number];
    }
}

- (id<UITabBarButtonDelegate>)categoryDelegate
{
    return objc_getAssociatedObject(self, categoryDelegateKey);
}

- (void)setCategoryDelegate:(id<UITabBarButtonDelegate>)newCategoryDelegateKey
{
    objc_setAssociatedObject(self, categoryDelegateKey, newCategoryDelegateKey, OBJC_ASSOCIATION_ASSIGN);
}

- (void)tap:(UIButton *)sender
{
    UIButton *b = (UIButton *)sender;
    
    if ([self.categoryDelegate respondsToSelector:@selector(tabBar:buttonDidClickedAtIndex:)]) {
        [self.categoryDelegate tabBar:self buttonDidClickedAtIndex:b.tag - BUTTON_BASE_TAG];
    }
    
}

@end
