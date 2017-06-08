//
//  BuyViewController.h
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImage+Extension.h>
#import "NetworkPublicHeader.h"
#import "WebDetailViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "b1Model.h"
#import "b1Cell.h"
#import "b2Cell.h"
#import "b3Cell.h"
#import "b4Cell.h"
#import "GuiZheView.h"
#import "UserModel.h"
#import "OrderViewController.h"
@interface BuyViewController : UIViewController
@property(nonatomic,assign)BOOL haveList;

@property(nonatomic,copy)NSString *dataUrl;

@property(nonatomic,strong)UILabel *topTitle;
@end
