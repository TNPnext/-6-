//
//  ADModel.h
//  DynamicPicture
//
//  Created by TNP on 17/1/21.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADModel : NSObject
/**  版本*/
@property(nonatomic,copy)NSString *vision;
/**  安卓下载地址*/
@property(nonatomic,copy)NSString *download_url;
/**  广告图片地址*/
@property(nonatomic,copy)NSString *ad_img;
/**  广告链接地址*/
@property(nonatomic,copy)NSString *ad_url;
/**  广告标题*/
@property(nonatomic,copy)NSString *ad_title;
/**  广告图片的宽*/
@property(nonatomic,copy)NSString *ad_img_width;
/**  广告图片的高*/
@property(nonatomic,copy)NSString *ad_img_height;
/**  iOS是否显示广告*/
@property(nonatomic,copy)NSString *ad_ios_show;
/**  分享下载地址*/
@property(nonatomic,copy)NSString *share_url;
/**  核对版本是否是审核版本*/
@property(nonatomic,copy)NSString *version_checking;
/**  是否显示开屏广告*/
@property(nonatomic,copy)NSString *ad_kaipin_show;
@end
