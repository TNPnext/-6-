//
//  YImageView.h
//  TradePlusProfession
//
//  Created by Kings Yan on 16/6/28.
//  Copyright © 2016年 Chongqing trade + Internet Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YImageView : UIView


@property (nonatomic, copy) void (^tapped)(NSUInteger currentIdx);

@property (nonatomic, strong) NSArray *animationImages;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) BOOL animationReplay;

- (void)startAnimating;
- (BOOL)animating;
- (void)stopAnimating;
@property (nonatomic, copy) void (^animationStoped)();


@end
