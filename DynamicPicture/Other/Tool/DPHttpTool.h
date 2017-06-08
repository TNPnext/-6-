//
//  DPHttpTool.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/26.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KUserInfoSignKEY @"cxmxmiaobosignkey"

@class DynamicPictureModel;

@interface DPHttpTool : NSObject

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:(void (^)(NSURLSessionDataTask *, id))success
    failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress *))progress
     success:(void (^)(NSURLSessionDataTask *, id))success
     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

+ (void)postUserActionWithPictureID:(NSString *)pictureID
                               type:(NSString *)type
                            success:(void (^)(NSURLSessionDataTask *, id))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

+ (void)getCommentListWithItemID:(NSString *)itemID
                        progress:(void (^)(NSProgress *))progress
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

+ (void)postCommentWithDynamicPictureModel:(DynamicPictureModel *)dynamicPictureModel
                                   message:(NSString *)message
                                  progress:(void (^)(NSProgress *))progress
                                   success:(void (^)(NSURLSessionDataTask *, id))success
                                   failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

+ (void)postCommentUpWithItemID:(NSString *)itemID
                                   success:(void (^)(NSURLSessionDataTask *, id))success
                                   failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

+ (void)postCommentReportWithItemID:(NSString *)itemID
                        success:(void (^)(NSURLSessionDataTask *, id))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

//登录==============================
+ (void)postUserLoginWithPhone:(NSString *)phone
                               Mark:(NSString *)mark
                            success:(void (^)(NSURLSessionDataTask *, id))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

//发送验证码//获取用户信息
+ (void)postSenderMarkWithPhone:(NSString *)phone
                   isSenderMark:(BOOL)result
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;


//修改昵称
+ (void)postNewNameWithName:(NSString *)name
                        success:(void (^)(NSURLSessionDataTask *, id))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

//用户预支付申请，获取一个新的订单号。
+ (void)postPayInfoWithShopType:(NSString *)type
                isSenderMark:(BOOL)result
                     success:(void (^)(NSURLSessionDataTask *, id))success
                     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end
