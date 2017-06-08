//
//  CommentFrameModel.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface CommentFrameModel : NSObject

@property (strong, nonatomic) CommentModel *commentModel;

@property (assign, nonatomic, readonly) CGRect titleLabelFrame;
@property (assign, nonatomic, readonly) CGRect contentLabelFrame;
@property (assign, nonatomic, readonly) CGRect timeLabelFrame;

@property (assign, nonatomic, readonly) CGFloat commentCellHeight;

@end
