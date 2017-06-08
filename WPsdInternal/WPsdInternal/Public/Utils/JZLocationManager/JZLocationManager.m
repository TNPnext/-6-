//
//  FWLocationManager.m
//  VideoShare
//
//  Created by Kings Yan on 14-5-21.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "JZLocationManager.h"

@interface JZLocationManager ()

@end

@implementation JZLocationManager

@synthesize
isLongTermOpen = _isLongTermOpen;

+ (instancetype)shareManager
{
    static JZLocationManager *__single__;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        __single__ = [[JZLocationManager alloc]init];
        [__single__ loadLocation];
    });
    return __single__;
}

- (id)loadLocation
{
    _locManager = [[CLLocationManager alloc]init];
    if ([_locManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locManager requestAlwaysAuthorization];
    }
    if ([_locManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locManager requestWhenInUseAuthorization];
    }
    _locManager.delegate = self;
    _locManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locManager.distanceFilter = 1.0f;
    return _locManager;
}

- (void)openLocation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isLongTermOpen = YES;
        [_locManager startUpdatingLocation];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
}

- (void)stopLocation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_locManager stopUpdatingLocation];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
}

#pragma mark - CLLocation Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:
(CLLocation *)oldLocation
{
    self.locationBlock(newLocation, oldLocation, nil);
    [self _verifyLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations.count > 0) {
        self.locationBlock([locations lastObject], [locations lastObject],nil);
        [self _verifyLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
    self.locationBlock(nil,nil,error);
    [self _verifyLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            if ([_locManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locManager requestAlwaysAuthorization];
            }
        } break;
            
        default:
            break;
    }
}

#pragma mark - help

- (void)_verifyLocation
{
    if (_isLongTermOpen == NO) {
        [self stopLocation];
    }
}

@end
