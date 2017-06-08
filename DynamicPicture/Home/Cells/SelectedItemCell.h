//
//  AblumCell.h
//  TradePlusProfession
//
//  Created by Kings Yan on 2016/11/15.
//  Copyright © 2016年 Chongqing trade + Internet Technology Co., Ltd. All rights reserved.
//

#import "JZCollectionViewModelCell.h"

@interface SelectedItemCell : JZCollectionViewModelCell

@property (nonatomic, strong) UIButton *img;

@end

@interface SelectedItemCellModel : JZBaseModle

@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) BOOL select;

@end
