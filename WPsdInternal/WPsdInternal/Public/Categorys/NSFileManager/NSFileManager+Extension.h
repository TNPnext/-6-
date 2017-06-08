//
//  NSFileManager+Extension.h
//  VideoShare
//
//  Created by Kings Yan on 14-8-13.
//  Copyright (c) 2014年 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VSFileManagerErrorDomain @"fileManagerErrorDomain"

static const NSUInteger VSFileManagerErrorInvalidParameter = 99;

@interface NSFileManager (Extension)


// 在指定路径下创建文件夹 返回文件夹路径
+ (NSString *)createAvailableDirectionWithPath:(NSString *)path
                                  directorName:(NSString *)directorName
                                       isCover:(BOOL)isCover
                                         error:(NSError *)error;
// 在指定路径存储文件 返回是否创建成功
+ (BOOL)createFileWithPath:(NSString *)path data:(NSData *)data;


@end
