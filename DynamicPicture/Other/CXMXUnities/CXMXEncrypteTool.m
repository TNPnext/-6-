//
//  CXMXEncrypteTool.m
//  CXMXUserService
//
//  Created by wpsd on 2017/3/10.
//  Copyright © 2017年 Yao Yang. All rights reserved.
//

#import "CXMXEncrypteTool.h"
#import "CXMXCocoaSecurity.h"

@implementation CXMXEncrypteTool

+ (NSMutableDictionary *)parameterEncrypteWithParam:(NSMutableDictionary *)parameter saltStr:(NSString *)saltStr secretStr:(NSString *)secretStr {
    parameter =  [self signatureParameters:parameter secretStr:saltStr];
    [parameter setValue:secretStr forKey:@"secret"];
    return parameter;
}


/*!
 *   @brief 参数MD5加密
 *
 *   @param dict 原参数
 *
 *   @return 加密后参数
 */
+ (NSMutableDictionary *)signatureParameters:(NSDictionary *)dict secretStr:(NSString *)str;
{
    NSMutableDictionary *parameterDict =[NSMutableDictionary dictionaryWithDictionary:dict];
    
    NSString *parameterString = [self parameterString:dict];
    
    CXMXCocoaSecurityResult *result = [CXMXCocoaSecurity md5:[NSString stringWithFormat:@"%@%@",parameterString,str]];
    [parameterDict setObject:result.hexLower forKey:@"s"];
    
    return parameterDict;
}

#pragma mark - Private  参数排序

+ (NSString *) parameterString:(NSDictionary *)dict;
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:dict];
    // Convert keys to lowercase strings
    
    NSMutableDictionary* lowerCaseParams = [NSMutableDictionary dictionaryWithCapacity:[params count]];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop)
     {
         [lowerCaseParams setObject:obj forKey:[key lowercaseString]];
     }];
    
    NSArray* sortedKeys = [[lowerCaseParams allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableArray* encodedParamerers = [NSMutableArray array];
    
    NSMutableArray *valueArray = [NSMutableArray array];
    [sortedKeys enumerateObjectsUsingBlock:^(NSString* key, NSUInteger idx, BOOL *stop)
     {
         [encodedParamerers addObject:[self encodeParamWithoutEscapingUsingKey:key
                                                                      andValue:[lowerCaseParams objectForKey:key]]];
         [valueArray addObject:[lowerCaseParams objectForKey:key]];
     }];
    
    // return [encodedParamerers componentsJoinedByString:@"%26"];
    return [valueArray componentsJoinedByString:@""];
}

+ (NSString *) encodeParamWithoutEscapingUsingKey:(NSString*)key andValue:(id<NSObject>)value
{
    if ([value isKindOfClass:[NSArray class]])
    {
        NSArray* array = (NSArray*) value;
        NSMutableArray* encodedArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id<NSObject> obj, NSUInteger idx, BOOL *stop)
         {
             [encodedArray addObject:[NSString stringWithFormat:@"%@[]=%@", key, obj]];
         }];
        return [encodedArray componentsJoinedByString:@"&"];
    } else
    {
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
}

@end
