//
//  JFSegmentedBarController.m
//  WAF
//
//  Created by Kings Yan on 15/9/28.
//  Copyright © 2015年 西安交大捷普网络科技有限公司. All rights reserved.
//

#import "JFSegmentedBarController.h"
#import "UITabBar+Category.h"
#import "TabButton.h"
#import <Accelerate/Accelerate.h>
#import "UIView+Category.h"
#import "UIImage+Extension.h"
#import "JZDevice.h"

@interface JFSegmentedBarController () <UITabBarButtonDelegate>

@property (nonatomic, assign) BOOL hasMidButton;

@property (nonatomic, assign, readwrite) JFSegmentedBarControllerSegmentedMenuStatus segmentedMenuStatus;

@end

@implementation JFSegmentedBarController
{
    JZSegmentedBar *_segmentedBarForBackup;
    UITapGestureRecognizer *_tapForSegmentedMenu;
    NSInteger _selectedIdxForSegmentBarMenu;
    CGFloat _scaleForSegmentedMenu;
    CGFloat _gapForSegmentedMenu;
    NSMutableArray *_titlesForSegmentedMenu;
}

- (id)initWithControllers:(NSArray *)controllers tabBarItemTitles:(NSArray *)titleArray images:(NSArray *)imageArray
           selectedImages:(NSArray *)selectedImageArray tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage *)bgImage
{
    self = [self initWithStyle:JZSegmentedBarStyleTabbar];
    if (self) {
        
        self.parallaxEnable = YES;
        self.viewControllers = [NSMutableArray arrayWithArray:controllers];
        [self setTabBarItemTitles:titleArray images:imageArray selectedImages:selectedImageArray tabBarWidth:barWidth backgroundImage:bgImage];
    }
    
    return self;
}

- (void)setTabBarItemTitles:(NSArray *)titleArray images:(NSArray *)imageArray selectedImages:(NSArray *)selectedImageArray
                tabBarWidth:(CGFloat)barWidth backgroundImage:(UIImage *)bgImage
{
    self.tabBar.categoryDelegate = self;
    [self.tabBar setItemTitles:titleArray images:imageArray selectedImages:selectedImageArray tabBarWidth:barWidth backgroundImage:bgImage];
}

#pragma mark - TabBar Category Delegate Method.

- (void)tabBar:(UITabBar *)tabBar buttonDidClickedAtIndex:(int)index
{
    NSInteger controllerIndex;
    if (self.hasMidButton) {
        if (index > self.viewControllers.count / 2) {
            controllerIndex = index - 1;
        }
        else if (index < self.viewControllers.count / 2) {
            controllerIndex = index;
        }
        else{
            controllerIndex = -1;
        }
    }
    else{
        controllerIndex = index;
    }
    [self setIndexPropertiesWithIdx:controllerIndex];
}

- (void)selectTabBarWithIndex:(NSInteger)controllerIndex
{
    if (self.barStyle != JZSegmentedBarStyleTabbar) {
        [super setSelectedIndex:controllerIndex];
    }
    // mid button clicked
    if (controllerIndex == -1) {
        //        if ([self.xbDelegate respondsToSelector:@selector(tabBarControllerMidButtonDidTaped:)]) {
        //            [self.xbDelegate tabBarControllerMidButtonDidTaped:self];
        //        }
        return;
    }
    
    NSInteger tapIndex;
    if (self.hasMidButton) {
        if (controllerIndex >= self.viewControllers.count / 2) {
            tapIndex = controllerIndex + 1;
        }
        else{
            tapIndex = controllerIndex;
        }
    }
    else{
        tapIndex = controllerIndex;
    }
    
    NSInteger tapSelectedIndex;
    if (self.hasMidButton) {
        if (self.selectedIndex >= self.viewControllers.count / 2) {
            tapSelectedIndex = self.selectedIndex + 1;
        }
        else{
            tapSelectedIndex = self.selectedIndex;
        }
    }
    else{
        tapSelectedIndex = self.selectedIndex;
    }
    
    int i = (int)tapSelectedIndex + BUTTON_BASE_TAG;
    UIView *v = [self.tabBar viewWithTag:i];
    if ([v isMemberOfClass:[TabButton class]]) {
        
        TabButton *button = (TabButton *)v;
        button.selected = NO;
    }
    
    v = [self.tabBar viewWithTag:tapIndex + BUTTON_BASE_TAG];
    if ([v isMemberOfClass:[TabButton class]]) {
        
        TabButton *button = (TabButton *)v;
        button.selected = YES;
    }
    [super setSelectedIndex:controllerIndex];
}

