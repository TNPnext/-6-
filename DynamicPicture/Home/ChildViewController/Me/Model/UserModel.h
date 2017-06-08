//
//  UserModel.h
//  DynamicPicture
//
//  Created by TNP on 17/3/10.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/*	用户昵称 **/
@property(nonatomic,copy)NSString *username;
/*	会员到期时间 **/
@property(nonatomic,copy)NSString *vip_expire;
/*会员级别：0不是会员，1包月会员，2包年会员 **/
@property(nonatomic,copy)NSString *vip_level;
/*状态：0是正常，1是删除，2是禁用 **/
@property(nonatomic,copy)NSString *is_delete;
/* 用户头像 **/
@property(nonatomic,copy)NSString *logo;
/*	用户id **/
@property(nonatomic,copy)NSString *uid;
/*	手机号 **/
@property(nonatomic,copy)NSString *phone;

/*	可用余额 **/
@property(nonatomic,copy)NSString *money;

@end
