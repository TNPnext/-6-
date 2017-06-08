//
//  ShareView.h
//  Jest
//
//  Created by 段振伟 on 16/7/29.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

typedef enum : NSUInteger
{
    shareWeixinfriend,  //微信好友
    shareMoment,        //朋友圈
    shareQQ,            //qq
    shareQZone,            //qq空间
    shareSina,         //新浪
    shareClose,         // 关闭
    shareCollect,         // 收藏
    sharerRporet,         // 举报
}ShareType;

typedef void(^ShareJestBlock)(ShareType type);

@class DynamicPictureModel;

@interface ShareView : UIView


@property (nonatomic,copy)ShareJestBlock shareblock;

- (void)shareWithDynamicPictureModel:(DynamicPictureModel *)picModel shareType:(SSDKPlatformType)type success:(void(^)())success;

@end
