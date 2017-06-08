//
//  NSObject+ZGRemoveNulls.h
//  AppChatroom
//
//  Created by Kings Yan on 13-10-19.
//  Copyright (c) 2013年 juche. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *     验证并且修复网络获取的 JSON 数据空值，该类由 JZHTTPClient 使用
 */
@interface NSObject (ZGRemoveNulls)

- (id)exchangeToMutableObj;
- (void)removeNulls;

@end
