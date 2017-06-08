//
//  WGS2GCJ.h
//  VideoShare
//
//  Created by Kings Yan on 13-12-2.
//  Copyright (c) 2013年 juche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGS2GCJ : NSObject


/**
 *地球坐标转换为火星坐标
 *（标准gps转为国测局加密坐标）
 **/
+ (void)transformWglat:(double)wgLat wgLng:(double)wgLng mgLat:(double *)mgLat mgLng:(double *)mgLng;


@end
