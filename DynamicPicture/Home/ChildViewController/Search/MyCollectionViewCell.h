//
//  MyCollectionViewCell.h
//  DynamicPicture
//
//  Created by TNP on 2017/4/20.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearModel.h"
@interface MyCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imgaeV;
@property(nonatomic,strong)UILabel *titles;
@property(nonatomic,strong)SearModel *model;
@end
