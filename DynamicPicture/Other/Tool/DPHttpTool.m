//
//  DPHttpTool.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/26.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "DPHttpTool.h"
#import "DynamicPictureModel.h"
#import <Public_h.h>
#import "UIDevice+VKKeychainIDFV.h"
#import "CXMXEncrypteTool.h"

@implementation DPHttpTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (void)postUserActionWithPictureID:(NSString *)pictureID type:(NSString *)type success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{
                             @"service" : @"Dongtu.Up",
                             @"id" : pictureID,
                             @"type" : type
                             };
    [DPHttpTool POST:commentApi parameters:params progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (void)getCommentListWithItemID:(NSString *)itemID progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{
                             @"service" : @"Comment.Get",
                             @"itemid" : itemID
                             };
    [self GET:commentApi parameters:params progress:^(NSProgress *progress) {
        //            DLog(@"%@",progress);
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (void)postCommentWithDynamicPictureModel:(DynamicPictureModel *)dynamicPictureModel message:(NSString *)message progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *itemid = dynamicPictureModel.base_id.length ? dynamicPictureModel.base_id : @"";
    NSString *title = dynamicPictureModel.title.length ? dynamicPictureModel.title : @"";
    NSString *imei = [UIDevice VKKeychainIDFV];
    NSString *app_version = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleShortVersionString"];
    NSDictionary *params = @{
                             @"service" : @"Comment.Issue",
                             @"itemid" : itemid,
                             @"content" : message,
                             @"title" : title,
                             @"imei" : imei.length ? imei : @"",
                             @"os" : @"2",
                             @"version" : app_version.length ? app_version : @""
                             };
    NSMutableDictionary *addtionParams = [params mutableCopy];
    NSString *preUserName = [[NSUserDefaults standardUserDefaults] objectForKey:userNameKey];
    if (preUserName.length) {
        [addtionParams setValue:preUserName forKey:@"username"];
    }
    [DPHttpTool POST:commentApi parameters:addtionParams progress:^(NSProgress *progress) {
        //        DLog(@"%@", progress);
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (void)postCommentUpWithItemID:(NSString *)itemID success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{
                             @"service" : @"Comment.Up",
                             @"itemid" : itemID,
                             @"type" : @"0"
                             };
    [DPHttpTool POST:commentApi parameters:params progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (void)postCommentReportWithItemID:(NSString *)itemID success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{
                             @"service" : @"Comment.Report",
                             @"id" : itemID
                             };
    [DPHttpTool POST:commentApi parameters:params progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

//登录==============================
+ (void)postUserLoginWithPhone:(NSString *)phone
                          Mark:(NSString *)mark
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSDictionary *params = @{
                             @"service" : @"User.Login",
                             @"phone" : phone,
                             @"mark" : mark,
                             @"reg_site" : @"10",
                             @"os" : @"2",
                             };
    params =  [CXMXEncrypteTool parameterEncrypteWithParam:[NSMutableDictionary dictionaryWithDictionary:params] saltStr:KUserInfoSignKEY secretStr:nil];
    [DPHttpTool GET:userApi parameters:params progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
  
}

//发送验证码//获取用户信息============================
+ (void)postSenderMarkWithPhone:(NSString *)phone
                   isSenderMark:(BOOL)result
                        success:(void (^)(NSURLSessionDataTask *, id))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSDictionary *params = @{
                             @"service" : result?@"User.SendMark":@"User.Index",
                             @"phone" : phone,
                             @"reg_site" : @"10",
                             @"os" : @"2",
                             };
    
    params =  [CXMXEncrypteTool parameterEncrypteWithParam:[NSMutableDictionary dictionaryWithDictionary:params] saltStr:KUserInfoSignKEY secretStr:nil];
    [DPHttpTool GET:userApi parameters:params progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
 
}


//修改昵称
+ (void)postNewNameWithName:(NSString *)name
                     success:(void (^)(NSURLSessionDataTask *, id))success
                     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    UserModel *molde = [M_Tool getUserInfo];
    NSDictionary *params = @{
                             @"service" : @"User.SetUserName",
                             @"username" : name,
                             @"phone" : molde.phone,
                             @"os" : @"2",
                             };
    
    params =  [CXMXEncrypteTool parameterEncrypteWithParam:[NSMutableDictionary dictionaryWithDictionary:params] saltStr:KUserInfoSignKEY secretStr:nil];
    [DPHttpTool GET:userApi parameters:params progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];

}

//用户预支付申请，获取一个新的订单号。type===支付商品ID：1是包月，2是包年
+ (void)postPayInfoWithShopType:(NSString *)type
                   isSenderMark:(BOOL)result
                        success:(void (^)(NSURLSessionDataTask *, id))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    UserModel *molde = [M_Tool getUserInfo];
    NSDictionary *params = @{
                             @"service" : @"Pay.Ready",
                             @"uid" : molde.uid,
                             @"phone" : molde.phone,
                             @"shopid" : type,
                             @"reg_site" : @"10",
                             };
    
    params =  [CXMXEncrypteTool parameterEncrypteWithParam:[NSMutableDictionary dictionaryWithDictionary:params] saltStr:KUserInfoSignKEY secretStr:nil];
    [DPHttpTool GET:userApi parameters:params progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
        if (success) {
            success(task, responceObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];

}
@end
