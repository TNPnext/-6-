//
//  JZCollectionViewModelCell.m
//  GSJuZhang
//
//  Created by __Qing__ on 15/1/30.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZCollectionViewModelCell.h"

@implementation JZCollectionViewModelCell

@synthesize model = _model,
idx = _idx;

- (void)dealloc
{
#if DEBUG
    NSLog(@"<<<%@>>>", self);
#endif
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.clipsToBounds = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

+ (CGSize)sizeForItemWithModel:(JZBaseModle *)model
{
    return CGSizeMake(152, 242);
}

- (void)setModel:(JZBaseModle *)model
{
    // could subController implement ...
    _model = model;
}

@end