- (void)setButtonSelected:(TabButton *)button
{
    button.userInteractionEnabled = NO;
    button.selected = YES;
}

- (void)setTabBarBadgeNum:(int)number atIndex:(int)index
{
    [self.tabBar setBadgeNum:number atIndex:index];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self selectTabBarWithIndex:selectedIndex];
    if ([self.xbDelegate respondsToSelector:@selector(xbTabBar:didSelectedItem:)]) {
        [self.xbDelegate xbTabBar:self didSelectedItem:selectedIndex];
    }
}

- (void)refreshTabBarTitles:(NSArray *)titleArray
{
    [self.tabBar refreshTabTitles:titleArray];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)setIndexPropertiesWithIdx:(NSInteger)idx
{
    if (self.selectedIndex == 404) {
        self.previousSelectedIndex = idx;
    }
    else{
        self.previousSelectedIndex = self.selectedIndex;
    }
    self.selectedIndex = idx;
}

#pragma mark - UIScrllView Delegate

CGFloat startPoint = 0;
UIColor *startInformationBarTintColor;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [super scrollViewWillBeginDragging:scrollView];
    CGFloat offset = scrollView.contentOffset.x;
    startPoint = offset;
#if DEBUG
//    NSLog(@"began");
#endif
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_segmentedMenuStatus) {
        
        // Implementation for segmentedMenu.
        [self scrollViewDidScrollForSegmentedMenuWithScroll:scrollView];
        return;
    }
    [super scrollViewDidScroll:scrollView];
    if (self.barStyle != JZSegmentedBarStyleTabbar || !_parallaxEnable) {
        return;
    }
#if DEBUG
//    NSLog(@"%f", scrollView.contentOffset.x);
#endif
    // For navigationBar parallax effect.
    CGFloat width = self.view.width;
    
    CGFloat offset = scrollView.contentOffset.x;
    
    CGFloat innerOffset = (int)offset % (int)width;
    CGFloat gap = width / 2;
    int startIdx = 0;
    
    void (^changePosition)(CALayer *layerLeft, CALayer *layerRight) = ^(CALayer *layerLeft, CALayer *layerRigth) {
        
        [layerLeft setValue:[NSNumber numberWithFloat:(float)(innerOffset / width) * gap + width / 2] forKeyPath:@"position.x"];
        [layerRigth setValue:[NSNumber numberWithFloat:-gap + (float)(innerOffset / width) * gap + width / 2] forKeyPath:@"position.x"];
    };
    void (^changeOpacity)(CALayer *layerLeft, CALayer *layerRight) = ^(CALayer *layerLeft, CALayer *layerRigth) {
        
        [layerLeft setValue:[NSNumber numberWithFloat:1 - (float)(innerOffset / width) * 1] forKeyPath:@"opacity"];
        [layerRigth setValue:[NSNumber numberWithFloat:(float)(innerOffset / width) * 1] forKeyPath:@"opacity"];
    };
    void (^change)(CALayer *layerLeft, CALayer *layerRight) = ^(CALayer *layerLeft, CALayer *layerRigth){
        
        changePosition(layerLeft, layerRigth);
        changeOpacity(layerLeft, layerRigth);
    };
    
    if (offset > startPoint) {
        
        startIdx = offset / width;
        switch (startIdx) {
            case 0: {
                change(_mainInformationController.navigationController.navigationBar.layer,
                       _mainEquipmentManagedController.navigationController.navigationBar.layer);
            } break;
            case 1: {
                change(_mainEquipmentManagedController.navigationController.navigationBar.layer,
                       _mainTechnologySupportController.navigationController.navigationBar.layer);
            } break;
            case 2: {
                change(_mainTechnologySupportController.navigationController.navigationBar.layer,
                       _mainMeController.navigationController.navigationBar.layer);
            } break;
            default:
                break;
        }
    }
    else if (offset < startPoint) {
        
        startIdx = offset / width + 1;
        switch (startIdx) {
            case 1: {
                change(_mainInformationController.navigationController.navigationBar.layer,
                       _mainEquipmentManagedController.navigationController.navigationBar.layer);
            } break;
            case 2: {
                change(_mainEquipmentManagedController.navigationController.navigationBar.layer,
                       _mainTechnologySupportController.navigationController.navigationBar.layer);
            } break;
            case 3: {
                change(_mainTechnologySupportController.navigationController.navigationBar.layer,
                       _mainMeController.navigationController.navigationBar.layer);
            } break;
            default:
                break;
        }
    }
}

