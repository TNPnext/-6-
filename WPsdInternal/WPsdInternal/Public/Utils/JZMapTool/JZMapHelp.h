//
//  JZMapHelp.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/3/3.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



/**
 *     地图功能工具类
 */
@interface JZMapHelp : NSObject


/**
 *     用地图导航到位置的方法
 *
 *     @param coordinate2d 导航目标位置的坐标对象
 *     @param address      导航目标位置的地名
 */
+ (void)openMapToNavigtionWithCoordinate2D:(CLLocationCoordinate2D)coordinate2d address:(NSString *)address;

/**
 *     算两个地图坐标的实际距离的方法
 *
 *     @param origin      位置1的坐标对象
 *     @param distination 位置2的坐标对象
 *
 *     @return 距离（多少米）
 */
+ (double)distanceWithOriginLocation:(CLLocation *)origin distinationLocation:(CLLocation *)distination;

/**
 *     自定义的计算距离的方法
 *
 *     @param lon1 目标位置经度
 *     @param lat1 目标位置纬度
 *     @param lon2 自己位置经度
 *     @param lat2 自己位置纬度
 *
 *     @return 距离（多少米）
 */
+ (double)customerCalulerWithLon:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;


@end
