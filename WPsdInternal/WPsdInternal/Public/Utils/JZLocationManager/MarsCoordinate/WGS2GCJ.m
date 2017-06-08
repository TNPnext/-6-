//
//  WGS2GCJ.h
//  VideoShare
//
//  Created by Kings Yan on 13-12-2.
//  Copyright (c) 2013年 juche. All rights reserved.
//

#import "WGS2GCJ.h"
#import <math.h>
@implementation WGS2GCJ

static BOOL outOfChina(double lat, double lng)
{
    if (lng < 72.004 || lng > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}

static double transformLat(double x, double y)
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

static double transformLng(double x, double y)
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

+ (void)transformWglat:(double)wgLat wgLng:(double)wgLng mgLat:(double *)mgLat mgLng:(double *)mgLng
{
    const double a = 6378245.0;
    const double ee = 0.00669342162296594323;
    
    if (outOfChina(wgLat, wgLng))
    {
        *mgLat = wgLat;
        *mgLng = wgLng;
        return;
    }
    double dLat = transformLat(wgLng - 105.0, wgLat - 35.0);
    double dLon = transformLng(wgLng - 105.0, wgLat - 35.0);
    double radLat = wgLat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    *mgLat = wgLat + dLat;
    *mgLng = wgLng + dLon;
    return;
}
@end
