//
//  DynamicPictureModel.h
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/23.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "JZBaseModle.h"

@interface DynamicPictureModel : JZBaseModle

@property (nonatomic, copy) NSString *title;/**	视频标题*/

@property (nonatomic, copy) NSString *v_aimurl;/**	资源地址*/

@property (nonatomic, copy) NSString *v_oss_aimurl;/**	oss资源地址*/
@property (nonatomic, copy) NSString *v_id;/**	id*/
@property (copy, nonatomic) NSString *v_width;/**	宽*/
@property (copy, nonatomic) NSString *v_height;/**	高*/

@property (nonatomic, copy) NSString *pic_url;/**	视频标题*/

@property (nonatomic, copy) NSString *pic_oss_url;/**	ossurl图片地址*/

@property (copy, nonatomic) NSString *pic_width;/**	宽*/
@property (copy, nonatomic) NSString *pic_height;/**	高*/
@property (nonatomic, copy) NSString *lastcomment;/**		最后评论时间*/
@property (nonatomic, copy) NSString *lastupdate;/**		最后更新时间*/
@property (nonatomic, copy) NSString *digest;/**	图片介绍*/
@property (nonatomic, copy) NSString *titlecolor;/**	标题颜色*/
@property (nonatomic, copy) NSString *commentnum;/**	评论数量*/
@property (nonatomic, copy) NSString *downnum;/** 喜欢数量*/
@property (nonatomic, copy) NSString *favnum;/**	点踩数量*/
@property (nonatomic, copy) NSString *goodnum;/**	点赞数量*/
@property (nonatomic, copy) NSString *badnum;/**	点踩数量*/
@property (nonatomic, copy) NSString *is_ad;/**	是否是广告*/
@property (nonatomic, copy) NSString *ad_url;/**	广告url*/
@property (nonatomic, copy) NSString *price;/**	如果其值小于等于0，则表示不收费，大于0则为收费。*/


@property (nonatomic, copy) NSString *base_id;
@property (nonatomic, assign) BOOL play;
@property (assign, nonatomic) BOOL isLoaded;

@property (nonatomic, assign) BOOL supported;
@property (nonatomic, assign) BOOL oppositioned;
@property (assign, nonatomic) BOOL commented ;
@property (nonatomic, assign) BOOL shared;

@end
