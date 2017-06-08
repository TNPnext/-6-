//
//  SectionOneCell.h
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SectionOneCellDelegate;
@interface SectionOneCell : UITableViewCell
@property(nonatomic,weak)id <SectionOneCellDelegate> delegate;
@end
@protocol SectionOneCellDelegate <NSObject>

-(void)SectionOneCellClick:(UIButton *)sender;

@end
