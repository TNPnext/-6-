//
//  JZCollectionViewModelCell.h
//  GSJuZhang
//
//  Created by __Qing__ on 15/1/30.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JZCollectionModelBinding.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+SDWebImageExtenson.h"
#import "UITableViewCell+Extension.h"

@interface JZCollectionViewModelCell : UICollectionViewCell <JZCollectionModelBinding>

@property (nonatomic, strong) JZBaseModle *model;

@property (nonatomic, assign) NSUInteger idx;

+ (CGSize)sizeForItemWithModel:(JZBaseModle *)model;

@end