#pragma mark - Segmented menu

@synthesize contentInteractionAtSegmentedMenuLoading = _contentInteractionAtSegmentedMenuLoading;

- (instancetype)initWithStyle:(JZSegmentedBarStyle)style
{
    if (self = [super initWithStyle:style]) {
        self.contentInteractionAtSegmentedMenuLoading = YES;
    }
    return self;
}

- (void)openSegmentedMenuWithImage:(UIImage *)img
{
    self.segmentedMenuStatus = YES;
    _segmentedMenuLoading = YES;
    
    if (self.barStyle == JZSegmentedBarStyleTabbar) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
    
    // blur bg.
    UIImage *bgimg = img;
    if (!bgimg) {
        
        bgimg = [self.view capture];
        
        UIImage *image = [self applyBlurOnImage:bgimg withRadius:1];
        image = [UIImage imageWithImage:image withSize:CGSizeMake(image.size.width, image.size.height)];
        CGRect rect = CGRectMake(image.size.width / 3, image.size.height / 3, image.size.width / 3, image.size.height / 3);
        rect = CGRectMake(image.size.width / 5, image.size.height / 5, image.size.width / 5 * 3, image.size.height / 5 * 3);
        
        image = [image clipImageFromRect:rect];
        
        [self.scrollView setbackgroundImage:image];
    }
    else{
        [self.scrollView setbackgroundImage:bgimg];
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    
    
    // show all views.
    NSInteger selectedIdx = self.selectedIndex;
    NSInteger previousIdx = self.previousSelectedIndex;
    for (int i = 0; i < self.viewControllers.count; i ++) {
        self.selectedIndex = i;
    }
    self.selectedIndex = previousIdx;
    self.selectedIndex = selectedIdx;
    _selectedIdxForSegmentBarMenu = self.selectedIndex;
    
    // open segmentedMenu.
    CGFloat scale = 0.7;
    if (currentDeviceModl() == JZ_DEVICE_IPHONE_6PLUS) {
        scale = 0.6;
    }
    if (currentDeviceIOSModel() == JZ_DEVICE_IOS_MODEL_IPAD) {
        scale = 0.6;
    }
    self.view.alertLable.textColor = [UIColor clearColor];
    [self transformWithScale:scale animation:YES complete:^(BOOL finished) {
        
        if (self.barStyle == JZSegmentedBarStyleEmbeddedInNavigationBar) {
            if (self.parentViewController.navigationItem.titleView) {
                
                _segmentedBarForBackup = (JZSegmentedBar *)self.parentViewController.navigationItem.titleView;
                self.parentViewController.navigationItem.titleView = nil;
                self.parentViewController.title = self.segmentedBar.titles[self.selectedIndex];
            }
        }
        if (self.barStyle == JZSegmentedBarStyleNone) {
            
            self.view.alertLable.centerY = self.scrollView.height * scale + (self.scrollView.height - self.scrollView.height * scale) / 4 * 2 + 33;
            self.view.alertLable.font = [UIFont systemFontOfSize:17.5];
            self.view.alertLable.textColor = [UIColor whiteColor];
        }
        [self setParentSegmentedBarControllerScrollEnable:NO];
        if (self.segmentedBarMenuDidOpen) {
            self.segmentedBarMenuDidOpen(self);
        }
    }];
    
    self.scrollView.pagingEnabled = NO;
    
    if (self.segmentedBarController && self.segmentedBarController.barStyle == JZSegmentedBarStyleTabbar) {
        self.segmentedBarController.tabBar.hidden = YES;
    }
    if (self.tabBar) {
        self.tabBar.hidden = YES;
    }
    _tapForSegmentedMenu = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTapped:)];
    [self.scrollView addGestureRecognizer:_tapForSegmentedMenu];
}

- (UIImage *)applyBlurOnImage:(UIImage *)imageToBlur withRadius:(CGFloat)blurRadius
{
    if ((blurRadius <= 0.0f) || (blurRadius > 1.0f)) {
        blurRadius = 0.5f;
    }

    int boxSize = (int)(blurRadius * 200);
    boxSize -= (boxSize % 2) + 1;

    CGImageRef rawImage = imageToBlur.CGImage;

    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;

    CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);

    inBuffer.width = CGImageGetWidth(rawImage);
    inBuffer.height = CGImageGetHeight(rawImage);
    inBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);

    pixelBuffer = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));

    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(rawImage);
    outBuffer.height = CGImageGetHeight(rawImage);
    outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(imageToBlur.CGImage));

    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);

    return returnImage;
}

