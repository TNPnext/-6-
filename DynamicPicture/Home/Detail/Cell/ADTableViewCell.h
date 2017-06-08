//
//  ADTableViewCell.h
//  DynamicPicture
//
//  Created by TNP on 17/1/21.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView *ADImage;
@end
