//
//  SectionTwoTableViewCell.h
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionTwoCellDelegate;
@interface SectionTwoCell : UITableViewCell
@property(nonatomic,weak)id <SectionTwoCellDelegate> delegate;
@end
@protocol SectionTwoCellDelegate <NSObject>

-(void)SectionTwoCellCellClick:(UIButton *)sender;

@end
