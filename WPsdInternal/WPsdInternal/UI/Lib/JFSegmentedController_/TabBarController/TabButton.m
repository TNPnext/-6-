//
//  TabButton.m
//  MyTest20131030
//
//  Created by Ethan on 13-11-1.
//  Copyright (c) 2013年 ethan. All rights reserved.
//

#import "TabButton.h"
//#import "PPBadgeView.h"
#import "XBBadgeView.h"

#define kPPTABMAXBADGENUM 99

@interface TabButton()

@property (nonatomic, strong) XBBadgeView *badge;

@end

@implementation TabButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.titleEdgeInsets = UIEdgeInsetsMake(frame.size.height - 15, 7, 5, 5);
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:[UIColor colorWithRed:135.0/255.0f green:135.0/255.0f blue:135.0/255.0f alpha:1] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:87/255.0f green:149/255.0f blue:249/255.0f alpha:1] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor colorWithRed:87/255.0f green:149/255.0f blue:249/255.0f alpha:1] forState:UIControlStateHighlighted];

        //        _badge = [[PPBadgeView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _badge = [[XBBadgeView alloc]init];
//        _badge.userInteractionEnabled = NO;
//        _badge.badgeColor = [UIColor redColor];
        [self addSubview:_badge];
        _badge.hidden = YES;
    }
    return self;
}

- (void)setBadgeNum:(int)number
{
    NSString *num;
    if (number > 0) {
        if(number > kPPTABMAXBADGENUM) {
            num = [NSString stringWithFormat:@"%d+", kPPTABMAXBADGENUM];
        }
        else{
            num = [NSString stringWithFormat:@"%d", number];
        }
        _badge.badgeString = num;
        _badge.frame = CGRectMake(self.frame.size.width - _badge.frame.size.width - 8, 1, _badge.frame.size.width, _badge.frame.size.height);
        _badge.hidden = NO;
    }
    else if (number == -1) {
        _badge.badgeString = @"";
//        _badge.frame = CGRectMake(self.frame.size.width - 7 - 15, 1, 7, 7);
        _badge.frame = CGRectMake(self.frame.size.width - _badge.frame.size.width - 12, 2, _badge.frame.size.width, _badge.frame.size.height);
        _badge.hidden = NO;
    }
    else{
        _badge.badgeString = nil;
        _badge.hidden = YES;
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(contentRect.size.width / 2 - 12, contentRect.size.height / 2 - 13, 23, 21);
    return rect;
}

//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(contentRect.size.width / 2, contentRect.size.height / 2 + 2, 0, 14);
//}

@end
