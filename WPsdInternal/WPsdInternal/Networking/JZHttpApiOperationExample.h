//
//  COHttpApiOperation.h
//  Cooking
//
//  Created by Kings Yan on 14-9-12.
//  Copyright (c) 2014年 ___GoGo___. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFDownloadRequestOperation.h"
#import "JZHTTPClient.h"



/**
 *     继承于 JZHTTPClient 对 AFNetworking 封装的功能，该类是一个面相业务直接书写获取业务网络数据的模版文件。
 */
@interface JZHttpApiOperationExample : JZHTTPClient

//#pragma mark - safeInformations.
//- (NSURLSessionDataTask *)getSafeInformationListWithOffset:(NSString *)offset type:(BOOL)type HTTP_API_COMPLETE;
//- (AFHTTPRequestOperation *)safeInformationDescriptionAddToFavoriteWithSafeInformationId:(NSString *)siId HTTP_API_COMPLETE;
//- (AFHTTPRequestOperation *)safeInformationDescriptionFavoriteToRemovedWithSafeInformationId:(NSString *)siId HTTP_API_COMPLETE;
//
//#pragma mark - Account.
//- (AFHTTPRequestOperation *)accountLoginWithUserName:(NSString *)userName pass:(NSString *)pass HTTP_API_COMPLETE;
//- (AFHTTPRequestOperation *)accountLogoutWithParameters:(NSArray *)parameters HTTP_API_COMPLETE;
//
//#pragma mark - EquipmentInformations.
//- (AFHTTPRequestOperation *)getEquipmentDialPlateInfoWithEuipmentId:(NSString *)fId HTTP_API_COMPLETE;
//- (AFHTTPRequestOperation *)getEquipmentOtherInfoWithEuipmentId:(NSString *)fId HTTP_API_COMPLETE;
//- (AFHTTPRequestOperation *)getEquipmentSafeEventForLatestWithEuipmentId:(NSString *)fId HTTP_API_COMPLETE;
//
//// 获取设备信息
//- (AFHTTPRequestOperation *)getEquipmentNameWithUserID:(NSString *)userID HTTP_API_COMPLETE;
//
//// wdd 问题类型获取
//- (AFHTTPRequestOperation *)getProblemWithUserID:(NSString *)userID HTTP_API_COMPLETE;
//
//// 获取账号信息
//- (AFHTTPRequestOperation *)getAccountInfoWithUserID:(NSString *)userID HTTP_API_COMPLETE;
//
//// 获取收藏信息
//- (AFHTTPRequestOperation *)getCollectInformationListWithuserID:(NSString *)offset HTTP_API_COMPLETE;
//
//// 删除收藏信息
//- (AFHTTPRequestOperation *)deleteCollectInformationListWithuserID:(NSString *)infoId HTTP_API_COMPLETE;
//
//#pragma mark - EquipmentStatus
////扫面二维码获取设备装备
//- (AFHTTPRequestOperation *)getEquipmentStatus:(NSString *)equipmentNum HTTP_API_COMPLETE;
//
////发送手机号获取验证码
//- (AFHTTPRequestOperation *)getUserCodeForRegister:(NSString *)phoneNum equipmentNum:(NSString *)equipmentNum HTTP_API_COMPLETE;
//
////发送手机号、设备号、密码、验证码(管理员)、验证码(用户)
//- (AFHTTPRequestOperation *)senderMessageForRegister:(NSString *)phoneNum equipmentNum:(NSString *)equipmentNum passWd:(NSString *)passWd userCode:(NSString *)userCode adminCode:(NSString *)adminCode  HTTP_API_COMPLETE;
//
////修改密码获取验证码(已登陆)
//- (AFHTTPRequestOperation *)getCodeForUpdatePassWordLoginYES :(NSString *)loginStatus HTTP_API_COMPLETE;
//
////修改密码获取验证码(未登陆)
//- (AFHTTPRequestOperation *)getCodeForUpdatePassWordLoginNO:(NSString *)loginStatus  phoneNum:(NSString *)phoneNum HTTP_API_COMPLETE;
//
////修改密码(已登陆)
//- (AFHTTPRequestOperation *)updatePassWordLoginYES:(NSString *)code password:(NSString *)password  HTTP_API_COMPLETE;
//
////修改密码(未登陆)
//- (AFHTTPRequestOperation *)updatePassWordLoginNO:(NSString *)code password:(NSString *)password phoneNum:(NSString *)phoneNum HTTP_API_COMPLETE;
//
////扫描二维码添加设备获取验证码(已登陆)
//- (AFHTTPRequestOperation *)getEquipmentStatusForADDCode:(NSString *)equipmentNum HTTP_API_COMPLETE;
//
////添加设备(已登陆)
//- (AFHTTPRequestOperation *)addEquipment:(NSString *)adminCode userCode:(NSString *)userCode equipmentNum:(NSString *)equipmentNum HTTP_API_COMPLETE;
//
////删除设备获取验证码
//- (AFHTTPRequestOperation *)getCodeForDeleteEquipment:(NSString *)equipmentNum HTTP_API_COMPLETE;
//
////删除设备
//- (AFHTTPRequestOperation *)deleteEquipment:(NSString *)equipmentNum code:(NSString *)code HTTP_API_COMPLETE;
@end
