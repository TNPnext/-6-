//
//  M_Tool.m
//  DynamicPicture
//
//  Created by TNP on 17/3/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "M_Tool.h"
#import "ADModel.h"
#import "MJExtension.h"
#import "b1Model.h"
@implementation M_Tool

/* 是否通过审核**/
+(BOOL)isCheckOver
{
    NSDictionary *ADdic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ADData"];
    ADModel *_ADModel = [ADModel mj_objectWithKeyValues:ADdic];
    if (_ADModel && (![_ADModel.version_checking boolValue])) {
        return YES;
    }else
    {
        return NO;
    }
}

/* 是否登录**/
+(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"islogin"];
}

/* 设置登录状态**/
+(void)setLoginStaute:(BOOL)staute
{
    [[NSUserDefaults standardUserDefaults]setBool:staute forKey:@"islogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/* 根据字体返回的宽度**/
+(CGFloat)getRectWithStr:(NSString *)str
{
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:(str.length == 0)?@"":str];
    [contentText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, contentText.length)];
    CGRect contentRect = [contentText boundingRectWithSize:CGSizeMake(1000, 17) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return contentRect.size.width+6;
}

/* 保存用户信息**/
+(void)saveUserInfo:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]])
    {
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"userAllInfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }else if ([data isKindOfClass:[UserModel class]])
    {
        UserModel *model = data;
        [[NSUserDefaults standardUserDefaults]setObject:[model mj_keyValues] forKey:@"userAllInfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

/* 获取用户信息**/
+(UserModel *)getUserInfo
{
    UserModel *model = [UserModel mj_objectWithKeyValues:[[NSUserDefaults standardUserDefaults] objectForKey:@"userAllInfo"]];
    return model;
}

/* 删除用户信息**/
+(void)removeUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userAllInfo"];
}

+(NSArray *)getRecordData
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"17723117102"];
}

+(void)saveRecordDataWithdata:(id)data
{
    NSMutableArray *arr = [[M_Tool getRecordData] mutableCopy];
    if (arr.count<1)
    {
        arr = [[NSMutableArray alloc]init];
    }
    
    b2Model *model = data;
    [arr insertObject:[model mj_keyValues] atIndex:0];
    [[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"17723117102"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
