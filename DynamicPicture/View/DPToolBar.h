//
//  ToolBar.h
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPToolBar;

@protocol DPToolBarDelegate <NSObject>

- (void)toolBar:(DPToolBar *)toolBar commentBtnClick:(UIButton *)commentBtn;

@end

@interface DPToolBar : UIView

@property (strong, nonatomic) UITextField *textField;
@property (weak, nonatomic) id<DPToolBarDelegate> delegate;

@end
