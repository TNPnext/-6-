//
//  JZSegmentedController.m
//  TestSegmentedController
//
//  Created by Kings Yan on 15/1/13.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZSegmentedBarController.h"
#import "Macro_h.h"
#import "UIView+Category.h"
#import "JZDevice.h"

@interface JZSegmentedBarController () <UIScrollViewDelegate>

@property (nonatomic, assign, readwrite) JZSegmentedBarStyle barStyle;

//@property (nonatomic, strong, readwrite) JZSegmentedBar *segmentedBar;

@property (nonatomic, strong, readwrite) UIScrollView *scrollView;

// <this property is only in scroll delegate methods used.
@property (nonatomic, assign, readwrite) BOOL isDragging;

@property (nonatomic, weak, readwrite) UIViewController *currentViewController;
@property (nonatomic, weak) UIViewController *previousViewController;

@property (nonatomic, assign) CGFloat separatorHeight;  // record scrollView orign y.

@property (nonatomic, assign) CGFloat panBeganRange; // record point of translation X of pan gesture began.

@end

@implementation JZSegmentedBarController
{
    CGFloat _startPoint;
    UIButton *_nextBtn;
    UIButton *_currentBtn;
    BOOL _isTapType;
}

@synthesize
scrollView    = _scrollView,
segmentedBar  = _segmentedBar,
panBeganRange = _panBeganRange;

- (instancetype)initWithStyle:(JZSegmentedBarStyle)style
{
    if (self = [super init]) {
        
        self.barStyle               = style;
        _segmentedBar = [[JZSegmentedBar alloc] initWithStyle:style];
        _segmentedBar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        _segmentedBar.arrowView.hidden = YES;
        _segmentedBarHeight            = 44;
        self.selectedIndexAnimation = NO;
        if (style == JZSegmentedBarStyleEmbeddedInNavigationBar) {
            
            
        }
        
        __weak typeof(self) weakSelf = self;
        _segmentedBar.layoutSegementBarTypeIndependentPanel = ^(UIView *panel) {
            if (weakSelf.layoutSegementBarTypeIndependentPanel) {
                weakSelf.layoutSegementBarTypeIndependentPanel(panel);
            }
        };
        _segmentedBar.layoutSegementBarComplementedBlock = ^(UIView *panel) {
            if (weakSelf.layoutSegementBarComplementedBlock) {
                weakSelf.layoutSegementBarComplementedBlock(panel);
            }
        };
        _selectedIndex = 404;
        self.transferNavigationBarContentToParentController = NO;
    }
    return self;
}

- (void)dealloc
{
#if DEBUG
    NSLog(@"<< dealloc:  %@ >>",self);
#endif
}

- (void)loadView
{
    [super loadView];
    
    if (self.barStyle == JZSegmentedBarStyleEmbeddedInNavigationBar) {
        
        _segmentedBar.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), self.segmentedBarHeight);
        _segmentedBar.titleColor = RGB(234, 187, 188);
        _segmentedBar.selectedTitleColor = [UIColor whiteColor];
        _segmentedBar.arrowView.hidden = YES;
        _segmentedBar.buttonbackgroundColor         = [UIColor clearColor];
        _segmentedBar.selectedButtonbackgroundColor = [UIColor clearColor];
        _segmentedBar.clipsToBounds = NO;
        _segmentedBar.alignmentGap = 50;
        _segmentedBar.titleFont = [UIFont systemFontOfSize:20];
        _segmentedBar.delegate         = self;
        _segmentedBar.autoAlignment = NO;
        _segmentedBar.allAlignmentCenter = NO;
        
        if (self.transferNavigationBarContentToParentController) {
            self.parentViewController.navigationItem.titleView = _segmentedBar;
        }
        else{
            self.navigationItem.titleView = _segmentedBar;
        }
        
        _separatorHeight = 0.0;
    }
    else{
        _segmentedBar.layer.masksToBounds = NO;
        _segmentedBar.layer.borderColor = RGB(255, 133, 97).CGColor;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces       = NO;
    scrollView.delegate = self;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.alwaysBounceVertical   = YES;
    scrollView.clipsToBounds = NO;
    _scrollView = scrollView;
    _scrollView.frame            = CGRectMake(0.0, _separatorHeight, self.view.width, self.view.height - _separatorHeight);
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_scrollView.panGestureRecognizer addTarget:self action:@selector(panScroll:)];
    [self _scrollViewContentSize];
    [self.view addSubview:_scrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.selectedIndex == 404) {
        self.selectedIndex = 0;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self _scrollViewContentSize];
