//
//  PictureFrameModel.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicPictureCell.h"
#import "DynamicPictureModel.h"

@interface PictureFrameModel : NSObject

@property (strong, nonatomic) DynamicPictureModel *pictureModel;

@property (assign, nonatomic, readonly) CGRect titleLabelFrame;
@property (assign, nonatomic, readonly) CGRect gitFrame;
@property (assign, nonatomic, readonly) CGRect pictureFrame;
@property (assign, nonatomic, readonly) CGRect toolBarFrame;
@property (assign, nonatomic, readonly) CGFloat topViewHeight;

@property (assign, nonatomic, readonly) CGFloat cellHeight;

@end
