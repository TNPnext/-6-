//
//  MoveTableViewCell.h
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/2.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
@interface MoveTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *datas;
@property(nonatomic,strong)UILabel *numberL;
@property(nonatomic,strong)MoveModel *model;
@end
