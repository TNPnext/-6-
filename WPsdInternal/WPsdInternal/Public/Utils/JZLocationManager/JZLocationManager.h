//
//  FWLocationManager.h
//  VideoShare
//
//  Created by Kings Yan on 14-5-21.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
#import "CLLocation+FWAddition.h"



/**
 *     定位工具类的封装
 */
@interface JZLocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *_locManager;
}


+ (instancetype)shareManager;

/** if No, when location is Ok, will close location manager. default is YES;
 */
@property (nonatomic, assign) BOOL isLongTermOpen;

- (void)openLocation; // open location.
- (void)stopLocation; // stop location.

@property (nonatomic , strong, readonly) CLLocationManager * locManager;
@property (nonatomic , copy) void (^locationBlock) (CLLocation * newLocation,CLLocation * oldLocation , NSError *error);


@end
