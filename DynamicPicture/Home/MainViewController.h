//
//  MainViewController.h
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *CATEGORY_CONTROLLERS_CACHE_KEY;

@interface MainViewController : UIViewController

@property (nonatomic, strong) JZSegmentedBarController *segmentedBarController;

- (void)exchangeContrllersWithCategorys:(NSArray *)categorys;

@end
