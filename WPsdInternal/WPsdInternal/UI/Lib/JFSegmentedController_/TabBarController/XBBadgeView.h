//
//  XBBadgeView.h
//  fangli
//
//  Created by Kings Yan on 14-2-13.
//  Copyright (c) 2014年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBBadgeView : UIImageView

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy) NSString *badgeString;

@property (nonatomic, assign) CGFloat deltaX;
@property (nonatomic, assign) CGFloat deltaY;

@end
