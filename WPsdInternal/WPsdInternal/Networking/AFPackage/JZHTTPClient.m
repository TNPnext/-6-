//
//  CJFileDownloadQueue.h
//  VideoShare
//
//  Created by Kings Yan on 14-7-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "JZHTTPClient.h"
#import "AFNetworkActivityIndicatorManager.h"
//#import "AFDownloadRequestOperation.h"
#import "AFAppDotNetAPIClient.h"


#import "NSObject+ZGRemoveNulls.h"


#import "AFURLSessionManager.h"

//NSString *const XIMHTTPClientErrorDomain = @"com.xbcx.im.http.error";

@interface JZHTTPClient ()

@property (nonatomic, strong, readwrite) NSString *cookie;

@end

@implementation JZHTTPClient

+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    static JZHTTPClient *__singleton__;
    dispatch_once(&once, ^ {
        NSURL *url = [NSURL URLWithString:__BASE_URL__];
        __singleton__ = [[[self class] alloc] initWithBaseURL:url];
        //
    });
    return __singleton__;
}

+ (void)reachiabilityManager
{
//    NSURL *baseURL = [NSURL URLWithString:@"http://example.com/"];
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
//    NSOperationQueue *operationQueue = manager.operationQueue;
//    
//    void (^available)() = ^ {
//        if (![JZHTTPClient sharedClient].available) {
//            [JZHTTPClient sharedClient].available = YES;
//            if (![JZGloba shareInstance].isNetWorkingReachiabilityNotification) {
//                // started notification!
//                [JZGloba shareInstance].isNetWorkingReachiabilityNotification = @"yes";
//                return;
//            }
//            [operationQueue setSuspended:NO];
//            [[NSNotificationCenter defaultCenter] postNotificationName:JZNetworkingReachabilityNotificationKey object:@{@"available" : @"turn"}];
//        }
//    };
//    void (^unavailable)() = ^ {
//        if ([JZHTTPClient sharedClient].available) {
//            [JZHTTPClient sharedClient].available = NO;
//            [[NSNotificationCenter defaultCenter] postNotificationName:JZNetworkingReachabilityNotificationKey object:@{@"available" : @"faise"}];
//        }
//    };
//    
//    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN: {
//                available();
//            }
//            case AFNetworkReachabilityStatusReachableViaWiFi: {
//                available();
//            }
//                break;
//            case AFNetworkReachabilityStatusNotReachable: {
//                unavailable();
//            }
//            default:
//                [operationQueue setSuspended:YES];
//                break;
//        }
//    }];
//    //开始监控
//    [manager.reachabilityManager startMonitoring];
}

+ (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
	if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
		return nil;
	}
	// Borrowed from http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
	CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
	if (!MIMEType) {
		return @"application/octet-stream";
	}
    return (__bridge NSString *)MIMEType;
}

#pragma mark - Override from super.

- (id)initWithBaseURL:(NSURL *)url
{
    return [self initWithBaseURL:url isSecurityPolicy:NO];
}

- (id)initWithBaseURL:(NSURL *)url isSecurityPolicy:(BOOL)securityPolicy
{
    if (self = [super initWithBaseURL:url]) {
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        if (securityPolicy) {
            
            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
            securityPolicy.allowInvalidCertificates = YES;
            self.securityPolicy = securityPolicy;
        }
        
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        //        responseSerializer.readingOptions = NSJSONReadingAllowFragments;
        self.responseSerializer = responseSerializer;
        
        self.timeoutTime = 30.0;
    }
    return self;
}

- (BOOL)isAvaiableWithResponse:(NSDictionary *)responseObject
{
    return (responseObject != NULL) && ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]] || [responseObject isKindOfClass:[NSObject class]]);
}

- (void)setTimeoutTime:(NSTimeInterval)timeoutTime
{
    _timeoutTime = timeoutTime;
    self.requestSerializer.timeoutInterval = _timeoutTime;
}

