//
//  YImageView.m
//  TradePlusProfession
//
//  Created by Kings Yan on 16/6/28.
//  Copyright © 2016年 Chongqing trade + Internet Technology Co., Ltd. All rights reserved.
//

#import "YImageView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Category.h"

@implementation YImageView
{
    UIImageView *_imgv;
    UIImageView *_imgv2;
    BOOL _isAnimating;
    NSInteger _currentIdx;
}

- (void)dealloc
{
    NSLog(@"/n/n/n/nbbbbbbbxxxxx");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        //        [self addSubview:[self bgBar]];
        [self addTapGestureWithTarget:self selector:@selector(tapped:)];
    }
    return self;
}

- (void)tapped:(UIGestureRecognizer *)gesture
{
    if (self.tapped) {
        self.tapped(_currentIdx);
    }
}

- (UINavigationBar *)bgBar
{
    UINavigationBar *bgBar = [[UINavigationBar alloc] initWithFrame:self.bounds];
    bgBar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    return bgBar;
}

- (void)startAnimating
{
    [self initializImgv];
    if (!_animationImages || _animationImages.count <= 1) {
        
        [self performSelector:@selector(callStop) withObject:nil afterDelay:_animationDuration];
        return;
    }
    [self performSelector:@selector(run) withObject:nil afterDelay:_animationDuration / _animationImages.count];
    _isAnimating = YES;
}

- (void)run
{
    [UIView animateWithDuration:1 animations:^{
        
        _imgv.alpha = !(_imgv.alpha);
        _imgv2.alpha = !(_imgv2.alpha);
    } completion:^(BOOL finished) {
        if (_animationImages.count >= 2) {
            
            _currentIdx = (_currentIdx + 1 < _animationImages.count)? (_currentIdx += 1) : (_currentIdx = 0);
            if (!_animationReplay && _currentIdx == _animationImages.count - 1) {
                
                [self stopAnimating];
                return;
            }
            if (!_imgv.alpha) {
                if ([_animationImages[_currentIdx] isKindOfClass:[UIImage class]]) {
                    _imgv.image = _animationImages[_currentIdx];
                }
                else if ([_animationImages[_currentIdx] isKindOfClass:[NSString class]]) {
                    [_imgv setImageWithURL:[NSURL URLWithString:_animationImages[_currentIdx]] completed:nil];
                }
            }
            if (!_imgv2.alpha) {
                if ([_animationImages[_currentIdx] isKindOfClass:[UIImage class]]) {
                    _imgv2.image = _animationImages[_currentIdx];
                }
                else if ([_animationImages[_currentIdx] isKindOfClass:[NSString class]]) {
                    [_imgv2 setImageWithURL:[NSURL URLWithString:_animationImages[_currentIdx]] completed:nil];
                }
            }
        }
    }];
    [self performSelector:@selector(startAnimating) withObject:nil afterDelay:_animationDuration / _animationImages.count];
}

- (BOOL)animating
{
    return _isAnimating;
}

- (void)stopAnimating
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimating) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    _isAnimating = NO;
    [self callStop];
}

- (void)initializImgv
{
    if (_animationImages && _animationImages.count > 0) {
        if (!_imgv) {
            
            _imgv = [[UIImageView alloc] initWithFrame:self.bounds];
            _imgv.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            if ([_animationImages[0] isKindOfClass:[UIImage class]]) {
                _imgv.image = _animationImages[0];
            }
            else if ([_animationImages[0] isKindOfClass:[NSString class]]) {
                [_imgv setImageWithURL:[NSURL URLWithString:_animationImages[0]] completed:nil];
            }
            _imgv.contentMode = UIViewContentModeScaleAspectFill;
            _currentIdx = 0;
            _imgv.clipsToBounds = YES;
            [self addSubview:_imgv];
        }
    }
    if (_animationImages && _animationImages.count > 1) {
        if (!_imgv2) {
            
            _imgv2 = [[UIImageView alloc] initWithFrame:self.bounds];
            _imgv2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            if ([_animationImages[1] isKindOfClass:[UIImage class]]) {
                _imgv2.image = _animationImages[1];
            }
            else if ([_animationImages[1] isKindOfClass:[NSString class]]) {
                [_imgv2 setImageWithURL:[NSURL URLWithString:_animationImages[1]] completed:nil];
            }
            _imgv2.contentMode = UIViewContentModeScaleAspectFill;
            _imgv2.clipsToBounds = YES;
            [self addSubview:_imgv2];
            _currentIdx = 1;
            _imgv2.alpha = 0;
        }
    }
    
}

- (void)callStop
{
    if (self.animationStoped) {
        self.animationStoped();
    }
}

@end
