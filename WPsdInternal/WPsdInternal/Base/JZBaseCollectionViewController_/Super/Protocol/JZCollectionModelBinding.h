//
//  JZCollectionModelBinding.h
//  GSJuZhang
//
//  Created by __Qing__ on 15/1/30.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZBaseModle.h"

@protocol JZCollectionModelBinding <NSObject>

@property (nonatomic, strong) JZBaseModle *model;

@property (nonatomic, assign) NSUInteger idx;

+ (CGSize)sizeForItemWithModel:(JZBaseModle *)model;

@end
