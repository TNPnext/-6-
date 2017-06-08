//
//  AblumCell.m
//  TradePlusProfession
//
//  Created by Kings Yan on 2016/11/15.
//  Copyright © 2016年 Chongqing trade + Internet Technology Co., Ltd. All rights reserved.
//

#import "SelectedItemCell.h"
#import "CategoryModel.h"

@interface SelectedItemCell ()

@property (nonatomic, strong) UIImageView *mark;

@end

@implementation SelectedItemCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _title = [[UILabel alloc] init];
        _title.layer.masksToBounds = YES;
        _title.layer.borderWidth = 1;
        _title.layer.borderColor = RGB(241, 241, 242).CGColor;
        _title.font = [UIFont systemFontOfSize:17.5];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_title];
        
        _mark = [[UIImageView alloc] init];
        _mark.contentMode = UIViewContentModeScaleAspectFill;
        _mark.image = [UIImage imageNamed:@"ico_selected"];
        _mark.layer.masksToBounds = YES;
        [self addSubview:_mark];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _title.frame = CGRectMake(0, 0, 40, 35);
    _title.layer.cornerRadius = _title.height / 2;
    _title.width = [_title.text sizeWithFont:_title.font constrainedToSize:CGSizeMake(1000, 20) lineBreakMode:NSLineBreakByClipping].width + 40;
    _title.centerX = self.width / 2;
    _title.bottom = self.height;
    
    self.mark.frame = CGRectMake(0, _title.top, 15, 15);
    _mark.right = _title.right;
    _mark.layer.cornerRadius = _mark.height / 2;
}

+ (CGSize)sizeForItemWithModel:(JZBaseModle *)model
{
    CategoryModel *item = (CategoryModel *)model;
    CGFloat width = [(item.category)? item.category : @"" sizeWithFont:[UIFont systemFontOfSize:17.5] constrainedToSize:CGSizeMake(1000, 20) lineBreakMode:NSLineBreakByClipping].width + 50;
    return CGSizeMake(width, 50);
}

- (void)setModel:(JZBaseModle *)model
{
    [super setModel:model];
    CategoryModel *item = (CategoryModel *)model;
    _title.text = (item.category)? item.category : @"";
    if ([item.recommend integerValue] == 1) {
        _mark.hidden = NO;
    }
    else{
        _mark.hidden = YES;
    }
}

@end
