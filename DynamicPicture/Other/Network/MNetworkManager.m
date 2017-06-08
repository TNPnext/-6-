//
//  MMNetworkManager.m
//  MoivePlace
//
//  Created by yanglin on 2017/2/13.
//  Copyright © 2017年 cxmx. All rights reserved.
//

#import "MNetworkManager.h"
#import "ConstantPublicHeader.h"
#import "MJExtension.h"
#import "Common.h"

static MNetworkManager *manager;

@implementation MNetworkManager
+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super manager];
        //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30.0;
        //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    });
    return manager;
}

+ (void)getDefaultIndexSuccess:(void(^)(NSString *urlStr))success failure:(void(^)(NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"2" forKey:@"os"];
    [param setValue:kDefaultIndex forKey:@"service"];
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = [responseObject valueForKey:@"data"];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                NSString *urlStr = [dict valueForKey:@"url"];
                if ([urlStr isKindOfClass:[NSString class]]) {
                    
                    //保存到本地
                    [[NSUserDefaults standardUserDefaults] setValue:urlStr forKey:kDefaultIndexUrl];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    success ? success(urlStr) : nil;
                }else{
                    failure ? failure(nil) : nil;
                }
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (void)getDefaultStartSuccess:(void(^)(DefaultStart *defaulStart))success failure:(void(^)(NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"2" forKey:@"os"];
    [param setValue:kDefaultStart forKey:@"service"];
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = [responseObject valueForKey:@"data"];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                DefaultStart *defautStart = [DefaultStart mj_objectWithKeyValues:dict];
                
                //保存到本地
                [[NSUserDefaults standardUserDefaults] setValue:defautStart.share_url forKey:kShare_Url];
                [[NSUserDefaults standardUserDefaults] setValue:defautStart.baidu_from forKey:kBaidu_From];
                [[NSUserDefaults standardUserDefaults] setValue:defautStart.check_version forKey:kCheck_Verison];
                [[NSUserDefaults standardUserDefaults] setValue:defautStart.isarchitecture forKey:kIsArchitecture];
                [[NSUserDefaults standardUserDefaults] synchronize];
                success ? success(defautStart) : nil;
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

/**
 获取发现APP接口
 */
+ (void)getFindAppSuccess:(void(^)(NSArray<MFAppGroupModel *> *appModel))success failure:(void(^)(NSError *error))failure;
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:kFindApp forKey:@"service"];
    [param setValue:@"2" forKey:@"os"];
    [param setValue:
     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"version"];
    
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *dictArr = [responseObject valueForKey:@"data"];
            if ([dictArr isKindOfClass:[NSArray class]]) {
                NSArray *groups = [MFAppGroupModel mj_objectArrayWithKeyValuesArray:dictArr];
                success ? success(groups) : nil;
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}


+ (void)getRecommendSuccess:(void(^)(NSArray<MovieGroup *> *groups))success failure:(void(^)(NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:kMovieRecommend forKey:@"service"];
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *dictArr = [responseObject valueForKey:@"data"];
            if ([dictArr isKindOfClass:[NSArray class]]) {
                NSArray *groups = [MovieGroup mj_objectArrayWithKeyValuesArray:dictArr];
                success ? success(groups) : nil;
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (void)getCategorySuccess:(void(^)(NSArray<MovieCategory *> *categorys))success failure:(void(^)(NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:kMovieCategory forKey:@"service"];
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *dictArr = [responseObject valueForKey:@"data"];
            if ([dictArr isKindOfClass:[NSArray class]]) {
                NSArray *categorys = [MovieCategory mj_objectArrayWithKeyValuesArray:dictArr];
                success ? success(categorys) : nil;
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (void)getDetailWithID:(NSString *)ID Success:(void(^)(NSArray<MovieDetail *> *details))success failure:(void(^)(NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:kMovieDetail forKey:@"service"];
    [param setValue:ID forKey:@"id"];
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *dictArr = [responseObject valueForKey:@"data"];
            if ([dictArr isKindOfClass:[NSArray class]]) {
                NSArray *details = [MovieDetail mj_objectArrayWithKeyValuesArray:dictArr];
                success ? success(details) : nil;
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (void)getIndexWithID:(NSString *)ID recommend:(NSString *)recommend keyword:(NSString *)keyword page:(NSString *)page limit:(NSString *)limit success:(void(^)(NSArray<MovieModel *> *movies))success failure:(void(^)(NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:kMovieIndex forKey:@"service"];
    [param setValue:ID forKey:@"id"];
    [param setValue:recommend forKey:@"recommend"];
    [param setValue:keyword forKey:@"keyword"];
    [param setValue:page forKey:@"page"];
    [param setValue:limit forKey:@"limit"];
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *dictArr = [responseObject valueForKey:@"data"];
            if ([dictArr isKindOfClass:[NSArray class]]) {
                NSArray *details = [MovieModel mj_objectArrayWithKeyValuesArray:dictArr];
                success ? success(details) : nil;
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}


+ (void)getBannersSuccess:(void(^)(NSArray<BannerModel *> *banners))success failure:(void(^)(NSError *error))failure{    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:kMovieBanner forKey:@"service"];
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *dictArr = [responseObject valueForKey:@"data"];
            if ([dictArr isKindOfClass:[NSArray class]]) {
                NSArray *banners = [BannerModel mj_objectArrayWithKeyValuesArray:dictArr];
                success ? success(banners) : nil;
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (void)getVersionSuccess:(void(^)(VersionModel *version))success failure:(void(^)(NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:kVersionIndex forKey:@"service"];
    [[self sharedManager] GET:kAPI parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = [responseObject valueForKey:@"data"];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                VersionModel *version = [VersionModel mj_objectWithKeyValues:dict];
                success ? success(version) : nil;
            }else{
                failure ? failure(nil) : nil;
            }
        }else{
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (void)getDetailData:(NSString *)type page:(NSInteger)p Success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    //http://cai88.com/api/list.action/?&type=106&ps= 20&pn=1
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:type forKey:@"type"];
    [para setValue:@(p) forKey:@"ps"];
    [para setValue:@"1" forKey:@"pn"];
    [[self sharedManager] GET:@"http://cai88.com/api/list.action/?" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"-------------%@",responseObject);
        //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (responseObject)
        {
            success(responseObject);
        }else
        {
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
   
}

+ (void)getMainDataSuccess:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    
    
    [[self sharedManager] GET:@"http://cai88.com/api/prizecenter.action" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"-------------%@",responseObject);
        //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (responseObject)
        {
            success(responseObject);
        }else
        {
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
    
}

//
+ (void)getZiXunpage:(NSInteger)page Type:(NSString *)type Success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    
    [[self sharedManager] POST:[NSString stringWithFormat:@"http://api.caipiao.163.com/getNewsList.html?pageNo=%ld&subClass=%@",(long)page,type] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"-------------%@",responseObject);
        NSArray *arr = responseObject[@"news"];
        if (arr.count)
        {
            success(arr);
        }else
        {
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"-------------%@",task.currentRequest);
        failure ? failure(error) : nil;
    }];
}

+ (void)getMoveDataWithLottype:(NSString *)type Playtype:(NSString *)playtype Success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    [[self sharedManager] POST:[NSString stringWithFormat:@"http://139.196.187.18:19793/cpyc/last?lottype=%@&playtype=%@",type,playtype] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"-------------%@",responseObject);
        //NSArray *arr = responseObject[@"news"];
        if (responseObject)
        {
            success(responseObject);
        }else
        {
            failure ? failure(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"-------------%@",task.currentRequest);
        failure ? failure(error) : nil;
    }];
  
}

+ (void)getHeMaiDataSuccess:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    [[self sharedManager] POST:@"http://client.leaicai.com/lottery/scheme_hm.htm?lotteryId=0&sort=2&firstRow=0&fetchSize=100&asc=false&requestType=1&version=1.0.3&appVersion=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        success(@"");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        success(@"");
    }];
   
}

+ (void)getBuyDataWithUrl:(NSString *)url Success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    [[self sharedManager] POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (responseObject)
         {
             success(responseObject);
         }else
         {
             failure ? failure(nil) : nil;
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure ? failure(error) : nil;
     }];
}


+ (void)getPayWithMoney:(NSString *)money Success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    [[self sharedManager] POST:[NSString stringWithFormat:@"http://client.leaicai.com/user/iyi_app.htm?clientUserSession=1404404_5756a53b9845bf691969d06bd61fbae7&requestType=1&version=1.0.3&appVersion=1&fee=%@",money] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (responseObject)
         {
             success(responseObject);
         }else
         {
             failure ? failure(nil) : nil;
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure ? failure(error) : nil;
     }];
  
}


+ (void)getAppUrlSuccess:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    [[self sharedManager] POST:[NSString stringWithFormat:@"http://appmgr.jwoquxoc.com/frontApi/getAboutUs?appid=1230896986"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (responseObject)
         {
             success(responseObject);
         }else
         {
             failure ? failure(nil) : nil;
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure ? failure(error) : nil;
     }];
  
}
@end
