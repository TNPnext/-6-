//
//  M_Tool.h
//  DynamicPicture
//
//  Created by TNP on 17/3/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface M_Tool : NSObject

/* 是否通过审核**/
+(BOOL)isCheckOver;

/* 是否登录**/
+(BOOL)isLogin;

/* 根据字体返回的宽度**/
+(CGFloat)getRectWithStr:(NSString *)str;

/* 设置登录状态**/
+(void)setLoginStaute:(BOOL)staute;

/* 保存用户信息**/
+(void)saveUserInfo:(id)data;

/* 获取用户信息**/
+(UserModel *)getUserInfo;

/* 删除用户信息**/
+(void)removeUserInfo;

+(NSArray *)getRecordData;

+(void)saveRecordDataWithdata:(id)data;
@end
