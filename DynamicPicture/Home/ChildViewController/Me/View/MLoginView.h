//
//  MLoginView.h
//  DynamicPicture
//
//  Created by TNP on 17/3/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^loginSuccess)(BOOL success);
typedef void (^saveName)(NSString *name);
typedef void (^chooseType)(NSString *type);
typedef void (^cancelBlock)();
typedef void (^sureBlock)();
@interface MLoginView : UIView

@property(nonatomic,copy)loginSuccess loginBlock;
@property(nonatomic,copy)cancelBlock cancelLoginBlock;
-(void)show;
@end

//加入会员View
@interface PayView : UIView
//0=选择包月/1=支付方式
@property(nonatomic,assign)BOOL type;
@property(nonatomic,copy)chooseType chooseTypeBlock;
-(void)show;


@end


//简单提示
@interface AlertViewSimp : UIView
@property(nonatomic,copy)sureBlock sureblock;
@property(nonatomic,assign)BOOL userEnter;//是否进入会员中心
-(void)show;

-(id)initWithTitle:(NSString *)title tips:(NSString *)tip buttonT1:(NSString *)t1 buttonT2:(NSString *)t2;

@end

//修改昵称
@interface ChangeNmaeView : UIView


@property(nonatomic,copy)saveName saveNameBlock;
-(void)show;



@end
