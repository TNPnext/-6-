//
//  NSFileManager+Extension.m
//  VideoShare
//
//  Created by Kings Yan on 14-8-13.
//  Copyright (c) 2014年 ethan. All rights reserved.
//

#import "NSFileManager+Extension.h"

@implementation NSFileManager (Extension)

+ (NSString *)createAvailableDirectionWithPath:(NSString *)path
                                  directorName:(NSString *)directorName
                                       isCover:(BOOL)isCover
                                         error:(NSError *)error
{
    if (!path || !directorName) {
        error =
        [NSError errorWithDomain:VSFileManagerErrorDomain code:VSFileManagerErrorInvalidParameter userInfo:@{@"description" : @"参数无效"}];
    }
    NSString *newPath = [NSString stringWithFormat:@"%@%@",path, directorName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:newPath] && !isCover) {
        return newPath;
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:&error];
    return newPath;
}

+ (BOOL)createFileWithPath:(NSString *)path data:(NSData *)data
{
    [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
#if DEBUG
        NSLog(@"////////////存储失败！");
#endif
        return NO;
    }
    return YES;
}

@end
