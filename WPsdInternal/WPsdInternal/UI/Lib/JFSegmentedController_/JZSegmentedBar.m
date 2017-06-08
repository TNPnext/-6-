//
//  JZSegmentedBar.m
//  TestSegmentedController
//
//  Created by Kings Yan on 15/1/13.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZSegmentedBar.h"
#import "UIView+Category.h"
#import "Macro_h.h"

@interface JZSegmentedBar ()

@property (nonatomic, strong, readwrite) NSArray *buttons;

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, assign) NSUInteger selectedIndex;

// The follow value is only JZSegementedBarStyleIndepentend available.
@property (nonatomic, strong) UIView *panelView;

@property (nonatomic, assign) dispatch_once_t __once__;

@property (nonatomic, strong) NSMutableArray *buttonsLocaton;  // 0.00|0.00

@property (nonatomic, strong) UIToolbar *bgBar;

@end

@implementation JZSegmentedBar

@synthesize
panelView = _panelView,
__once__ = ___once__;

- (void)dealloc
{
#if DEBUG
    NSLog(@"<< dealloc:  %@ >>",self);
#endif
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _autoAlignment = YES;
        _alignmentGap = 0;
        _allAlignmentCenter = YES;
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator   = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.bounces  = NO;
        scrollView.delegate = self;
        scrollView.alwaysBounceHorizontal = YES;
        scrollView.alwaysBounceVertical   = NO;
        _scrollView = scrollView;
        _scrollView.frame            = CGRectMake(0.0, 0.0, self.width, self.height);
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_scrollView];

        
        self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gen_subnav_middle_s"]];
    }
    return self;
}

- (id)initWithStyle:(JZSegmentedBarStyle)style
{
    if (self = [self init]) {
        self.Style = style;
        self.arrowStyle = JZSegmentedBarArrowViewTypeNormal;
        if (style == JZSegmentedBarStyleEmbeddedInNavigationBar) {
            self.buttonsLocaton = [NSMutableArray new];
        }
    }
    return self;
}

- (void)buttonTapped:(UIButton *)sender
{
//    [self setButtonSelectedAtIndex:sender.tag animation:YES];
    if ([self.delegate respondsToSelector:@selector(segmentedBar:didSelectSegmentWithIndex:)]) {
        [self.delegate segmentedBar:self didSelectSegmentWithIndex:sender.tag];
    }
}

