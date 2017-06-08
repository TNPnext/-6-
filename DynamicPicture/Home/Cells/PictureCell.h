//
//  PictureCell.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureFrameModel.h"

@class PictureCell;

@protocol PictureCellDelegate <NSObject>

- (void)pictureCell:(PictureCell *)pictureCell toolBarButtonDidClick:(UIButton *)sender;

@end

@interface PictureCell : UITableViewCell

@property (strong, nonatomic) PictureFrameModel *picFrameModel;

@property (weak, nonatomic) id<PictureCellDelegate> delegate;

@property (strong, nonatomic) UIImageView *picView;
@property (strong, nonatomic) UIView *toolBar;

@end
