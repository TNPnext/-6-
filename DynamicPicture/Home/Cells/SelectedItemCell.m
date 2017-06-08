//
//  AblumCell.m
//  TradePlusProfession
//
//  Created by Kings Yan on 2016/11/15.
//  Copyright © 2016年 Chongqing trade + Internet Technology Co., Ltd. All rights reserved.
//

#import "SelectedItemCell.h"

@interface SelectedItemCell ()

@end

@implementation SelectedItemCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _img = [[UIButton alloc] init];
        _img.layer.masksToBounds = YES;
        _img.layer.borderWidth = 1;
        _img.layer.borderColor = RGB(241, 241, 242).CGColor;
        _img.titleLabel.font = [UIFont systemFontOfSize:17.5];
        [_img setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_img];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _img.frame = CGRectMake(0, 0, 40, 35);
    _img.layer.cornerRadius = _img.height / 2;
    _img.width = [_img.titleLabel.text sizeWithFont:_img.titleLabel.font constrainedToSize:CGSizeMake(1000, 20) lineBreakMode:NSLineBreakByClipping].width + 40;
    _img.centerX = self.width / 2;
    _img.bottom = self.height;
}

+ (CGSize)sizeForItemWithModel:(JZBaseModle *)model
{
    return CGSizeMake(currentScreenWidth() / 4, 50);
}

- (void)setModel:(JZBaseModle *)model
{
    [super setModel:model];
    SelectedItemCellModel *ablum = (SelectedItemCellModel *)model;
    [_img setTitle:(ablum.img)? ablum.img : @"" forState:UIControlStateNormal];
}

@end

@implementation SelectedItemCellModel

@end
