//
//  JZSegmentedBar.h
//  TestSegmentedController
//
//  Created by Kings Yan on 15/1/13.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZSegmentedBar;

@protocol JZSegmentedBarDelegate <NSObject>
@required
- (void)segmentedBar:(JZSegmentedBar *)segmentedBar didSelectSegmentWithIndex:(NSUInteger)index;

@end

typedef NS_ENUM (NSUInteger, JZSegmentedBarStyle)
{
    JZSegmentedBarStyleEmbeddedInNavigationBar = 1,
    JZSegmentedBarStyleNone = 4,
};

typedef NS_ENUM (NSUInteger, JZSegmentedBarArrowViewType)
{
    JZSegmentedBarArrowViewTypeNormal = 0,
    JZSegmentedBarArrowViewTypeHorizetalLine = 1,
};

NS_CLASS_AVAILABLE_IOS(5_0) @interface JZSegmentedBar : UIView <UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) NSArray *buttons;
@property (nonatomic, strong) UIImageView *arrowView;


- (id)initWithStyle:(JZSegmentedBarStyle)style;
@property (nonatomic, assign) JZSegmentedBarStyle Style;  // difault is JZSegmentedBarStyleNormal.

@property (nonatomic, weak) id<JZSegmentedBarDelegate> delegate;

@property (nonatomic, strong) UIImage *arrowImage;
@property (nonatomic, assign) CGFloat arrowOffsetY;
@property (nonatomic, assign) JZSegmentedBarArrowViewType arrowStyle;

// default is 30;
@property (nonatomic, assign) CGFloat alignmentGap;
// set buttons autolational layout; availabel only JZBarStyle isEqul JZSegmentedBarStyleEmbeddedInNavigationBar; Default is YES.
@property (nonatomic, assign) BOOL autoAlignment;
@property (nonatomic, assign) BOOL allAlignmentCenter;

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *selectedImages;

@property (nonatomic, strong) UIColor *buttonbackgroundColor;
@property (nonatomic, strong) UIColor *selectedButtonbackgroundColor;
@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIFont  *titleFont;
@property (nonatomic, assign) CGPoint titleOffset;


- (void)setButtonSelectedAtIndex:(NSUInteger)index animation:(BOOL)animate isDragging:(BOOL)isDragging;

/*
 * when SegementBarTypeIndependentPanel set frame is completed, implemention layoutSegementBarTypeIndependentPanel 
 * block
 */
@property (nonatomic, copy) void (^layoutSegementBarTypeIndependentPanel)(UIView *);
/*
 * when SegementBar set frame is completed, implemention layoutSegementBarComplementedBlock block
 */
@property (nonatomic, copy) void (^layoutSegementBarComplementedBlock)(UIView *);

@end
