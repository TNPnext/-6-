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
- (void)pictureCell:(PictureCell *)pictureCell GIFLoaded:(DynamicPictureModel *)model imageSize:(CGSize)imageSize;

@end

@interface PictureCell : UITableViewCell
@property (nonatomic, strong) UIView *backView;//主背景View
@property (nonatomic, strong) UIImageView *placeImage;//封面图View
@property (nonatomic, strong) UIButton *pauseOrPlayBtn;//播放暂停按钮
@property (strong, nonatomic) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *vipView;//vip图标
@property (strong, nonatomic) PictureFrameModel *picFrameModel;

@property (weak, nonatomic) id<PictureCellDelegate> delegate;

@property (strong, nonatomic) UIView  *toolBar;

@end
