//
//  b5Cell.h
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/18.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "b1Model.h"
@interface b5Cell : UITableViewCell
@property(nonatomic,strong)UILabel  *rightL;
@property(nonatomic,strong)UILabel  *leftL;
@property(nonatomic,strong)UIView *bigV1;
@property(nonatomic,strong)UIView *bigV;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)b1Model *model;
@end