- (void)closeSegmentedMenu
{
    self.segmentedMenuStatus = NO;
    _segmentedMenuLoading = YES;
    
    if (self.barStyle == JZSegmentedBarStyleTabbar) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    
    [self transformWithScale:1 animation:YES complete:^(BOOL finished) {
        
        [self.scrollView removeGestureRecognizer:_tapForSegmentedMenu];
        self.scrollView.pagingEnabled = YES;
        [self.scrollView setbackgroundImage:nil];
        self.view.backgroundColor = [UIColor clearColor];
        if (_segmentedBarForBackup) {
            
            self.parentViewController.navigationItem.titleView = _segmentedBarForBackup;
            _segmentedBarForBackup = nil;
        }
        [self setParentSegmentedBarControllerScrollEnable:YES];
        self.selectedIndex = _selectedIdxForSegmentBarMenu;
        if (self.segmentedBarMenuDidClose) {
            self.segmentedBarMenuDidClose(self);
        }
    }];
    if (self.segmentedBarController && self.segmentedBarController.barStyle == JZSegmentedBarStyleTabbar) {
        self.segmentedBarController.tabBar.hidden = NO;
    }
    if (self.tabBar) {
        self.tabBar.hidden = NO;
    }
}

- (void)transformWithScale:(CGFloat)scale animation:(BOOL)animate complete:(void(^)(BOOL finished))complement
{
    _scaleForSegmentedMenu = scale;
    _gapForSegmentedMenu = 35;
    
    CGFloat scrollVWidth = self.scrollView.width;
    
    if (scale != 1) {
        self.scrollView.contentSize = CGSizeMake(self.viewControllers.count * (scrollVWidth * scale + _gapForSegmentedMenu) + scrollVWidth * (1 - scale) - _gapForSegmentedMenu, self.scrollView.height);
    }
    else{
        self.scrollView.contentSize = CGSizeMake(self.viewControllers.count * scrollVWidth, self.scrollView.height);
    }
    __weak typeof(self) weakSelf = self;
    [self.viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (self.barStyle == JZSegmentedBarStyleTabbar) {
            if ([obj isKindOfClass:[UINavigationController class]]) {
                ((UINavigationController *)obj).navigationBar.titleTextAttributes = @{UITextAttributeTextColor:(scale == 1)? [UIColor blackColor] : [UIColor clearColor]};
                if (((UINavigationController *)obj).visibleViewController.navigationItem.titleView) {
                    ((UINavigationController *)obj).visibleViewController.navigationItem.titleView.hidden = (scale == 1)? NO : YES;
                }
            }
        }
        UIView *view = ((UIViewController *)obj).view;
        if (idx == _selectedIdxForSegmentBarMenu) {
            
            [view bringToFront];
            [UIView animateWithDuration:(animate)? 0.3 : 0 animations:^{
                view.transform = CGAffineTransformMakeScale(scale, scale);
            } completion:^(BOOL finished) {

                if (scale != 1 && !_hiddenTitle) {
                    [weakSelf setTitlesWithScale:scale];
                }
                _segmentedMenuLoading = NO;
                if (complement) {
                    complement(YES);
                }
            }];
        }
        else{
            view.transform = CGAffineTransformMakeScale(scale, scale);
        }
        if (scale != 1) {
            
            
            view.left = idx * (scrollVWidth * scale + _gapForSegmentedMenu) + (1 - scale) * scrollVWidth / 2;
            view.userInteractionEnabled = _contentInteractionAtSegmentedMenuLoading;
        }
        else{
            view.left = idx * scrollVWidth + (scrollVWidth - view.width) / 2;
            view.userInteractionEnabled = YES;
        }
    }];
    if (scale == 1 && !_hiddenTitle) {
        [self setTitlesWithScale:scale];
    }
    if (scale == 1 && self.barStyle == JZSegmentedBarStyleNone) {
        self.view.alertLable.text = @"";
    }
    if (scale == 1) {
        [self.scrollView setContentOffset:CGPointMake(_selectedIdxForSegmentBarMenu * scrollVWidth, 0)];
    }
    else{
        [self.scrollView setContentOffset:CGPointMake(_selectedIdxForSegmentBarMenu * (scrollVWidth * scale + _gapForSegmentedMenu), 0)];
    }
}

