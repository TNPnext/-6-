//
//  DPCommentTool.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/29.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPCommentTool : NSObject

@property (strong, nonatomic) NSMutableArray *modifiedCommentLists;

+ (instancetype)shareInstance;

@end
