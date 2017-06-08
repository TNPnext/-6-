//
//  JZApiHead.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/19.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#ifndef GSJuZhang_JZApiHead_h
#define GSJuZhang_JZApiHead_h




/**
 *     网络访问基础地址设置
 */
#define __BASE_URL__ @"http://testapi.dongtu.anzhuo.com/"

/**
 *     服务器用来区分应用时用的 app 拼音名
 */
#define __APP_NAME__ @"tianqijun"

/**
 *     面向业务代码获取网络的接口开发获取网络结束的闭包回调设计宏定义
 *
 *     @param XIMHTTPClientSuccessBlock 网络获取成功回调的闭包属性定义
 *
 *     @param XIMHTTPClientFailureBlock 网络获取失败回调的闭包属性定义
 */
#define HTTP_API_COMPLETE success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure;

/**
 *     面向业务代码获取网络的接口开发获取网络进度和结束的闭包回调设计宏定义
 *
 *     @param XIMHTTPClientProgressBlock  网络获取进度回调的闭包属性定义.
 *
 *     @param XIMHTTPClientSuccessBlock   网络获取成功回调的闭包属性定义
 *
 *     @param XIMHTTPClientFailureBlock   网络获取失败回调的闭包属性定义
 */
#define HTTP_API_COMPLETE_PROGRESS \
\
progress:(XIMHTTPClientProgressBlock)progress \
success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure

/**
 *     返回网络错误调用错误闭包体的闭包验证宏定义
 *
 *     @param __ERROR__ 网络错误对象
 */
#define __FAILURE__(__ERROR__) \
\
if (failure) { \
    failure(__ERROR__); \
}

/**
 *     返回网络获取成功调用成功闭包体的闭包验证宏定义
 *
 *     @param __RESPONSE_OBJECT__ 成功获取的数据
 */
#define __SUCCESS__(__RESPONSE_OBJECT__) \
\
if (success) { \
    success(__RESPONSE_OBJECT__); \
}

/**
 *     验证并且修复获取网络传递给 http 消息体的参数
 *
 *     @param __PARAMETER__ 参数属性
 *
 *     @return 验证并且修复过后的参数属性
 */
#define __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(__PARAMETER__)   \
__PARAMETER__ = (__PARAMETER__)? __PARAMETER__ : @"";  \
if ([__PARAMETER__ isContainChinese]) {     \
    __PARAMETER__ = [__PARAMETER__ stringByAddingPercentEscapesUsingEncoding:NSUTF16StringEncoding]; \
}

//#define PARAMETER_VERTIFY(postAction) \
//NETWORK_VERTIFLY     \
//if (!postAction) {  \
//    FAILURE(nil);  \
//    return nil;    \
//}
//
//#define NETWORK_VERTIFLY  if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) { \
//    FAILURE([NSError errorWithDomain:@"COHttpApiOperation.m" code:7777 userInfo:@{@"info" : @"网络不给力～ 请检测您的网络连接！"}]) \
//    return nil; \
//}
//
//#define RESPONSEOBJECT_VERTIFLY(responseObject) \
//if (responseObject[@"status"] && [responseObject[@"status"] integerValue] == 2) { \
//    FAILURE([NSError errorWithDomain:@"COHttpApiOperation.m" code:10002 userInfo:@{@"info" : @"登录无效"}]) \
//    return; \
//} \
//if (responseObject[@"status"] && [responseObject[@"status"] integerValue] == 0) { \
//    FAILURE([NSError errorWithDomain:@"COHttpApiOperation.m" code:10000 userInfo:@{@"info" : @"服务器错误"}]) \
//    return; \
//} \
//if (responseObject[@"status"] && [responseObject[@"status"] integerValue] == 3) { \
//    FAILURE([NSError errorWithDomain:@"COHttpApiOperation.m" code:10003 userInfo:@{@"info" : @"用户已被加入黑名单"}]) \
//    return; \
//}
//
//#define RESPONSEOBJECT_VERTIFLY_TO_ALERT(responseObject) \
//if (responseObject[@"status"] && [responseObject[@"status"] integerValue] == 2) { \
//    if (responseObject[@"info"]) { \
//        [self dismissLoadHUDWithFailureText:responseObject[@"info"]]; \
//    }       \
//    else{  \
//        [self dismissLoadHUDWithFailureText:@"登录无效"]; \
//    }      \
//    return; \
//}           \
//if (responseObject[@"status"] && [responseObject[@"status"] integerValue] == 0) { \
//    if (responseObject[@"info"]) { \
//        [self dismissLoadHUDWithFailureText:responseObject[@"info"]]; \
//    }       \
//    else{  \
//        [self dismissLoadHUDWithFailureText:@"服务器错误"]; \
//    }      \
//    return; \
//}           \
//if (responseObject[@"status"] && [responseObject[@"status"] integerValue] == 3) { \
//    if (responseObject[@"info"]) { \
//        [self dismissLoadHUDWithFailureText:responseObject[@"data"][@"info"]]; \
//    }      \
//    else{ \
//        [self dismissLoadHUDWithFailureText:@"用户已被加入黑名单"]; \
//    }      \
//    return; \
//}

#endif