- (void)setButtonSelectedAtIndex:(NSUInteger)index animation:(BOOL)animate isDragging:(BOOL)isDragging
{
    if (isDragging) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.selected = (index == idx);
        if (index == idx) {
            
//            weakSelf.selectedIndex = index;
            if (_buttonbackgroundColor) {
                [weakSelf buttonBackgroundcolorWithColor:_buttonbackgroundColor];
            }
            if (_selectedButtonbackgroundColor) {
                [weakSelf selectedButtonBackgroundcolorWithColor:_selectedButtonbackgroundColor];
            }
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
               dispatch_async(dispatch_get_main_queue(), ^{
                   [UIView animateWithDuration:0.5 animations:^{
                       
                       if (weakSelf.arrowStyle == JZSegmentedBarArrowViewTypeHorizetalLine) {
                           //                    weakSelf.arrowView.width = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(1800.0f, CGRectGetHeight(weakSelf.scrollView.bounds)) lineBreakMode:NSLineBreakByCharWrapping].width + 20;
                           weakSelf.arrowView.width = btn.width;
                       }
                       weakSelf.arrowView.center = CGPointMake(btn.centerX, weakSelf.arrowView.centerY);
                   }];
               });
            });
            
            [self moveScrollToSelectedContentWithIndex:index animation:animate];
            if (weakSelf.Style == JZSegmentedBarStyleEmbeddedInNavigationBar) {
                btn.transform = CGAffineTransformMakeScale(1, 1);
            }
        }
        else{
            if (weakSelf.Style == JZSegmentedBarStyleEmbeddedInNavigationBar) {
                btn.transform = CGAffineTransformMakeScale(0.85, 0.85);
            }
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.buttons.count > 0) {
        
        if (self.Style == JZSegmentedBarStyleEmbeddedInNavigationBar) {
            
            __block float textGap = _alignmentGap / 2;
            __block float lastOffsetX = 0.0;
            
            void (^layoutButtons) (void) = ^{
                
                [_buttonsLocaton removeAllObjects];
                for (int i = 0; i < self.buttons.count; i++) {
                    
                    UIButton *button = self.buttons[i];
                    if (_titles.count <= i) {
                        break;
                    }
                    CGSize size = [((NSString *)_titles[i]) sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(1800.0f, CGRectGetHeight(self.scrollView.bounds)) lineBreakMode:NSLineBreakByWordWrapping];
                    button.frame = CGRectMake(lastOffsetX-5, 0.0, (size.width + 15), CGRectGetHeight(self.scrollView.bounds));
                    [_buttonsLocaton addObject:[NSString stringWithFormat:@"%f|%f", lastOffsetX, button.width]];
                    lastOffsetX += button.width;
                }
            };
            if (_autoAlignment) {
                
                while (lastOffsetX < _scrollView.width) {
                    
                    textGap += 5;
                    lastOffsetX = 0.0;
                    layoutButtons();
                    
                    if (lastOffsetX > _scrollView.width) {
                        _scrollView.bounces = YES;
                    }
                }
            }
            else{
                if (_titles.count > 0 && _buttons.count > 0) {
                    
                    CGSize firstBtnSize = [((NSString *)_titles[0]) sizeWithFont:((UIButton *)self.buttons[0]).titleLabel.font constrainedToSize:CGSizeMake(1800.0f, CGRectGetHeight(self.scrollView.bounds)) lineBreakMode:NSLineBreakByWordWrapping];
                    CGFloat leftGap = [self _leftGap];
                    leftGap = (_allAlignmentCenter)? leftGap : (firstBtnSize.width + textGap) / 2;
                    lastOffsetX = leftGap - (firstBtnSize.width + textGap) / 2;
                    
                    layoutButtons();
                    
                    if (_allAlignmentCenter) {
                        
                        CGSize LastBtnSize = [((NSString *)_titles[_titles.count - 1]) sizeWithFont:((UIButton *)self.buttons[self.buttons.count - 1]).titleLabel.font constrainedToSize:CGSizeMake(1800.0f, CGRectGetHeight(self.scrollView.bounds)) lineBreakMode:NSLineBreakByWordWrapping];
                        lastOffsetX += self.width - leftGap - (LastBtnSize.width + textGap) / 2;
                    }
                }
            }
            _scrollView.contentSize = CGSizeMake(lastOffsetX, _scrollView.height);
        }
        else if (self.Style != JZSegmentedBarStyleEmbeddedInNavigationBar) {
            
            CGFloat buttonWidth = CGRectGetWidth(self.bounds) / _count;
            for (int i = 0; i < self.buttons.count; i++) {
                
                UIButton *button = self.buttons[i];
                button.frame = CGRectMake(i * buttonWidth, 0.0, buttonWidth, CGRectGetHeight(self.bounds));
                button.titleLabel.textAlignment = NSTextAlignmentCenter;
            }
            _scrollView.contentSize = _scrollView.size;
        }
        
        NSUInteger selectedIndex = self.selectedIndex >= self.buttons.count ? 0 : self.selectedIndex;
        UIButton *btn = self.buttons[selectedIndex];
        if (self.arrowStyle == JZSegmentedBarArrowViewTypeNormal) {
            //
        }
        else if (self.arrowStyle == JZSegmentedBarArrowViewTypeHorizetalLine) {
            
            self.arrowView.size = CGSizeMake(self.width / _buttons.count, 2);
            self.arrowView.image = nil;
            self.arrowView.backgroundColor = RGB(63, 88, 152);
        }
        self.arrowView.center = CGPointMake(btn.centerX, self.height - self.arrowView.height / 2.0 - self.arrowOffsetY);
    }
    [self.scrollView addSubview:self.arrowView];
}

- (UIToolbar *)bgBar
{
    if (!_bgBar) {
        
        _bgBar = [[UIToolbar alloc] initWithFrame:self.bounds];
        _bgBar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_bgBar setBarTintColor:[UIColor whiteColor]];
        _bgBar.backgroundColor = [UIColor clearColor];
        _bgBar.transform = CGAffineTransformMakeRotation(-M_PI);
        [self addSubview:_bgBar];
    }
    return _bgBar;
}

- (void)setCount:(NSUInteger)count
{
    if (_count != count) {
        
        _count = count;
        if (_count != 0) {
            
            NSMutableArray *buttons = [NSMutableArray array];
            
            CGFloat buttonWidth = CGRectGetWidth(self.bounds) / _count;
            for (int i = 0; i < count; i++) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = i;
                button.frame = CGRectMake(i * buttonWidth, 0.0, buttonWidth, CGRectGetHeight(self.bounds));
                [button setTitleColor:_titleColor forState:UIControlStateNormal];
                [button setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
                [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
                [buttons addObject:button];
                [self.scrollView addSubview:button];
            }
            self.buttons = buttons;
        }
    }
}

- (void)setTitles:(NSArray *)titles
{
    if (_titles != titles) {
 
        _titles = titles;
        NSArray *arrayToEnumerate = (_titles.count > self.buttons.count) ? self.buttons : _titles;
        [arrayToEnumerate enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            UIButton *button = self.buttons[idx];
            NSString *title = _titles[idx];
            [button setTitle:title forState:UIControlStateNormal];
        }];
    }
}

- (void)setImages:(NSArray *)images
{
    if (_images != images) {
        
        _images = images;
        NSArray *arrayToEnumerate = (_images.count > self.buttons.count) ? self.buttons : _images;
        [arrayToEnumerate enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            UIButton *button = self.buttons[idx];
            UIImage *image = [UIImage imageNamed:_images[idx]];
            [button setImage:image forState:UIControlStateNormal];
        }];
    }
}