#pragma mark - Inherited Methods

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                     progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                        success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
//    
//    //** here is set AFRequest head.*/
//    [[self class] addHeadersInRequest:request];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [[AFAppDotNetAPIClient sharedClient] GET:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // reseve response headers info
//        [[weakSelf class] responseHeadersWithOperation:operation];
        
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        BOOL available = [weakSelf isAvaiableWithResponse:responseObject];
        if (success && available) {
            
            responseObject = [responseObject exchangeToMutableObj];
            [responseObject removeNulls];
            success(task, responseObject);
        }
        else if (!available) {
            failure(task, nil);
        }
        else{
#if DEBUG
            NSLog(@"..response error");
#endif
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
//    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
//    
//    //** here is set AFRequest head.*/
//    [[self class] addHeadersInRequest:request];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [[AFAppDotNetAPIClient sharedClient] POST:[[NSURL URLWithString:URLString] absoluteString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // reseve response headers info
        //        [[weakSelf class] responseHeadersWithOperation:operation];
        
       [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        BOOL available = [weakSelf isAvaiableWithResponse:responseObject];
        if (success && available) {
            
            responseObject = [responseObject exchangeToMutableObj];
            [responseObject removeNulls];
            success(task, responseObject);
        }
        else if (!available) {
            failure(task, nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
//    
//    //** here is set AFRequest head.*/
//    [[self class] addHeadersInRequest:request];
//
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [[AFAppDotNetAPIClient sharedClient] POST:[[NSURL URLWithString:URLString] absoluteString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // reseve response headers info
        //        [[weakSelf class] responseHeadersWithOperation:operation];
        
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        BOOL available = [weakSelf isAvaiableWithResponse:responseObject];
        if (success && available) {
            
            responseObject = [responseObject exchangeToMutableObj];
            [responseObject removeNulls];
            success(task, responseObject);
        }
        else if (!available) {
            failure(task, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    
    return task;
}

- (NSURLSessionDataTask *)testRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{

    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:urlString parameters:parameters error:nil];
//    [[self class] addHeadersInRequest:request];
    
//    __weak typeof(self) weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:self.operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString * responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        responseString = [responseString stringByReplacingOccurrencesOfString : @"\r\n" withString : @"" ];
        
        responseString = [responseString stringByReplacingOccurrencesOfString : @"\n" withString : @"" ];
        
        responseString = [responseString stringByReplacingOccurrencesOfString : @"\t" withString : @"" ];
        
        NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id responseObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];

        if (success && responseString && !error) {
            success(nil, responseObject);
        }
        else if (failure) {
            failure(nil, connectionError);
        }
    }];
    return nil;
}

- (NSURLSessionDataTask *)testRequestCodeWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:urlString parameters:parameters error:nil];
    //    [[self class] addHeadersInRequest:request];
    
    //    __weak typeof(self) weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:self.operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString * responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        responseString = [responseString stringByReplacingOccurrencesOfString : @"\r\n" withString : @"" ];
        
        responseString = [responseString stringByReplacingOccurrencesOfString : @"\n" withString : @"" ];
        
        responseString = [responseString stringByReplacingOccurrencesOfString : @"\t" withString : @"" ];
        
//        NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *error = nil;
//        id responseObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (success && responseString) {
            success(nil, responseString);
        }
        else if (failure) {
            failure(nil, connectionError);
        }
    }];
    return nil;
}

//+ (void)responseHeadersWithOperation:(AFHTTPRequestOperation *)operation
//{
//    [JZHTTPClient shareInstance].cookie = operation.response.allHeaderFields[@"Set-Cookie"];
//}

//+ (void)addHeadersInRequest:(NSMutableURLRequest *)request
//{
//    NSMutableDictionary *headers = [NSMutableDictionary new];
//    NSString *cookie = __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__([JZHTTPClient shareInstance].cookie)
//    headers[@"Set-Cookie"]     = cookie;
//    [request setAllHTTPHeaderFields:headers];
//}


#pragma mark - API

