//
//  DetailViewController.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicPictureModel.h"

@interface DetailViewController : UIViewController

@property (assign, nonatomic) NSInteger gifCellIndex;
@property (strong, nonatomic) NSMutableArray *dynamicPictureModels;
@property (assign, nonatomic) BOOL isCommentBtnClick;

@end
