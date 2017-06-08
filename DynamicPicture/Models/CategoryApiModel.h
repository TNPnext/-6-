//
//  CategoryApiModel.h
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/23.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "JZBaseModle.h"
#import "CategoryModel.h"

@interface CategoryApiModel : JZBaseModle

@property (nonatomic, strong) NSArray <CategoryModel>*data;

@end
