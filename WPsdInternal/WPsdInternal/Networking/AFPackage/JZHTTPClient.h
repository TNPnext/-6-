//
//  CJFileDownloadQueue.h
//  VideoShare
//
//  Created by Kings Yan on 14-7-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "JZHTTPConfigure.h"
#import "JZApiHead.h"
#import "NSString+JFResourceTranscoding.h"


/**
 *     网络获取成功回调数据的闭包属性定义
 *
 *     @param responseObject 数据对象
 */
typedef void (^XIMHTTPClientSuccessBlock)(id responseObject);

/**
 *     网络获取失败回调错误的闭包属性定义
 *
 *     @param error 错误对象
 */
typedef void (^XIMHTTPClientFailureBlock)(NSError *error);

/**
 *     网络获取进度回调的闭包属性定义
 *
 *     @param loadedSize 进度值
 *     @param totalSize  大小值
 */
typedef void (^XIMHTTPClientProgressBlock)(unsigned long long loadedSize, unsigned long long totalSize);

//FOUNDATION_EXPORT NSString *const XIMHTTPClientErrorDomain;





/** By using GET:paramters:success:failure and POST:paramters:success:failure, you can easily
 *  subclass XIMHTTPClient and implement your own web APIs calls.
 */





/**
 *     对 AFNetworink 网络库进行的封装类，实现了网络状态检测、GET\POST\PUT\HEAD\ 等 HTTP 的网络应答方法的网络请求和文件上传下载功能封装。
 *     排除了在直接对调用 AFNetworink 获取网络时的细小问题的处理、简化了对各种 HTTP 网络参数设置的复杂性、模块化了业务开发代码和可读性加强。
 */
@interface JZHTTPClient : AFHTTPSessionManager



/**
 *     设置单个获取网络的超时时间
 */
@property (nonatomic, assign) NSTimeInterval timeoutTime;
//@property (nonatomic, assign) BOOL available;

/**
 *     获取单例的方法
 *
 *     @return 单例对象
 */
+ (instancetype)shareInstance;

/**
 *     实例对象的方法
 *
 *     @param url            网络地址的 URL
 *     @param securityPolicy 是否以 HTTPS 形式的网络协议进行数据获取，如果 YES 则要在工程或者目录中加入 HTTPS 的签名证书文件（钥匙和密匙）
 *
 *     @return 实例对象
 */
- (id)initWithBaseURL:(NSURL *)url isSecurityPolicy:(BOOL)securityPolicy;

/**
 *     存储网络会话 cookie 的定义，用于连续性的网络获取操作
 */
@property (nonatomic, strong, readonly) NSString *cookie;

//+ (void)reachiabilityManager;

//- (BOOL)isAvaiableWithResponse:(NSDictionary *)responseObject;


//#pragma mark - Uplaod File API

// this is classic IOS_Doctor's uploading way. Use XBOSSClient if your static files are hold in OSS.
/**
 *     上传图片或文件的方法定义
 *
 *     @param path     文件存储路径
 *     @param url      上传地址
 *     @param params   参数
 *     @param type     0
 *     @param progress 回调进度的闭包体
 *     @param success  回调成功的闭包体
 *     @param failure  回调失败的闭包体
 */
//- (void)uploadFileAtPath:(NSString *)path
//                     url:(NSURL *)url
//                  params:(NSDictionary *)params
//                    type:(NSUInteger)type
//                progress:(XIMHTTPClientProgressBlock)progress
//                 success:(XIMHTTPClientSuccessBlock)success
//                 failure:(XIMHTTPClientFailureBlock)failure;


//- (AFHTTPRequestOperation *)PUTObjectOperationWithObject:(NSString *)object
//                                                filePath:(NSString *)filePath
//                                              parameters:(NSDictionary *)parameters
//                                                progress:(XBOSSProgressBlock)progress
//                                                 success:(XBOSSPUTSucessBlock)success
//                                                 failure:(XBOSSFailureBlock)failure;
//
//- (void)PUTObject:(NSString *)object
//         filePath:(NSString *)filePath
//       parameters:(NSDictionary *)parameters
//         progress:(XBOSSProgressBlock)progress
//          success:(XBOSSPUTSucessBlock)success
//          failure:(XBOSSFailureBlock)failure;
//
//- (AFHTTPRequestOperation *)GETOperationWithURL:(NSURL *)url
//                                     targetPath:(NSString *)targetPath
//                                   inMemoryData:(BOOL)inMemoryData
//                                       progress:(XBOSSProgressBlock)progress
//                                        success:(XBOSSGETSucessBlock)success
//                                        failure:(XBOSSFailureBlock)failure;
//
//- (AFHTTPRequestOperation *)GETImageWithURL:(NSURL *)url
//                                 targetPath:(NSString *)targetPath
//                               inMemoryData:(BOOL)inMemoryData
//                                   progress:(XBOSSProgressBlock)progress
//                                    success:(XBOSSGETSucessBlock)success
//                                    failure:(XBOSSFailureBlock)failure;
//
//- (AFHTTPRequestOperation *)testRequestWithURLString:(NSString *)urlString
//                                          parameters:(NSDictionary *)parameters
//                                             success:(void (^)(AFHTTPRequestOperation *, id))success
//                                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
//
//- (AFHTTPRequestOperation *)testRequestCodeWithURLString:(NSString *)urlString
//                                          parameters:(NSDictionary *)parameters
//                                             success:(void (^)(AFHTTPRequestOperation *, id))success
//                                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

@end
