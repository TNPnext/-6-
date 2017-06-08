//
//  APIsForRecommend.m
//  TradePlusProfession
//
//  Created by Kings Yan on 16/8/30.
//  Copyright © 2016年 Chongqing trade + Internet Technology Co., Ltd. All rights reserved.
//

#import "APIs.h"
#import "CategoryApiModel.h"
#import "DynamicPictureListApiModel.h"

@implementation APIs

+ (instancetype)shareInstance
{
    static APIs *__single;
    static dispatch_once_t __once;
    
    dispatch_once(&__once, ^{
        
        NSURL *url = [NSURL URLWithString:commentApi];
        __single = [[APIs alloc] initWithBaseURL:url isSecurityPolicy:YES];
    });
    return __single;
}

- (NSURLSessionDataTask *)getCategoryListOffset:(NSString *)offset success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"Video.Category" forKey:@"service"];
    [dict setValue:@"fulishipin" forKey:@"package"];
    [dict setValue:@"2" forKey:@"os"];
    [dict setValue:(BundleVersion)? BundleVersion : @"" forKey:@"version"];
    return [super GET:@"" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"ret"] && [responseObject[@"ret"] integerValue] == 200) {
            
            CategoryApiModel *model = [[CategoryApiModel alloc] init:responseObject];
            __SUCCESS__(model.data);
        }
        else{
            __FAILURE__(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __FAILURE__(error);
    }];
}

- (NSURLSessionDataTask *)getDynamicPictureListWithCategoryId:(NSString *)categoryId lastDynamicPictureId:(NSString *)lastDynamicPictureId Offset:(NSString *)offset isSearch:(BOOL)search success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
{
    
    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(offset)
    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(lastDynamicPictureId)
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"Video.Get" forKey:@"service"];
    [dict setValue:search?categoryId:([categoryId isEqualToString:@"推荐"]?@"":categoryId) forKey:@"category"];
    [dict setValue:offset forKey:@"page"];
    [dict setValue:@"10" forKey:@"limit"];
    [dict setValue:@"2" forKey:@"os"];
    [dict setValue:(BundleVersion)? BundleVersion : @"" forKey:@"version"];
    [dict setValue:lastDynamicPictureId forKey:@"id"];
    [dict setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forKey:@"imei"];
    return [super GET:@"" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"ret"] && [responseObject[@"ret"] integerValue] == 200) {
            DynamicPictureListApiModel *model = [[DynamicPictureListApiModel alloc] init:responseObject];
            __SUCCESS__(model.data);
        }
        else{
            __FAILURE__(nil);
        }
        //NSLog(@"%@===============",task.currentRequest);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         //NSLog(@"%@============",task.currentRequest);
        __FAILURE__(error);
    }];
}

//点赞等工具栏操作
- (NSURLSessionDataTask *)operationDynamicPictureWithCategoryId:(NSString *)categoryId operationFlag:(NSString *)operationFlag success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
{
    if (!categoryId) {
        
        __FAILURE__(nil)
        return nil;
    }
    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(categoryId)
    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(operationFlag)
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"Video.Up" forKey:@"service"];
    [dict setValue:categoryId forKey:@"id"];
    [dict setValue:@"2" forKey:@"os"];
    [dict setValue:operationFlag forKey:@"type"];
    [dict setValue:(BundleVersion)? BundleVersion : @"" forKey:@"version"];
    return [super GET:@"" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"ret"] && [responseObject[@"ret"] integerValue] == 200) {
            __SUCCESS__(responseObject);
        }
        else{
            __FAILURE__(nil);
        }
        //NSLog(@"%@===============",task.currentRequest);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __FAILURE__(error);
    }];
}

- (NSURLSessionDataTask *)getADData:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"Version.Start" forKey:@"service"];
    [dict setValue:@"2" forKey:@"os"];
    [dict setValue:(BundleVersion)? BundleVersion : @"" forKey:@"version"];
    return [super GET:@"" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"ret"] && [responseObject[@"ret"] integerValue] == 200) {
            __SUCCESS__(responseObject);
        }
        else{
            __FAILURE__(nil);
        }
        //NSLog(@"request===%@",task.currentRequest);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __FAILURE__(error);
    }];
}

- (NSURLSessionDataTask *)getNewVersion:(void(^)(NSString *succes,NSString *msg))success failure:(XIMHTTPClientFailureBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   return  [manager GET:@"https://itunes.apple.com/us/app/xia-ji-ba-xie-1234556773/id1182850375?l=zh&ls=1&mt=8" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         if ([[responseObject valueForKey:@"results"] isKindOfClass:[NSArray class]]) {
             NSArray *arr = [responseObject valueForKey:@"results"];
             NSDictionary *dic = [arr firstObject];
             success([dic valueForKey:@"version"],[dic valueForKey:@"releaseNotes"]);
             // NSLog(@"--------%@",[dic valueForKey:@"releaseNotes"]);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(error);
     }];
    
}

@end