- (void)setSelectedImages:(NSArray *)selectedImages
{
    if (_selectedImages != selectedImages) {
        
        _selectedImages = selectedImages;
        NSArray *arrayToEnumerate = (_selectedImages.count > self.buttons.count) ? self.buttons : _selectedImages;
        [arrayToEnumerate enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            UIButton *button = self.buttons[idx];
            UIImage *image = [UIImage imageNamed:_selectedImages[idx]];
            [button setImage:image forState:UIControlStateSelected];
        }];
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    if (_titleColor != titleColor) {
        
        _titleColor = titleColor;
        if (_titleColor) {
            [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
            }];
        }
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    if (_selectedTitleColor != selectedTitleColor) {
        
        _selectedTitleColor = selectedTitleColor;
        if (_selectedTitleColor) {
            [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
            }];
        }
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (_titleFont != titleFont) {
        
        _titleFont = titleFont;
        if (_titleFont) {
            [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                btn.titleLabel.font = _titleFont;
            }];
        }
    }
}

- (void)setTitleOffset:(CGPoint)titleOffset
{
    if (!CGPointEqualToPoint(_titleOffset, titleOffset)) {
        
        _titleOffset = titleOffset;
        [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            btn.frame = CGRectMake(CGRectGetMinX(btn.frame) + _titleOffset.x, CGRectGetMinY(btn.frame) + _titleOffset.y, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
        }];
    }
}

- (UIImageView *)backgroundView
{
    if (_backgroundView == nil) {
        
        _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 1.0)];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:_backgroundView atIndex:0];
    }
    return _backgroundView;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (_backgroundImage != backgroundImage) {
        
        _backgroundImage = backgroundImage;
        self.backgroundView.image = backgroundImage;
    }
}

- (void)setArrowImage:(UIImage *)arrowImage
{
    if (_arrowImage != arrowImage) {
        
        _arrowImage = arrowImage;
        self.arrowView.image = arrowImage;
    }
}

- (void)setButtonbackgroundColor:(UIColor *)buttonbackgroundColor
{
    if (_buttonbackgroundColor != buttonbackgroundColor) {
        _buttonbackgroundColor = buttonbackgroundColor;
    }
}

- (void)setSelectedButtonbackgroundColor:(UIColor *)selectedButtonbackgroundColor
{
    if (_selectedButtonbackgroundColor != selectedButtonbackgroundColor) {
        _selectedButtonbackgroundColor = selectedButtonbackgroundColor;
    }
}

- (void)buttonBackgroundcolorWithColor:(UIColor *)buttonbackgroundColor
{
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        if (idx != _selectedIndex) {
            btn.backgroundColor = buttonbackgroundColor;
        }
    }];
}

- (void)selectedButtonBackgroundcolorWithColor:(UIColor *)selectedButtonbackgroundColor
{
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        if (idx == _selectedIndex) {
            btn.backgroundColor = selectedButtonbackgroundColor;
        }
    }];
}

#pragma mark - help

- (void)_configurePanelView
{
    _panelView.frame = CGRectMake(0, 10, self.width, self.height - 15);
    dispatch_once(&___once__, ^{
        
        _panelView.backgroundColor = self.backgroundColor;
        _panelView.layer.masksToBounds = YES;
        _panelView.layer.borderColor = self.layer.borderColor;
        _panelView.layer.borderWidth = self.layer.borderWidth;
        _panelView.layer.cornerRadius = self.layer.cornerRadius;
        _panelView.clipsToBounds = YES;
    });
    if (self.layoutSegementBarTypeIndependentPanel) {
        self.layoutSegementBarTypeIndependentPanel(_panelView);
    }
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 0;
    self.layer.borderColor = nil;
    self.layer.borderWidth = 0;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)moveScrollToSelectedContentWithIndex:(NSUInteger)index animation:(BOOL)animation
{
    if (_buttonsLocaton.count > index) {
        
        NSString *locationString = (NSString *)_buttonsLocaton[index];
        NSUInteger separatIdx = [locationString rangeOfString:@"|"].location;
        if (separatIdx + 1 < [locationString length]) {
            
            CGFloat offsetX = [[((NSString *)_buttonsLocaton[index]) substringToIndex:separatIdx] floatValue];
            CGFloat width = [[((NSString *)_buttonsLocaton[index]) substringFromIndex:separatIdx + 1] floatValue];
            CGFloat newContentOffsetX = (offsetX + width / 2) - [self _leftGap];
            if (newContentOffsetX > 0) {
                if (newContentOffsetX + self.scrollView.width >= self.scrollView.contentSize.width) {
                    newContentOffsetX = self.scrollView.contentSize.width - self.scrollView.width;
                }
            }
            else{
                newContentOffsetX = 0;
            }
            [UIView animateWithDuration:(animation)? 0.5 : 0 animations:^{
                [self.scrollView setContentOffset:CGPointMake(newContentOffsetX, 0)];
            }];
        }
    }
}

- (CGFloat)_leftGap
{
    CGFloat leftGap = 0;
    if (self.superview) {
        
        CGRect rect = [self convertRect:self.bounds toView:self.superview];
        leftGap = self.superview.width / 2 - rect.origin.x;
    }
    else{
        leftGap = self.width / 2;
    }
    return leftGap;
}

@end
