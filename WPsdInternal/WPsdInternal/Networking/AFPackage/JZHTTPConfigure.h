//
//  COHTTPConfigure.h
//  Cooking
//
//  Created by Kings Yan on 14-9-10.
//  Copyright (c) 2014年 ___GoGo___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XBOSSProgressBlock)(unsigned long long handled, unsigned long long total);
typedef void (^XBOSSGETSucessBlock)(NSString *filePath, NSData *data);
typedef void (^XBOSSPUTSucessBlock)(NSURL *objectURL, id responseObject);
typedef void (^XBOSSFailureBlock)(NSError *error);

//#define UnReachiableNetWorkAlertCount_ArchivePath [sandBoxPath stringByAppendingPathComponent:@"invalideNetWork_alertCount"]

@interface JZHTTPConfigure : NSObject

@property (nonatomic, strong) NSURL *baseUrl;

+ (instancetype)shareInstance;

@end