//    [self _subviewsLayout];
}

- (void)_scrollViewContentSize
{
    _scrollView.contentSize = CGSizeMake(_scrollView.width * _viewControllers.count, ([UIApplication sharedApplication].statusBarHidden)? _scrollView.height - 20 : _scrollView.height);
}

- (void)_subviewsLayout
{
    [UIView animateWithDuration:0.5 animations:^{
        
        [_scrollView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = CGRectMake(_scrollView.width * idx, 0.0, _scrollView.width, _scrollView.height);
        }];
        [_scrollView setContentOffset:CGPointMake(self.selectedIndex * _scrollView.width, 0)];
    }];
}

- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    if (_viewControllers != viewControllers) {
        
        _viewControllers = viewControllers;
        for (UIViewController *viewController in _viewControllers) {
            
            [viewController willMoveToParentViewController:self];
            [self addChildViewController:viewController];
            [viewController didMoveToParentViewController:self];
            
            [viewController loadView];
        }
        
        if (_viewControllers.count) {
            _segmentedBar.count = _viewControllers.count;
            _segmentedBar.titleFont = [UIFont boldSystemFontOfSize:14.0];
        }
    }
}

- (void)_passNavigationItemsToProperViewControllerFromViewController:(UIViewController *)viewController
{
    UIViewController *containerViewController = self;
    while (containerViewController && ![containerViewController isKindOfClass:[UINavigationController class]]) {
        
        if (viewController.navigationItem.leftBarButtonItems) {
            containerViewController.navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems;
        }
        if (viewController.navigationItem.backBarButtonItem) {
            containerViewController.navigationItem.backBarButtonItem = viewController.navigationItem.backBarButtonItem;
        }
        if (viewController.navigationItem.rightBarButtonItems) {
            containerViewController.navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems;
        }
        if (!containerViewController.navigationItem.titleView) {
            containerViewController.navigationItem.titleView = viewController.navigationItem.titleView;
        }
        containerViewController = containerViewController.parentViewController;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (!self.viewControllers.count) {
        return;
    }
    if (_selectedIndex != selectedIndex || self.currentViewController == nil) {
        
        _selectedIndex = selectedIndex;
        if (self.currentViewController) {
            self.previousViewController = self.currentViewController;
        }
        if (_selectedIndex < self.viewControllers.count) {
            self.currentViewController = self.viewControllers[_selectedIndex];
        }
        
        if (![self.previousViewController isEqual:self.currentViewController] && self.previousViewController) {
            [self.previousViewController viewWillDisappear:YES];
        }
        
        [self.currentViewController view]; // < force to load view.
        if ([self.currentViewController respondsToSelector:@selector(viewWillAppear:)]) {// < force to load view.
            [self.currentViewController viewWillAppear:YES];
        }
        [self _passNavigationItemsToProperViewControllerFromViewController:self.currentViewController];
        
        UIView *currentVcView = self.currentViewController.view;
        currentVcView.frame = CGRectMake(_scrollView.width * _selectedIndex, 0.0, _scrollView.width, _scrollView.height);
        
        if (![_scrollView.subviews containsObject:currentVcView]) {
            [_scrollView addSubview:currentVcView];
        }
        [self.currentViewController viewDidAppear:YES];
        if (self.previousViewController) {
            [self.previousViewController viewDidDisappear:YES];
        }
        if (!self.isDragging) {
            [_scrollView setContentOffset:CGPointMake(_scrollView.width * _selectedIndex, 0.0) animated:_selectedIndexAnimation];
        }
    }
    [_segmentedBar setButtonSelectedAtIndex:_selectedIndex animation:YES isDragging:_isDragging];
}

- (void)setSegmentedBarHeight:(CGFloat)segmentedBarHeight
{
    if (self.barStyle == JZSegmentedBarStyleEmbeddedInNavigationBar) return;
    
    if (_separatorHeight != segmentedBarHeight) {
        _segmentedBarHeight = segmentedBarHeight;
        
        if (self.segmentedBarHidden) {
            // <Shouldn't change currentViewController's height,
            //  it's already at the bottom of screen.
            self.segmentedBar.frame = CGRectMake(0.0, -_segmentedBarHeight, self.segmentedBar.width, _segmentedBarHeight);
        }
        else {
            // < Will be influenced by AutoResizingMask
            self.segmentedBar.bounds = CGRectMake(0.0, 0.0, self.segmentedBar.width, _segmentedBarHeight);
            self.scrollView.frame = CGRectMake(0.0, _segmentedBar.bottom, self.scrollView.width, self.view.height - _segmentedBar.bottom);
        }
    }
}

- (void)setSegmentedBarHidden:(BOOL)segmentedBarHidden
{
    [self setSegmentedBarHidden:segmentedBarHidden animated:NO completion:nil];
}

- (void)setSegmentedBarHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    if (self.barStyle == JZSegmentedBarStyleEmbeddedInNavigationBar) return;
    
    if (_segmentedBarHidden != hidden) {
        _segmentedBarHidden = hidden;
    }
    CGFloat newOriginY = _segmentedBarHidden ? -_segmentedBarHeight : 0.0;
    // TODO : There may be has some problems.
    void (^moveBlock)(void) = ^{
        
        _segmentedBar.top = newOriginY;
        self.scrollView.frame = CGRectMake(0.0, _segmentedBar.bottom, self.view.width, self.view.height - _segmentedBar.bottom);
    };
    
    if (animated) {
        [UIView animateWithDuration:0.225 animations:moveBlock completion:completion];
    }
    else{
        moveBlock();
        if (completion) {
            completion(YES);
        }
    }
}

