//
//  WEInformationNavBar.h
//  Weather
//
//  Created by Kings Yan on 16/9/9.
//  Copyright © 2016年 cxmx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KWENavBarH 44

typedef void(^leftBlock)();
typedef void(^rightBlock)(UIButton *);

@interface WEInformationNavBar : UIView

@property (strong, nonatomic) UILabel *titleView;
@property (copy, nonatomic) leftBlock leftBlock;
@property (copy, nonatomic) rightBlock rightBlock;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong) UIColor *backTintColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *lineColor;

@end
