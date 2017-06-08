
//
//  COHttpApiOperation.m
//  Cooking
//
//  Created by Kings Yan on 14-9-12.
//  Copyright (c) 2014年 ___GoGo___. All rights reserved.
//

#import "JZHttpApiOperationExample.h"
//#import "JFSafeInformationDictionaryModel.h"
//#import "JFEquipmentDialPlateInformationModel.h"
//#import "JFEquipmentOtherInfoModel.h"
//#import "JFEquipmentSafeEventCompleteModel.h"
//#import "NSString+Extension.h"
//#import "JFCollectInfoDictionaryModel.h"
//#import "JFEquipmentlistModel.h"

@implementation JZHttpApiOperationExample

+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    static JZHttpApiOperationExample *__singleton__;
    
    dispatch_once(&once, ^{
        
        NSURL *url = [NSURL URLWithString:__BASE_URL__];
        __singleton__ = [[[self class] alloc] initWithBaseURL:url isSecurityPolicy:YES];
//        [[self class] reachiabilityManager];
    });
    return __singleton__;
}

//#pragma mark - SafeInformations.
//
//- (NSURLSessionDataTask *)getSafeInformationListWithOffset:(NSString *)offset type:(BOOL)type success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//#if DEBUG
//    NSLog(@"%@", [NSString stringWithFormat:@"%@/iosapi.php?m=1&t=%@&id=%@&c=10", __BASE_URL__, (type)? @"0" : @"1", offset]);
//#endif
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(offset)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=1&t=%@&id=%@&c=10", __BASE_URL__, (type)? @"0" : @"1", offset] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        //        JFSafeInformationDictionaryModel *dictionary = [[JFSafeInformationDictionaryModel alloc] init:responseObject];
//        __SUCCESS__(responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//         __FAILURE__(error);
//    }];
//}
//
//- (AFHTTPRequestOperation *)safeInformationDescriptionAddToFavoriteWithSafeInformationId:(NSString *)siId success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(siId)
//#if DEBUG
//    NSLog(@"%@", [NSString stringWithFormat:@"%@/iosapi.php?m=1&t=3&s=2&id=%@", __BASE_URL__, (siId)? siId : @""]);
//#endif
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=1&t=3&s=2&id=%@", __BASE_URL__, (siId)? siId : @""] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        __SUCCESS__(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        __FAILURE__(error);
//    }];
//}
//
//- (AFHTTPRequestOperation *)safeInformationDescriptionFavoriteToRemovedWithSafeInformationId:(NSString *)siId success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(siId)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=1&t=3&s=3&id=%@", __BASE_URL__, (siId)? siId : @""] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //        JFSafeInformationDictionaryModel *dictionary = [[JFSafeInformationDictionaryModel alloc] init:responseObject];
//        //        SUCCESS(dictionary);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        __FAILURE__(error);
//    }];
//}
//
//#pragma mark - Account.
//
//- (AFHTTPRequestOperation *)accountLoginWithUserName:(NSString *)userName pass:(NSString *)pass success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    if (!userName || !pass) {
//        
//        __FAILURE__(nil);
//        return nil;
//    }
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(userName)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(pass)
//    
//    pass = [pass MD5ENCodeFOR32];
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=1&u=%@&p=%@", __BASE_URL__, userName, pass] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        __SUCCESS__(responseObject);
//        // 缓存用户的账号和密码
//        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:userName,@"userName",pass,@"pass", nil];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:dic forKey:USER_USERNAME_PASS];
//        [defaults synchronize];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//#if DEBUG
//        NSLog(@"Login failure");
//#endif
//        __FAILURE__(error);
//    }];
//}
//
//- (AFHTTPRequestOperation *)accountLogoutWithParameters:(NSArray *)parameters success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=2", __BASE_URL__] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//#if DEBUG
//        NSLog(@"accountLogout SUCCESS");
//#endif
//        __SUCCESS__(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//#if DEBUG
//        NSLog(@"accountLogout FAILURE");
//#endif
//        __FAILURE__(error);
//    }];
//}
//
//#pragma mark - EquipmentInformations.
//
//- (AFHTTPRequestOperation *)getEquipmentDialPlateInfoWithEuipmentId:(NSString *)fId success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(fId)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=2&t=1&d=%@&p=1", __BASE_URL__, fId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        JFEquipmentDialPlateInformationModel *dictionary = [[JFEquipmentDialPlateInformationModel alloc] init:responseObject];
//        __SUCCESS__(dictionary);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSDictionary *responseObject = @{@"cpu":[NSNumber numberWithInt:arc4random() %100],@"mem":[NSNumber numberWithInt:arc4random() % 100],@"online":[NSNumber numberWithInt:((arc4random() % 5) > 0)? 1 : 0],@"safe":@[@{@"t":@"1451397648",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451397648",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451397768",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451397888",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398008",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398128",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398248",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398368",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398488",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398608",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398728",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398848",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451398968",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451399088",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451399208",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451399328",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451399448",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451399568",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451399688",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451399808",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451399928",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451400048",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451400168",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451400288",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451400408",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451400528",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451400648",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451400768",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451400888",@"v": [NSNumber numberWithInt:arc4random() % 10000]},@{@"t":@"1451401008",@"v": [NSNumber numberWithInt:arc4random() % 10000]}]};
//        JFEquipmentDialPlateInformationModel *dictionary = [[JFEquipmentDialPlateInformationModel alloc] init:responseObject];
//        __SUCCESS__(dictionary);
//        
////        __FAILURE__(error);
//    }];
//}
//
//- (AFHTTPRequestOperation *)getEquipmentOtherInfoWithEuipmentId:(NSString *)fId success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(fId)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=2&t=3&d=%@", __BASE_URL__, fId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        JFEquipmentOtherInfoModel *dictionary = [[JFEquipmentOtherInfoModel alloc] init:responseObject];
//        __SUCCESS__(dictionary);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSDictionary *responseObject = @{@"devid":@"51E8",@"fid":@"129",@"fname":@"waftest",@"ftype":@"1",@"fupdate":@"2015-12-18 15:12:32",@"ip":@"10.0.13.168",@"license":@"100",@"rulever":@"3.0.4",@"ver":@"3.0"};
//        JFEquipmentOtherInfoModel *dictionary = [[JFEquipmentOtherInfoModel alloc] init:responseObject];
//        __SUCCESS__(dictionary);
//        
////        __FAILURE__(error);
//    }];
//}
//
//- (AFHTTPRequestOperation *)getEquipmentSafeEventForLatestWithEuipmentId:(NSString *)fId success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(fId)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=2&t=2&d=%@&p=1&c=5", __BASE_URL__, fId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        JFEquipmentSafeEventCompleteModel *dictionary = [[JFEquipmentSafeEventCompleteModel alloc] init:responseObject];
//        __SUCCESS__((dictionary.result)? dictionary.result : [NSArray new]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSMutableArray *result = [NSMutableArray new];
//        for (int i = 0; i < arc4random() % 10; i++) {
//            [result addObject:@{@"fdesc":@"\\U670d\\U52a1\\U566810.0.13.9\\U906d\\U5230\\U6765\\U81ea10.0.13.68\\U7684HTTP\\U653b\\U51fb13\\U6b21",@"fid":@"69",@"ftype":@"1",@"logtime":@"1451402918",@"title":@"HTTP\\U653b\\U51fb"}];
//        }
//        NSDictionary *responseObject = @{@"result":result};
//        JFEquipmentSafeEventCompleteModel *dictionary = [[JFEquipmentSafeEventCompleteModel alloc] init:responseObject];
//        __SUCCESS__((dictionary.result)? dictionary.result : [NSArray new]);
//        
////        __FAILURE__(error);
//    }];
//}
//
//// wdd 设备管理获取设备名以及设备数量
//- (AFHTTPRequestOperation *)getEquipmentNameWithUserID:(NSString *)userID success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    if (!userID) {
//        
//        __FAILURE__(nil);
//        return nil;
//    }
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(userID)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=2&t=0", __BASE_URL__] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//                JFEquipmentlistModel *dictionary = [[JFEquipmentlistModel alloc] init:@{@"list" : (responseObject)? responseObject : [NSArray new]}];
//                __SUCCESS__(dictionary.list);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                
//                NSArray *responseObject = @[@{@"devimg" : @"/images/device/img129.jpg",@"fid" : @"130",@"fname" : @"VPN-2",@"ftype" : @"1"},@{@"devimg" : @"/images/device/img129.jpg",@"fid" : @"131",@"fname" : @"防火墙-2",@"ftype" : @"1"},@{@"devimg" : @"/images/device/img129.jpg",@"fid" : @"132",@"fname" : @"VPN-3",@"ftype" : @"1"},@{@"devimg" : @"/images/device/img129.jpg",@"fid" : @"133",@"fname" : @"防火墙-3",@"ftype" : @"1"},@{@"devimg" : @"/images/device/img129.jpg",@"fid" : @"134",@"fname" : @"VPN-4",@"ftype" : @"1"},@{@"devimg" : @"/images/device/img129.jpg",@"fid" : @"135",@"fname" : @"防火墙-4",@"ftype" : @"1"}];
//                JFEquipmentlistModel *dictionary = [[JFEquipmentlistModel alloc] init:@{@"list" : (responseObject)? responseObject : [NSArray new]}];
//                __SUCCESS__(dictionary.list);
//                
////                __FAILURE__(error);
//            }];
//}
//
//// wdd 问题类型获取
//- (AFHTTPRequestOperation *)getProblemWithUserID:(NSString *)userID success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//#if DEBUG
//    NSLog(@"getProblemWithUserID");
//#endif
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(userID)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=4&t=0", __BASE_URL__] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
//// wdd 账号信息获取
//- (AFHTTPRequestOperation *)getAccountInfoWithUserID:(NSString *)userID success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(userID)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=4&t=2", __BASE_URL__] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
//
//
//// wdd 获取收藏信息
//- (AFHTTPRequestOperation *)getCollectInformationListWithuserID:(NSString *)userId success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(userId)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=1&t=3&s=1&id=0&c=10", __BASE_URL__] parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject)
//    {
//#if DEBUG
//        NSLog(@"获取收藏信息 responseObject = %@",responseObject);
//#endif
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:responseObject,@"news", nil];
//        
//        JFCollectInfoDictionaryModel *dictionary = [[JFCollectInfoDictionaryModel alloc] init:dic];
////
////        NSLog(@"获取收藏信息 dictionary = %@",dictionary);
//        __SUCCESS__(dictionary.news);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        __FAILURE__(error);
//    }];
//}
//
//// wdd 删除收藏信息
//- (AFHTTPRequestOperation *)deleteCollectInformationListWithuserID:(NSString *)infoId success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(infoId)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=1&t=3&s=3&id=%@", __BASE_URL__,infoId] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"删除收藏信息 responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
//#pragma mark - EquipmentStatus
////扫面二维码获取设备状态
//- (AFHTTPRequestOperation *)getEquipmentStatus:(NSString *)equipmentNum success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(equipmentNum)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=3&d=%@", __BASE_URL__,equipmentNum] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"设备状态 responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
////发送手机号获取验证码
//- (AFHTTPRequestOperation *)getUserCodeForRegister:(NSString *)phoneNum equipmentNum:(NSString *)equipmentNum success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(phoneNum)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(equipmentNum)
//    
//    return [super testRequestCodeWithURLString:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=3&l=%@&d=%@", __BASE_URL__,phoneNum,equipmentNum] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"手机验状态 responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
////发送手机号、设备号、密码、验证码(管理员)、验证码(用户)
//- (AFHTTPRequestOperation *)senderMessageForRegister:(NSString *)phoneNum equipmentNum:(NSString *)equipmentNum passWd:(NSString *)passWd userCode:(NSString *)userCode adminCode:(NSString *)adminCode  success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(phoneNum)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(equipmentNum)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(passWd)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(userCode)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(adminCode)
//    
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=3&l=%@&d=%@&p=%@&o=%@&c=%@", __BASE_URL__,phoneNum,equipmentNum,passWd,userCode,adminCode] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"注册验证状态 responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
////修改密码获取验证码(已登陆)
//- (AFHTTPRequestOperation *)getCodeForUpdatePassWordLoginYES:(NSString *)loginStatus success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(loginStatus)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=%@", __BASE_URL__,loginStatus] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"修改密码获取验证码(已登陆) responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//    
//}
//
////修改密码获取验证码(未登陆)
//- (AFHTTPRequestOperation *)getCodeForUpdatePassWordLoginNO:(NSString *)loginStatus phoneNum:(NSString *)phoneNum success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(loginStatus)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(phoneNum)
//    
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=%@&l=%@", __BASE_URL__,loginStatus,phoneNum] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"修改密码获取验证码(未登陆) responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
////修改密码(已登陆)
//- (AFHTTPRequestOperation *)updatePassWordLoginYES:(NSString *)code password:(NSString *)password  success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(code)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(password)
//    
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=4&c=%@&p=%@", __BASE_URL__,code,password] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"修改密码(已登陆) responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
////修改密码(未登陆)
//- (AFHTTPRequestOperation *)updatePassWordLoginNO:(NSString *)code password:(NSString *)password phoneNum:(NSString *)phoneNum success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(code)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(password)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(phoneNum)
//    
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=5&c=%@&p=%@&l=%@", __BASE_URL__,code,password,phoneNum] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"修改密码(未登陆) responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//
//}
//
////扫描二维码添加设备获取验证码(已登陆)
//- (AFHTTPRequestOperation *)getEquipmentStatusForADDCode:(NSString *)equipmentNum success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(equipmentNum)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=6&d=%@", __BASE_URL__,equipmentNum] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"添加设备设备状态获取验证码 responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
////添加设备(已登陆)
//- (AFHTTPRequestOperation *)addEquipment:(NSString *)adminCode userCode:(NSString *)userCode equipmentNum:(NSString *)equipmentNum success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(adminCode)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(userCode)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(equipmentNum)
//    
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=6&c=%@&o=%@&d=%@", __BASE_URL__,adminCode,userCode,equipmentNum] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"添加设备 responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
////删除设备获取验证码
//- (AFHTTPRequestOperation *)getCodeForDeleteEquipment:(NSString *)equipmentNum success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(equipmentNum)
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=7&d=%@", __BASE_URL__,equipmentNum] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"删除设备获取验证码 responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}
//
////删除设备
//- (AFHTTPRequestOperation *)deleteEquipment:(NSString *)equipmentNum code:(NSString *)code success:(XIMHTTPClientSuccessBlock)success failure:(XIMHTTPClientFailureBlock)failure
//{
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(equipmentNum)
//    __NET_INTERACTIVE_PARAMETER_VERIFY_FOR_STR__(code)
//    
//    return [super GET:[NSString stringWithFormat:@"%@/iosapi.php?m=0&t=7&d=%@&c=%@", __BASE_URL__,equipmentNum,code] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//            {
//#if DEBUG
//                NSLog(@"删除设备 responseObject = %@",responseObject);
//#endif
//                __SUCCESS__(responseObject);
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                __FAILURE__(error);
//            }];
//}

@end
