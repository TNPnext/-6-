//
//  FacebookBtn.m
//  TradePlusProfession
//
//  Created by Kings Yan on 16/6/18.
//  Copyright © 2016年 Chongqing trade + Internet Technology Co., Ltd. All rights reserved.
//

#import "FacebookBtn.h"

@implementation FacebookBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(contentRect.size.width / 2 - 11.5, contentRect.size.height / 2 - 23, 23, 23);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height / 2 + 10, contentRect.size.width, contentRect.size.height / 2 - 20);
}

@end
