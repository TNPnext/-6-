//
//  CommentCollectionViewCell.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoCommentCell.h"

@class CommentCollectionViewCell;
@class DynamicPictureModel;
@class CommentModel;
@class PictureCell;

typedef NS_ENUM(NSInteger, TapType){
    kTapTypeUp = 0,
    kTapTypeDown,
    kTapTypeShare
};

@protocol CommentCollectionViewCellDelegate <NSObject>

- (void)commentCollectionViewCell:(CommentCollectionViewCell *)commentCollectionViewCell supportBtnClick:(UIButton *)supportBtn commentModels:(NSMutableArray *)commentModels;

- (void)commentCollectionViewCell:(CommentCollectionViewCell *)commentCollectionViewCell GIFLoaded:(DynamicPictureModel *)model imageSize:(CGSize)imageSize;

- (void)commectCollectionDetailPictureCell:(PictureCell *)cell;
- (void)ADCellClick;//点击广告
@end

@interface CommentCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DynamicPictureModel *dynamicPictureModel;
@property (strong, nonatomic) NSMutableArray *commentModels;
@property (weak, nonatomic) id<CommentCollectionViewCellDelegate> delegate;

@end