#pragma mark - JZSegmentedBar Delegate Methods

- (void)segmentedBar:(JZSegmentedBar *)segmentedBar didSelectSegmentWithIndex:(NSUInteger)index
{
    self.selectedIndex = index;
    _isTapType = YES;
}

#pragma mark - UIScroll Delegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _startPoint = scrollView.contentOffset.x;
    _isDragging = YES;
    _isTapType = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_isTapType) {
        return;
    }
    
    if ([scrollView isEqual:self.scrollView]) {
        
        CGFloat offset = scrollView.contentOffset.x;
        CGFloat innerOffset = (int)offset % (int)_scrollView.width;
        NSUInteger index = offset / _scrollView.width;
        if (innerOffset / _scrollView.width < 0.09 || innerOffset / _scrollView.width > 0.91) {
            return;
        }
        if (self.barStyle == JZSegmentedBarStyleEmbeddedInNavigationBar) {
            
            if (_isDragging) {
                if (offset > _startPoint && self.segmentedBar.buttons.count > _selectedIndex + 1) {
                    index += 1;
                    _nextBtn = self.segmentedBar.buttons[_selectedIndex + 1];
                    _currentBtn = self.segmentedBar.buttons[_selectedIndex];
                }
                else if (offset < _startPoint && (int)_selectedIndex - 1 >= 0) {
                    _currentBtn = self.segmentedBar.buttons[_selectedIndex - 1];
                    _nextBtn = self.segmentedBar.buttons[_selectedIndex];
                    innerOffset = _scrollView.width - innerOffset;
                }
                if (innerOffset > _scrollView.width / 2) {
                    
                    _nextBtn.selected = YES;
                    _currentBtn.selected = NO;
                }
            }
            double scale = (double)(0.15 / _scrollView.width) * innerOffset;
            double colorScale = (double)(innerOffset / _scrollView.width);
            if (colorScale < 0) {
                colorScale = 0;
            }
            if (colorScale > 1) {
                colorScale = 1;
            }
            if (scale < 0) {
                scale = 0;
            }
            if (scale > 0.15) {
                scale = 0.15;
            }
            if (!_isDragging) {
                _nextBtn.transform = CGAffineTransformMakeScale(0.85 + scale, 0.85 + scale);
                _nextBtn.titleLabel.textColor = RGB((234 + 21 * colorScale), (187 + 68 * colorScale), (188 + 67 * colorScale));
                _currentBtn.transform = CGAffineTransformMakeScale(1 - scale, 1 - scale);
                _currentBtn.titleLabel.textColor = RGB((255 - 21 * colorScale), (255 - 68 * colorScale), (255 - 67 * colorScale));
            }else if (index != self.selectedIndex) {
                self.previousSelectedIndex = self.selectedIndex;
                self.selectedIndex = index;
                self.isDragging = NO;
            }
        }
    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isDragging = NO;
    _isTapType = NO;
    if ([scrollView isEqual:self.scrollView]) {
//
        CGFloat offset = scrollView.contentOffset.x;
        NSUInteger index = offset / _scrollView.width;
        CGFloat innerOffset = (int)offset % (int)_scrollView.width;
        // TODO : There can be tunig.
//        if (self.barStyle == JZSegmentedBarStyleEmbeddedInNavigationBar) {
//            
//            UIButton *nextBtn;
//            UIButton *currentBtn;
//            
//            if (offset > _startPoint && self.segmentedBar.buttons.count > _selectedIndex + 1) {
//                
//                nextBtn = self.segmentedBar.buttons[_selectedIndex + 1];
//                currentBtn = self.segmentedBar.buttons[_selectedIndex];
//            }
//            else if (offset < _startPoint && (int)_selectedIndex - 1 >= 0) {
//                
//                nextBtn = self.segmentedBar.buttons[_selectedIndex - 1];
//                currentBtn = self.segmentedBar.buttons[_selectedIndex];
//                innerOffset = _scrollView.width - innerOffset;
//            }
//            if (innerOffset > _scrollView.width / 2) {
//                
//                nextBtn.selected = YES;
//                currentBtn.selected = NO;
//            }
            // item size
//            double scale = (double)(0.25 / _scrollView.width) * innerOffset;
//            if (scale < 0) {
//                scale = 0;
//            }
//            if (scale > 0.25) {
//                scale = 0.25;
//            }
//            nextBtn.transform = CGAffineTransformMakeScale(0.75 + scale, 0.75 + scale);
//            currentBtn.transform = CGAffineTransformMakeScale(1 - scale, 1 - scale);
            
            // item alpha
//            scale = (double)(0.8 / _scrollView.width) * innerOffset;
//            if (scale < 0) {
//                scale = 0;
//            }
//            if (scale > 0.8) {
//                scale = 0.8;
//            }
            //nextBtn.alpha = 0.2 + scale;
            //currentBtn.alpha = 1 - scale;
            
            // item coordinate
//            scale = innerOffset / _scrollView.width * (MAX(currentBtn.centerX, nextBtn.centerX) - MIN(currentBtn.centerX, nextBtn.centerX));
//            CGFloat contentOffsetX = 0;
//            
//            UIScrollView *segmentBarScroll = self.segmentedBar.scrollView;
//            CGFloat segmentedBarLeftOffset = 0;
//            if (self.segmentedBar.superview) {
//                
//                CGRect segmentedBarRect = [self.segmentedBar convertRect:self.segmentedBar.bounds toView:self.segmentedBar.superview];
//                segmentedBarLeftOffset = self.segmentedBar.superview.width / 2 - segmentedBarRect.origin.x;
//            }
//            else{
//                segmentedBarLeftOffset = segmentBarScroll.width / 2;
//            }
//            CGFloat centerWidth = segmentedBarLeftOffset;
//            CGFloat offsetX = segmentBarScroll.contentOffset.x;
//            CGFloat offsetCenterX = offsetX + centerWidth;
//            CGFloat contentSizeWidth = segmentBarScroll.contentSize.width;
//            
//            if (offset > _startPoint) {
//                if (nextBtn.centerX < offsetCenterX && nextBtn.centerX >= centerWidth) {
//                    contentOffsetX = offsetX;
//                }
//                else if (nextBtn.centerX > offsetCenterX) {
//                    if (currentBtn.centerX >= centerWidth) {
//                        contentOffsetX = currentBtn.centerX - centerWidth + scale;
//                    }
//                    else{
//                        contentOffsetX = scale;
//                    }
//                }
//                if (contentOffsetX + segmentBarScroll.width >= contentSizeWidth) {
//                    contentOffsetX = contentSizeWidth - segmentBarScroll.width;
//                }
//            }
//            else{
//                contentOffsetX = contentSizeWidth - segmentBarScroll.width;
//                NSLog(@"%f", offsetX, centerWidth);
//                if (nextBtn.centerX > offsetCenterX && nextBtn.centerX <= contentSizeWidth - centerWidth) {
//                    contentOffsetX = offsetX;
//                }
//                else if (nextBtn.centerX < offsetCenterX) {
//                    if (currentBtn.centerX <= contentSizeWidth - centerWidth) {
//                        contentOffsetX = currentBtn.centerX - centerWidth - scale;
//                    }
//                    else{
//                        contentOffsetX = contentSizeWidth - segmentBarScroll.width - scale;
//                    }
//                }
//                if (contentOffsetX < 0) {
//                    contentOffsetX = 0;
//                }
//            }
//            [self.segmentedBar.scrollView setContentOffset:CGPointMake(contentOffsetX, 0)];
//        }
        if ((int)offset % (int)_scrollView.width == 0) {
//            if (index != self.selectedIndex) {
            
                self.previousSelectedIndex = self.selectedIndex;
                self.selectedIndex = index;
//                self.isDragging = NO;
//            }
        }
    }
}

