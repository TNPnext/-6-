//
//  JFRefreshView.m
//  WAF
//
//  Created by Kings Yan on 15/9/28.
//  Copyright © 2015年 西安交大捷普网络科技有限公司. All rights reserved.
//

#import "JFRefresh.h"
#import "UIView+Category.h"

@interface JFRefresh ()

@property (nonatomic, assign) BOOL insetOffSet;

@end

@implementation JFRefresh
{
    UIImageView *_indicator;
    UIView *_progressControl;
    
    BOOL _rotate;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _indicator = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 30, 0, 20, 20)];
        _indicator.layer.masksToBounds = YES;
        _indicator.image = [UIImage imageNamed:@"055b3a5e371a310286a8298249a9b04d.jpg"];
        _indicator.layer.cornerRadius = _indicator.height / 2;
        _indicator.backgroundColor = [UIColor greenColor];
        _indicator.layer.borderColor = _indicator.backgroundColor.CGColor;
        _indicator.layer.borderWidth = 1;
        _indicator.centerY = frame.size.height / 2;
        [self addSubview:_indicator];
        
        self.insetOffSet = NO;
        
        _progressControl = [[UIView alloc] initWithFrame:CGRectMake(10, 0, _indicator.left - 20, 2)];
        _progressControl.backgroundColor = [UIColor clearColor];
        _progressControl.centerY = _indicator.centerY;
        [self addSubview:_progressControl];
    }
    return self;
}

- (void)scrollDidScroll:(UIScrollView *)scrollView
{
    [self bringToFront];
    if (!self.insetOffSet) {
        
        self.top = -40;
        if (scrollView.contentOffset.y <= -40) {
            self.bottom = scrollView.contentOffset.y + 60;
        }
    }
    else{
        if (scrollView.contentOffset.y > 0) {
            self.bottom = 60;
        }
        else{
            self.bottom = scrollView.contentOffset.y + 60;
        }
    }
    [_indicator rotateToArc:-scrollView.contentOffset.y * 2];
}

- (void)scrollDidEndDragging:(UIScrollView *)scrollView
{
    if (-scrollView.contentOffset.y >= self.height * 1.5 && !self.insetOffSet) {
        
        self.insetOffSet = YES;
        
        if (self.beginRefresh) {
            self.beginRefresh();
        }
        [_indicator beginRotation];
    }
}

- (void)stopRfresh
{
    if (self.insetOffSet) {
        
        self.insetOffSet = NO;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.top = 0;
        } completion:^(BOOL finished) {
            [_indicator cancelRotation];
        }];
    }
}

@end
