//
//  COHTTPConfigure.m
//  Cooking
//
//  Created by Kings Yan on 14-9-10.
//  Copyright (c) 2014年 ___GoGo___. All rights reserved.
//

#import "JZHTTPConfigure.h"

@implementation JZHTTPConfigure

+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    static JZHTTPConfigure *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[[self class] alloc] init];
    });
    return __singleton__;
}

@end
