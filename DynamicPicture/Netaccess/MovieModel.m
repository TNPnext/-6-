//
//  MovieModel.m
//  MoivePlace
//
//  Created by TNP on 17/2/10.
//  Copyright © 2017年 cxmx. All rights reserved.
//

#import "MovieModel.h"
#import "MJRefresh.h"

//---------电影模型---------------------------------------------------
@implementation MovieModel

@end

//---------电影分组模型---------------------------------------------------
@implementation MovieGroup
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"datas" : [MovieModel class]};
}

@end

//---------电影分类模型---------------------------------------------------
@implementation MovieCategory
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"child" : [MovieCategory class]};
}

@end

//---------广告模型---------------------------------------------------
@implementation BannerModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

@end

//---------版本模型---------------------------------------------------
@implementation VersionModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

@end

//---------播放地址---------------------------------------------------
@implementation PlaySource

@end

//---------电影详情---------------------------------------------------
@implementation MovieDetail
- (void)setD_type:(NSString *)d_type{
    _d_type = d_type;
    _movieType =  [d_type integerValue];
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"d_playurl" : [PlaySource class]};
}

@end

//---------电影初始化信息---------------------------------------------------
@implementation DefaultStart

@end



