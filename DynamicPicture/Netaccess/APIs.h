//
//  APIsForRecommend.h
//  TradePlusProfession
//
//  Created by Kings Yan on 16/8/30.
//  Copyright © 2016年 Chongqing trade + Internet Technology Co., Ltd. All rights reserved.
//

#import "JZHttpApiOperationExample.h"

@interface APIs : JZHttpApiOperationExample

- (NSURLSessionDataTask *)getCategoryListOffset:(NSString *)offset HTTP_API_COMPLETE;

- (NSURLSessionDataTask *)getDynamicPictureListWithCategoryId:(NSString *)categoryId lastDynamicPictureId:(NSString *)lastDynamicPictureId Offset:(NSString *)offset isSearch:(BOOL)search HTTP_API_COMPLETE;

//点赞等工具栏操作
- (NSURLSessionDataTask *)operationDynamicPictureWithCategoryId:(NSString *)categoryId operationFlag:(NSString *)operationFlag HTTP_API_COMPLETE;

/**  获取初始化数据 分享 下载地址等*/
- (NSURLSessionDataTask *)getADData:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure;

/**获取新版本*/
- (NSURLSessionDataTask *)getNewVersion:(void(^)(NSString *succes,NSString *msg))success failure:(XIMHTTPClientFailureBlock)failure;



@end
