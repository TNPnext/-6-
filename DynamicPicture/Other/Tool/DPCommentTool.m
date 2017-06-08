//
//  DPCommentTool.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/29.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "DPCommentTool.h"

@implementation DPCommentTool

static DPCommentTool *_instance;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        NSMutableArray *arr = [NSMutableArray array];
        _instance.modifiedCommentLists = arr;
    });
    return _instance;
}

@end
