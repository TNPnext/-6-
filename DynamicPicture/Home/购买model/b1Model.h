//
//  b1Model.h
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/9.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class sps;
@interface b1Model : NSObject
@property(nonatomic,copy)NSString *teamId;
@property(nonatomic,copy)NSString *hostName;
@property(nonatomic,copy)NSString *guestName;
@property(nonatomic,copy)NSString *leagueName;
@property(nonatomic,copy)NSString *sellEndTime;
@property(nonatomic,copy)NSString *sheng;
@property(nonatomic,copy)NSString *ping;
@property(nonatomic,copy)NSString *fu;
@property(nonatomic,copy)NSString *matchTime;
@property(nonatomic,strong)sps *sp;
@end


@interface b2Model : NSObject

@property(nonatomic,copy)NSString *issue;//q期数

@property(nonatomic,copy)NSString *drawNumber;//号码

@property(nonatomic,copy)NSString *types;//单式投注or复试投注等等

@property(nonatomic,copy)NSString *multiple;//倍数

@property(nonatomic,copy)NSString *number;//注数
@end

@interface sps : NSObject


@property(nonatomic,assign)CGFloat rqSheng;
@property(nonatomic,assign)CGFloat rqPing;
@property(nonatomic,assign)CGFloat rqFu;
@property(nonatomic,copy)NSString *sheng;

@property(nonatomic,copy)NSString *fu;
@end
