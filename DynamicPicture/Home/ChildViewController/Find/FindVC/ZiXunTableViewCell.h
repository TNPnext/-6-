//
//  ZiXunTableViewCell.h
//  DynamicPicture
//
//  Created by TNP on 2017/4/26.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFAppModel.h"
@interface ZiXunTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *upDate;
@property(nonatomic,strong)UILabel *smallTitle;
@property(nonatomic,strong)UIImageView *headV;
@property(nonatomic,strong)ZiXunModel *model;
@end
