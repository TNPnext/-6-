//
//  YLabelSetView.h
//  MMShow
//
//  Created by Kings Yan on 16/8/19.
//  Copyright © 2016年 cxmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLabelItemModel : NSObject

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) NSString *text;

@end

@interface YLabelSetView : UIView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) CGFloat itemsLeft;
@property (nonatomic, assign) CGFloat itemsTop;
@property (nonatomic, assign) CGFloat itemsRigth;
@property (nonatomic, assign) CGFloat itemsHorizonlGap;
@property (nonatomic, assign) CGFloat itemsVertualGap;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *itemColor;

- (void)reloadData;

@property (nonatomic, assign) BOOL autoresizingHeigth;
@property (nonnull, copy) void (^itemsTapped)(NSInteger idx);

@end