- (void)setTitlesWithScale:(CGFloat)scale
{
    void (^emptyTitles)(void) = ^{
        
        if (!_titlesForSegmentedMenu) {
            return;
        }
        for (UILabel *titleLab in _titlesForSegmentedMenu) {
            [titleLab removeFromSuperview];
        }
        [_titlesForSegmentedMenu removeAllObjects];
        _titlesForSegmentedMenu = nil;
    };
    emptyTitles();
    if (scale != 1) {
        
        emptyTitles();
        _titlesForSegmentedMenu = [[NSMutableArray alloc] init];
        CGFloat scrollVWidth = self.scrollView.width;
        __weak typeof (self) weakSelf = self;
        [self.viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIViewController *controller = (UIViewController *)obj;
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, 20)];
            titleLab.font = [UIFont boldSystemFontOfSize:15];
            titleLab.textColor = [UIColor blueColor];
            titleLab.backgroundColor = [UIColor clearColor];
            titleLab.textAlignment = NSTextAlignmentCenter;
            titleLab.centerX = idx * (scrollVWidth * scale + _gapForSegmentedMenu) + (1 - scale) * scrollVWidth / 2 + scrollVWidth * scale / 2;
            titleLab.centerY = controller.view.top - 16;
            [weakSelf.scrollView addSubview:titleLab];
            [_titlesForSegmentedMenu addObject:titleLab];
            
            if (self.barStyle == JZSegmentedBarStyleTabbar) {
                titleLab.text = controller.title;
            }
            else{
                titleLab.text = self.segmentedBar.titles[idx];
            }
            titleLab.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                titleLab.alpha = 1;
            }];
        }];
    }
}

- (void)scrollViewDidScrollForSegmentedMenuWithScroll:(UIScrollView *)scrollView
{
    if (self.barStyle != JZSegmentedBarStyleEmbeddedInNavigationBar && self.barStyle != JZSegmentedBarStyleNone) {
        return;
    }
    // segmentedItem title.
    CGFloat scrollWidthForSegmentedMenu = scrollView.width * _scaleForSegmentedMenu;
    CGFloat offset = scrollView.contentOffset.x + (scrollWidthForSegmentedMenu + _gapForSegmentedMenu) / 2;
    if (offset < 0) {
        offset = 0;
    }
    NSInteger idx = offset / (scrollWidthForSegmentedMenu + _gapForSegmentedMenu);
    if (idx < 0) {
        idx = 0;
    }
    if (idx < self.segmentedBar.titles.count) {
        
        if (self.barStyle == JZSegmentedBarStyleEmbeddedInNavigationBar) {
            self.parentViewController.title = self.segmentedBar.titles[idx];
        }
        if (self.barStyle == JZSegmentedBarStyleNone) {
            self.view.alertLable.text = self.segmentedBar.titles[idx];
        }
    }
}

- (void)tapTapped:(UIGestureRecognizer *)gesture
{
    UIScrollView *scroll = (UIScrollView *)gesture.view;
    CGFloat scrollWidthForSegmentedMenu = scroll.width * _scaleForSegmentedMenu;
    CGFloat offset = scroll.contentOffset.x + (scrollWidthForSegmentedMenu + _gapForSegmentedMenu) / 2;
    if (offset < 0) {
        offset = 0;
    }
    NSInteger idx = offset / (scrollWidthForSegmentedMenu + _gapForSegmentedMenu);
    _selectedIdxForSegmentBarMenu = idx;
    if (!_segmentedMenuLoading) {
        [self closeSegmentedMenu];
    }
}

- (void)setParentSegmentedBarControllerScrollEnable:(BOOL)enable
{
    JZSegmentedBarController *parentSegmentedBarController = (JZSegmentedBarController *)[self _searchViewControllerInParentViewControllerWithClass:[JZSegmentedBarController class]];
    if (parentSegmentedBarController) {
        parentSegmentedBarController.scrollView.scrollEnabled = enable;
    }
}

- (UIViewController *)_searchViewControllerInParentViewControllerWithClass:(Class)parentClass
{
    UIViewController *ancestorViewController = self.parentViewController;
    while (ancestorViewController && ![ancestorViewController isKindOfClass:parentClass]) {
        ancestorViewController = ancestorViewController.parentViewController;
    }
    return ancestorViewController;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_segmentedMenuStatus) {
        [super viewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!_segmentedMenuStatus) {
        [super viewDidAppear:animated];
    }
}

@end
