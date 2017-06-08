//
//  YLabelSetView.m
//  MMShow
//
//  Created by Kings Yan on 16/8/19.
//  Copyright © 2016年 cxmx. All rights reserved.
//

#import "YLabelSetView.h"
#import "UIView+Category.h"
#import "JZMacro.h"

@implementation YLabelItemModel

@end

@interface YLabelSetView ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation YLabelSetView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _itemsLeft = 0;
        _itemsTop = 0;
        _itemsRigth = 0;
        _itemsHorizonlGap = 10;
        _itemsVertualGap = 20;
        _itemFont = [UIFont systemFontOfSize:15];
        _itemColor = [UIColor blackColor];
        _autoresizingHeigth = YES;
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
        _titleLabel.textColor = [UIColor blueColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)reloadData
{
    [self removeAllSubviewsExcludView:_titleLabel];
    if (_title) {
        self.title = _title;
    }
    if (_items) {
        
        CGFloat lastLeft = _itemsLeft;
        CGFloat lastTop = _itemsTop + ((_title)? _titleLabel.bottom : 0);
        for (int i = 0; i < _items.count; i ++) {
            
            UIButton *itemLabel = [[UIButton alloc] initWithFrame:CGRectZero];
            itemLabel.backgroundColor = [UIColor clearColor];
            itemLabel.titleLabel.font = _itemFont;
            itemLabel.titleLabel.lineBreakMode = NSLineBreakByClipping;
            itemLabel.left = lastLeft;
            itemLabel.top = lastTop;
            if ([_items[i] isMemberOfClass:[YLabelItemModel class]]) {
                
                YLabelItemModel *model = _items[i];
                [itemLabel setTitle:model.text forState:UIControlStateNormal];
                if (model.textColor) {
                    [itemLabel setTitleColor:model.textColor forState:UIControlStateNormal];
                }
                else{
                    [itemLabel setTitleColor:_itemColor forState:UIControlStateNormal];
                }
            }
            else{
                NSString *item = _items[i];
                [itemLabel setTitleColor:_itemColor forState:UIControlStateNormal];
                [itemLabel setTitle:item forState:UIControlStateNormal];
            }
            CGFloat width =[itemLabel.titleLabel.text boundingRectWithSize:CGSizeMake(1000, itemLabel.titleLabel.font.pointSize + 5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
            //CGFloat width = [itemLabel.titleLabel.text sizeWithFont:itemLabel.titleLabel.font constrainedToSize:CGSizeMake(1000, itemLabel.titleLabel.font.pointSize + 5)  lineBreakMode:NSLineBreakByClipping].width + 2;
            itemLabel.width = width;
            itemLabel.height = itemLabel.titleLabel.font.pointSize + 2;
            itemLabel.tag = i + 100;
            [itemLabel addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:itemLabel];
            
            if (itemLabel.right > self.width - _itemsRigth) {
                
                lastLeft = _itemsLeft;
                itemLabel.left = lastLeft;
                
                lastTop += itemLabel.height + _itemsVertualGap;
                itemLabel.top = lastTop;
            }
            
            lastLeft += itemLabel.width + _itemsHorizonlGap;
            
            if (_autoresizingHeigth && i == _items.count - 1) {
                self.height = itemLabel.bottom;
            }
        }
    }
}

- (void)tapped:(UIButton *)sender
{
    if (self.itemsTapped) {
        self.itemsTapped(sender.tag - 100);
    }
}

@end