#pragma mark - pan gesture target

- (void)panScroll:(UIPanGestureRecognizer *)panGesture
{
    CGFloat translation = [panGesture translationInView:panGesture.view].x;
    
    void (^callDelegate)(void) = ^ {
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControllerSpecialPanGesture:)]) {
            [self.delegate segmentedControllerSpecialPanGesture:panGesture];
        }
    };
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        
        _panBeganRange = translation;
        callDelegate();
    }
    if ((translation > _panBeganRange && _scrollView.contentOffset.x == 0)
        || (translation < _panBeganRange && _scrollView.contentOffset.x + _scrollView.width == _scrollView.contentSize.width)) {
        callDelegate();
    }
}

@end

@implementation UIViewController (FWSegmentedBarController)

- (JZSegmentedBarController *)segmentedBarController
{
    UIViewController *ancestorViewController = self.parentViewController;
    
    while (ancestorViewController && ![ancestorViewController isKindOfClass:[JZSegmentedBarController class]]) {
        ancestorViewController = ancestorViewController.parentViewController;
    }
    JZSegmentedBarController *segmentedBarController = [ancestorViewController isKindOfClass:[JZSegmentedBarController class]] ? (JZSegmentedBarController *)ancestorViewController : nil;
    
    return segmentedBarController;
}

- (void)disableExpand
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

@end

#import <objc/runtime.h>
static char transferNavigationBarKey;

@implementation JZSegmentedBarController (attribute)

- (void)setTransferNavigationBarContentToParentController:(BOOL)transferNavigationBarContentToParentController
{
    objc_setAssociatedObject(self, &transferNavigationBarKey, (transferNavigationBarContentToParentController)? @"yes" : @"no", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)transferNavigationBarContentToParentController
{
    if (objc_getAssociatedObject(self, &transferNavigationBarKey)) {
        if ([objc_getAssociatedObject(self, &transferNavigationBarKey) isEqualToString:@"yes"]) {
            return YES;
        }
    }
    return NO;
}

@end