//- (void)uploadFileAtPath:(NSString *)path
//                     url:(NSURL *)url
//                  params:(NSDictionary *)params
//                    type:(NSUInteger)type
//                progress:(XIMHTTPClientProgressBlock)progress
//                 success:(XIMHTTPClientSuccessBlock)success
//                 failure:(XIMHTTPClientFailureBlock)failure
//{
//    if (!path) {
//        __FAILURE__(nil)
//        return;
//    }
//    if (!url) {
//        __FAILURE__(nil)
//        return;
//    }
//    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
//        __FAILURE__(nil)
//        return;
//    }
//    
//    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
//    if (!fileAttributes) {
//        __FAILURE__(nil)
//        return;
//    }
//    
//    NSMutableDictionary *mutableParameters = params.mutableCopy;
//    if (!mutableParameters) mutableParameters = [[NSMutableDictionary alloc] init];
//    
//    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:path];
//    NSUInteger length = [[fileAttributes objectForKey:NSFileSize] unsignedIntegerValue];
//    NSString *mimeType = [self.class mimeTypeForFileAtPath:path];
//    
//    NSMutableURLRequest *urlRequest = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[url absoluteString] parameters:mutableParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithInputStream:inputStream name:@"upfile" fileName:path.lastPathComponent length:length mimeType:mimeType];
//    } error:nil];
//    
//    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject){
//        __SUCCESS__(responseObject)
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        __FAILURE__(error)
//    }];
//    
//    if (progress) {
//        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
//            progress(totalBytesWritten, totalBytesExpectedToWrite);
//        }];
//    }
//    [operation start];
//}

#pragma mark -


