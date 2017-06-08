//
//  CommentFrameModel.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "CommentFrameModel.h"

#define leftMargin 15
#define contentFont [UIFont systemFontOfSize:16]

@implementation CommentFrameModel

- (void)setCommentModel:(CommentModel *)commentModel {
    _commentModel = commentModel;
    
    CGFloat titleX = leftMargin;
    CGFloat titleY = 15;
    _titleLabelFrame = CGRectMake(titleX, titleY, 200, 16);
    
    CGSize contentSize = CGSizeZero;
    CGFloat contentW = kMainWidth - 30;
    if (commentModel.message.length) {
        contentSize = [commentModel.message boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:contentFont} context:nil].size;
    }
    CGFloat contentY = isnan(CGRectGetMaxY(self.titleLabelFrame)) ? 0 : CGRectGetMaxY(self.titleLabelFrame) + 15;
    _contentLabelFrame = (CGRect){{leftMargin, contentY}, contentSize};
    
    CGFloat timeH = 16;
    CGFloat timeY = isnan(CGRectGetMaxY(self.contentLabelFrame)) ? 0 : CGRectGetMaxY(self.contentLabelFrame) + 10;
    _timeLabelFrame = CGRectMake(leftMargin, timeY, contentW, timeH);
    
    _commentCellHeight = isnan(CGRectGetMaxY(self.timeLabelFrame)) ? 0 : CGRectGetMaxY(self.timeLabelFrame) + 10;
    
}

@end
