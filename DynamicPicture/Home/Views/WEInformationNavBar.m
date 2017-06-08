//
//  WEInformationNavBar.m
//  Weather
//
//  Created by Kings Yan on 16/9/9.
//  Copyright © 2016年 cxmx. All rights reserved.
//

#import "WEInformationNavBar.h"
//#import "UIView+Additions.h"

@implementation WEInformationNavBar
{
    UIView *_line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[[UIImage imageNamed:@"set_assistant_btn_back"] tintColorWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_leftBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[[UIImage imageNamed:@"jiahao"] tintColorWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_rightBtn];
        
        _titleView = [[UILabel alloc] init];
        _titleView.font = [UIFont systemFontOfSize:17];
        _titleView.textColor = [UIColor whiteColor];
        _titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = 44;
    
    _leftBtn.frame = CGRectMake(0, 0, btnW, btnW);
    
    _rightBtn.frame = CGRectMake(self.width - btnW - 10, 0, btnW, btnW);
    
    _titleView.size = CGSizeMake(self.width - 100, btnW);
    _titleView.center = CGPointMake(self.width / 2, self.height / 2);
//    if (!self.rightBlock) {
//        _titleView.width += btnW;
//    }
    if (_line) {
        
        _line.bottom = self.height;
        [_line bringToFront];
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    if (_line) {
        [_line removeFromSuperview];
    }
    _line = [self addtionUnderlineWithSross:0.5 withColor:_lineColor];
    _line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)setBackTintColor:(UIColor *)backTintColor
{
    _backTintColor = backTintColor;
    [_leftBtn setImage:[[UIImage imageNamed:@"set_assistant_btn_back"] tintColorWithColor:_backTintColor] forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleView.textColor = _titleColor;
}

- (void)leftClick
{
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightClick:(UIButton *)sender
{
    if (self.rightBlock) {
        self.rightBlock(sender);
    }
}

@end