//- (AFHTTPRequestOperation *)PUTObjectOperationWithObject:(NSString *)object filePath:(NSString *)filePath parameters:(NSDictionary *)parameters progress:(XBOSSProgressBlock)progress success:(XBOSSPUTSucessBlock)success failure:(XBOSSFailureBlock)failure
//{
//    AFHTTPRequestOperation *operation = nil;
//    if (filePath) {
//        // here doesn't support multipart-formdata PUT.
//        
//        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
//        if (!fileAttributes) {
//          __FAILURE__(nil)
//            return nil;
//        }
//        NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:filePath];
//        NSUInteger length = [[fileAttributes objectForKey:NSFileSize] unsignedIntegerValue];
//        NSString *mimeType = [self.class mimeTypeForFileAtPath:filePath];
//        
//        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:object parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            [formData appendPartWithInputStream:inputStream name:@"Filedata" fileName:filePath.lastPathComponent length:length mimeType:mimeType];
//        } error:nil];
//        
//        [[self class] addHeadersInRequest:request];
//        
//        operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
//            NSError *responseError = nil;
//            //            [XBOSSUtility checkResponseDocument:responseObject error:&responseError];
//            
//            if (responseError && failure) {
//                failure(responseError);
//            }
//            else if (responseObject &&responseObject[@"status"] && [responseObject[@"status"] integerValue] == 0) {
//                __FAILURE__(responseError);
//            }
//            else if (success) {
//                success(operation.request.URL, responseObject);
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//            __FAILURE__(error)
//        }];
//        
//        if (progress) {
//            [operation setUploadProgressBlock:^(NSUInteger bytesSent, NSInteger totalBytesSent, NSInteger total){
//                progress(totalBytesSent, total);
//            }];
//        }
//    }
//    else {
//        failure(nil);
//    }
//    
//    return operation;
//}
//
//- (void)PUTObject:(NSString *)object filePath:(NSString *)filePath parameters:(NSDictionary *)parameters progress:(XBOSSProgressBlock)progress success:(XBOSSPUTSucessBlock)success failure:(XBOSSFailureBlock)failure
//{
//    AFHTTPRequestOperation *operation = [self PUTObjectOperationWithObject:object filePath:filePath parameters:parameters progress:progress success:success failure:failure];
//    if (operation) {
//        [self.operationQueue addOperation:operation];
//    }
//}
//
//- (AFHTTPRequestOperation *)GETOperationWithURL:(NSURL *)url targetPath:(NSString *)targetPath inMemoryData:(BOOL)inMemoryData progress:(XBOSSProgressBlock)progress success:(XBOSSGETSucessBlock)success failure:(XBOSSFailureBlock)failure
//{
//    NSError *error = nil;
//    if (targetPath.length == 0 && !inMemoryData) {
//        error = [NSError errorWithDomain:@"CJHTTPClient.m"
//                                    code:0000
//                                userInfo:@{@"description": @"targetPath cannot be nil when do streaming fetching."}];
//        __FAILURE__(error)
//        return nil;
//    }
//    NSURLRequest *request = [self.requestSerializer requestWithMethod:@"GET"
//                                                            URLString:url.absoluteString
//                                                           parameters:nil
//                                                                error:&error];
//    if (error) {
//        __FAILURE__(error)
//        return nil;
//    }
//    
//    AFHTTPRequestOperation *downloadOperation = nil;
//    if (inMemoryData) {
//        downloadOperation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
//            NSError *responseError = nil;
//            if (responseError && failure) {
//                failure(responseError);
//            }
//            else {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    NSData *data = responseObject;
//                    if (targetPath.length) {
//                        NSFileManager *fm = [NSFileManager defaultManager];
//                        NSString *dirPath = [targetPath stringByDeletingLastPathComponent];
//                        if (![fm fileExistsAtPath:dirPath]) {
//                            [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
//                        }
//                        [fm createFileAtPath:targetPath contents:data attributes:nil];
//                    }
//                    if (success) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            success(targetPath, data);
//                        });
//                    }
//                });
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//           __FAILURE__(error)
//        }];
//    }
//    else{
//        downloadOperation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:targetPath shouldResume:YES];
//        [downloadOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
//            NSError *responseError = nil;
//            
//            if (responseError && failure) {
//                failure(responseError);
//            }
//            else if (success) {
//                success(targetPath, nil);
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//            __FAILURE__(error)
//        }];
//        downloadOperation.responseSerializer = [AFImageResponseSerializer serializer];
//        [(AFDownloadRequestOperation *)downloadOperation setShouldOverwrite:YES];
//    }
//    
//    if (progress) {
//        [downloadOperation setDownloadProgressBlock:^(NSUInteger bytesRead, NSInteger totalRead, NSInteger total){
//            progress(totalRead, total);
//        }];
//    }
//    
//    return downloadOperation;
//}
//
//- (AFHTTPRequestOperation *)GETImageWithURL:(NSURL *)url targetPath:(NSString *)targetPath inMemoryData:(BOOL)inMemoryData progress:(XBOSSProgressBlock)progress success:(XBOSSGETSucessBlock)success failure:(XBOSSFailureBlock)failure {
//    
//    NSError *error = nil;
//    if (targetPath.length == 0 && !inMemoryData) {
//        error = [NSError errorWithDomain:@"CJHTTPClient.m"
//                                    code:0000
//                                userInfo:@{@"description": @"targetPath cannot be nil when do streaming fetching."}];
//        __FAILURE__(error)
//        return nil;
//    }
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
//    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if ([responseObject isKindOfClass:[UIImage class]]) {
//            UIImage *data = responseObject;
//            if (targetPath.length) {
//                NSFileManager *fm = [NSFileManager defaultManager];
//                NSString *dirPath = [targetPath stringByDeletingLastPathComponent];
//                if (![fm fileExistsAtPath:dirPath]) {
//                    [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
//                }
//                [fm createFileAtPath:targetPath contents:UIImageJPEGRepresentation(data, 1) attributes:nil];
//            }
//            if (success) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    success(targetPath, UIImageJPEGRepresentation(data, 1));
//                });
//            }
//        }
//        else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                success(targetPath, responseObject);
//            });
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        __FAILURE__(error)
//    }];
//    
//    if (progress) {
//        [requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, NSInteger totalRead, NSInteger total){
//            progress(totalRead, total);
//        }];
//    }
//    
//    [requestOperation start];
//    return requestOperation;
//}

@end
