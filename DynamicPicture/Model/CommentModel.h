//
//  CommentModel.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (copy, nonatomic, readonly) NSString *commentID;
@property (copy, nonatomic, readonly) NSString *itemid;
@property (copy, nonatomic, readonly) NSString *category;
@property (copy, nonatomic, readonly) NSString *uid;
@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSString *message;
@property (copy, nonatomic, readonly) NSString *dateline;
@property (copy, nonatomic, readonly) NSString *datetime;
@property (copy, nonatomic) NSString *goodnum;
@property (copy, nonatomic, readonly) NSString *badnum;

@property (assign, nonatomic) BOOL supportSeleted;

+ (instancetype)commentWithDict:(NSDictionary *)dict;

@end
