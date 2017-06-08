//
//  OrderCell.h
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/23.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "b1Model.h"
@interface OrderCell : UITableViewCell

@property(nonatomic,strong)UILabel *numberL;

@property(nonatomic,strong)UILabel *typeL;

@property(nonatomic,strong)UILabel *multipleL;

@property(nonatomic,strong)UILabel *witeL;

@property(nonatomic,strong)b2Model *model;

@end
