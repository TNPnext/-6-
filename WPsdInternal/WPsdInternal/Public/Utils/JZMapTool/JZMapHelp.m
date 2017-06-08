//
//  JZMapHelp.m
//  GSJuZhang
//
//  Created by Kings Yan on 15/3/3.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZMapHelp.h"

@implementation JZMapHelp

+ (void)openMapToNavigtionWithCoordinate2D:(CLLocationCoordinate2D)coordinate2d address:(NSString *)address
{
    if (!coordinate2d.latitude || !coordinate2d.longitude || !address) {
        return;
    }
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate2d addressDictionary:nil]];
    toLocation.name = address;
    [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                   launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                             forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
}

#pragma mark - calculate distance

+ (double)distanceWithOriginLocation:(CLLocation *)origin distinationLocation:(CLLocation *)distination
{
    CLLocationDistance kilometers = [origin distanceFromLocation:distination] / 1000;
    return kilometers;
}

#define PI 3.1415926

+ (double)customerCalulerWithLon:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2
{
//    double er = 6378137; // 6378700.0f;
//    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
//    //equatorial radius = 6378.388
//    //nautical mile = 1.15078
//    double radlat1 = PI*lat1/180.0f;
//    double radlat2 = PI*lat2/180.0f;
//    //now long.
//    double radlong1 = PI*lon1/180.0f;
//    double radlong2 = PI*lon2/180.0f;
//    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
//    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
//    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
//    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
//    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
//    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
//    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
//    //zero ag is up so reverse lat
//    double x1 = er * cos(radlong1) * sin(radlat1);
//    double y1 = er * sin(radlong1) * sin(radlat1);
//    double z1 = er * cos(radlat1);
//    double x2 = er * cos(radlong2) * sin(radlat2);
//    double y2 = er * sin(radlong2) * sin(radlat2);
//    double z2 = er * cos(radlat2);
//    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
//    //side, side, side, law of cosines and arccos
//    double theta = acos((er*er+er*er-d*d)/(2*er*er));
//    double dist  = theta*er;
//    return dist;
    
    double jl_jd = 102834.74258026089786013677476285;
    double jl_wd = 111712.69150641055729984301412873;
    double b = fabs((lon1 - lon2) * jl_jd);
    double a = fabs((lat1 - lat2) * jl_wd);
    return sqrt((a * a + b * b)) / 1000;
}

@end
