//
//  Tool.h
//  API
//
//  Created by 何文学 on 16/5/19.
//  Copyright © 2016年 babyzxixi. All rights reserved.
//

#import <Foundation/Foundation.h>

//天气数据API
#ifdef DEBUG
#define KAPI @"http://tapi.tianqi.com/"
#else
#define KAPI @"http://api.tianqi.com/"
#endif

//用户中心API
#define KUSERAPI @"http://api.user.xiaohua.com/User/"

//天气API
#define KWeatherToken   @"www.tianqi.com?s=666666"

//是否加密
#define KWeatherISencryption 0

#define KServiceNameKey     @"service"


@interface SignatureTool : NSObject

/*!
 *   @brief 参数AES 128加密  统计
 *
 *   @param dict         dict 原参数
 *
 *   @return 加密后参数
 */
+ (NSDictionary *)signatureStatisticalParameters:(NSMutableDictionary *)dict;


/*!
*   @brief 参数MD5加密
*
*   @param dict         dict 原参数
*   @param isUserSecret 是否是是用户秘钥 YES 用户密码 NO 其他秘钥
*
*   @return 加密后参数
*/
+ (NSDictionary *)signatureParameters:(NSDictionary *)dict secret:(BOOL)isUserSecret;

/*!
 *   @brief 天气加密后的参数数据
 *
 *   @param dict  原始参数数据
 *
 *   @return 加密后的参数数据
 */
+(NSDictionary *)signatureWeatherParameters:(NSDictionary *)dict;
@end
