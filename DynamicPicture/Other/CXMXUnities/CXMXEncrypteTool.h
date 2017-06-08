//
//  CXMXEncrypteTool.h
//  CXMXUserService
//
//  Created by wpsd on 2017/3/10.
//  Copyright © 2017年 Yao Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMXEncrypteTool : NSObject

+ (NSMutableDictionary *)parameterEncrypteWithParam:(NSMutableDictionary *)parameter saltStr:(NSString *)saltStr secretStr:(NSString *)secretStr;

@end
