//
//  DynamicPictureListApiModel.h
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/23.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "JZBaseModle.h"
#import "DynamicPictureModel.h"

@interface DynamicPictureListApiModel : JZBaseModle

@property (nonatomic, strong) NSArray <DynamicPictureModel>*data;

@end
