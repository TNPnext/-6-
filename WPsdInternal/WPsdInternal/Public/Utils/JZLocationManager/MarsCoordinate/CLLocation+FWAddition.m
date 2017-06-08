//
//  CLLocation+FWAddition.m
//  VideoShare
//
//  Created by Kings Yan on 14-5-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "CLLocation+FWAddition.h"

#import "WGS2GCJ.h"

@implementation CLLocation (FWAddition)

- (CLLocation *)fixedLocation
{
    double lng, lat;
    [WGS2GCJ transformWglat:self.coordinate.latitude wgLng:self.coordinate.longitude mgLat:&lat mgLng:&lng];
    
    CLLocation *location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng) altitude:self.altitude horizontalAccuracy:self.horizontalAccuracy verticalAccuracy:self.verticalAccuracy timestamp:self.timestamp];
    return location;
}

@end
