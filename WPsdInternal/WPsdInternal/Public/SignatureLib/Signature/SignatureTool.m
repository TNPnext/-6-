//
//  Tool.m
//  API
//
//  Created by 何文学 on 16/5/19.
//  Copyright © 2016年 babyzxixi. All rights reserved.
//

#import "SignatureTool.h"
#import "CocoaSecurity.h"
#import "IGQueryEncoder.h"
#import "NSData+AES128.h"

#define KeyUserSecret   @"cxmxtianqi"
#define KeyUserKey      @"s"
//秘钥
#define KeySecret       @"xwCMX2349WEREWisicms"
#define KeyName         @"signkey"

@implementation SignatureTool
/*!
 *   @brief 参数AES 128加密  统计
 *
 *   @param dict         dict 原参数
 *
 *   @return 加密后参数
 */
+ (NSDictionary *)signatureStatisticalParameters:(NSMutableDictionary *)dict;
{
    NSString *service = [dict objectForKey:KServiceNameKey];
    [dict removeObjectForKey:KServiceNameKey];
    
    //加上时间戳
    NSString *date = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSMutableDictionary *parameterDict =[NSMutableDictionary dictionaryWithDictionary:dict];
    [parameterDict setObject:date forKey:@"t"];
    //排序后的参数
    NSString *parameterString = [self parameterString:dict];
    //转Data
    NSData *data=[parameterString dataUsingEncoding:NSUTF8StringEncoding];
    //加密的Key 就是拼接的参数parameterString
    NSData *decrydata = [data AES128DecryptWithKey:parameterString];
    NSString *decrydataString = [[NSString alloc] initWithData:decrydata encoding:NSUTF8StringEncoding];
    
    [parameterDict setValue:decrydataString forKey:@"data"];
    [parameterDict setValue:parameterString forKey:@"T"];
    [parameterDict setValue:service forKey:KServiceNameKey];
    
    return parameterDict;
}
/*!
 *   @brief 参数MD5加密
 *
 *   @param dict 原参数
 *
 *   @return 加密后参数
 */
+ (NSDictionary *)signatureParameters:(NSDictionary *)dict secret:(BOOL)isUserSecret;
{
    NSMutableDictionary *parameterDict =[NSMutableDictionary dictionaryWithDictionary:dict];
    
    NSString *parameterString = [self parameterString:dict];
    
    CocoaSecurityResult *result = [CocoaSecurity md5:[NSString stringWithFormat:@"%@%@",parameterString,!isUserSecret?KeySecret:KeyUserSecret]];
    [parameterDict setObject:result.hexLower forKey:!isUserSecret?KeyName:KeyUserKey];
    
    return parameterDict;
}

/*!
 *   @brief 天气加密后的参数数据
 *
 *   @param dict  原始参数数据
 *
 *   @return 加密后的参数数据
 */
+(NSDictionary *)signatureWeatherParameters:(NSDictionary *)dict;
{
    NSString *date = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSMutableDictionary *parameterDict =[NSMutableDictionary dictionaryWithDictionary:dict];
    [parameterDict setObject:date forKey:@"t"];
    
    NSString *parameterString = [self parameterString:parameterDict];
    NSString *joinTokenparameterString = [NSString stringWithFormat:@"%@%@",parameterString,KWeatherToken];

    CocoaSecurityResult *result = [CocoaSecurity md5:joinTokenparameterString];
    if(KWeatherISencryption)
    {
        [parameterDict setValue:result.hexLower forKey:@"s"];
    }
    return parameterDict;
}
#pragma mark - Private  参数排序
+ (NSString*) parameterString:(NSDictionary *)dict;
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:dict];
    // Convert keys to lowercase strings
    
    NSMutableDictionary* lowerCaseParams = [NSMutableDictionary dictionaryWithCapacity:[params count]];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop)
     {
         [lowerCaseParams setObject:obj forKey:[key lowercaseString]];
     }];
    
    NSArray* sortedKeys = [[lowerCaseParams allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
//    NSMutableArray* encodedParamerers = [NSMutableArray array];
    
    NSMutableArray *valueArray = [NSMutableArray array];
    [sortedKeys enumerateObjectsUsingBlock:^(NSString* key, NSUInteger idx, BOOL *stop)
     {
//         [encodedParamerers addObject:[IGQueryEncoder encodeParamWithoutEscapingUsingKey:key andValue:[lowerCaseParams objectForKey:key]]];
         [valueArray addObject:[lowerCaseParams objectForKey:key]];
     }];
    
    // return [encodedParamerers componentsJoinedByString:@"%26"];
    return [valueArray componentsJoinedByString:@""];
}

@end
