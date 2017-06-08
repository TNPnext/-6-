//
//  CommentModel.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (instancetype)commentWithDict:(NSDictionary *)dict {
    CommentModel *commentModel = [[self alloc] init];
    [commentModel setValuesForKeysWithDictionary:dict];
    return commentModel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _commentID = value;
    }
}

- (void)setDateline:(NSString *)dateline {
    _dateline = dateline;
    NSTimeInterval timeInterval = [dateline floatValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yy-MM-dd HH:mm";
    _datetime = [formatter stringFromDate:date];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"itemid:%@ message:%@ commentID:%@ supportSelected:%d goodnum:%@", self.itemid, self.message, self.commentID, self.supportSeleted, self.goodnum];
}

@end
