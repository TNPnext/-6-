//
//  CommentTableViewCell.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentFrameModel.h"

@class CommentTableViewCell;

@protocol CommentTableViewCellDelegate <NSObject>

- (void)commentTableViewCell:(CommentTableViewCell *)commentTableViewCell supportButtonDidClick:(UIButton *)sender;

@end

@interface CommentTableViewCell : UITableViewCell

@property (strong, nonatomic) CommentFrameModel *commentFrameModel;
@property (weak, nonatomic) id<CommentTableViewCellDelegate> delegate;

@end
