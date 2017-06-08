//
//  WpsStatistcsClient.m
//  WPsdInternal
//
//  Created by wapushidai on 16/9/2.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import "WpsStatistcsClient.h"

@implementation WpsStatistcsClient
+(void)WpsStatistcsFirstInstallationAppModel:(WpsAppModel *)model;
{
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    [parametersDict setValue:model.uuid forKey:@"imei"];
    [parametersDict setValue:model.app_key forKey:@"app_key"];
    [parametersDict setValue:model.appQid forKey:@"qid"];
    [parametersDict setValue:model.appVersion forKey:@"app_version"];
    
    [parametersDict setValue:model.phone_name forKey:@"phone_name"];
    [parametersDict setValue:model.phone_model forKey:@"phone_model"];
    [parametersDict setValue:model.system_version forKey:@"system_version"];
    [parametersDict setValue:model.appType forKey:@"type"];
    [parametersDict setValue:model.appInternetType forKey:@"intertype"];
    [parametersDict setValue:model.appInternet forKey:@"internet"];
    [parametersDict setValue:@"1" forKey:@"contype"];
    [parametersDict setValue:@"Firstlogin.Newindex" forKey:KServiceNameKey];
    
    NSMutableDictionary *newParametersDict = [NSMutableDictionary dictionaryWithDictionary:[SignatureTool signatureStatisticalParameters:parametersDict ]];
    //NSLog(@"---:%@",newParametersDict);
    [[JZHTTPClient shareInstance] POST:KWpsStatistcsAPI parameters:newParametersDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"WpsStatistcsFirstInstallationSuccess:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"WpsStatistcsFirstInstallationFail:%@",[error description]);
    }];
}
/*!
 *   @brief 程序每次活跃发送信息
 *
 *   @param model app所有信息
 */
+(void)WpsStatistcsEveryTimeInstallationAppModel:(WpsAppModel *)model;
{
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    [parametersDict setValue:model.uuid forKey:@"imei"];
    [parametersDict setValue:model.app_key forKey:@"app_key"];
    [parametersDict setValue:model.appQid forKey:@"qid"];
    [parametersDict setValue:model.appVersion forKey:@"app_version"];
    [parametersDict setValue:model.phone_model forKey:@"phone_model"];
    [parametersDict setValue:model.system_version forKey:@"system_version"];
    [parametersDict setValue:model.appType forKey:@"type"];
    [parametersDict setValue:model.appInternet forKey:@"internet"];
    [parametersDict setValue:@"Openapp.Newindex" forKey:KServiceNameKey];
    
    NSMutableDictionary *newParametersDict = [NSMutableDictionary dictionaryWithDictionary:[SignatureTool signatureStatisticalParameters:parametersDict ]];
    //NSLog(@"---:%@",newParametersDict);
    [[JZHTTPClient shareInstance] POST:KWpsStatistcsAPI parameters:newParametersDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"WpsStatistcsFirstInstallationSuccess:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"WpsStatistcsFirstInstallationFail:%@",[error description]);
    }];
}
@end
