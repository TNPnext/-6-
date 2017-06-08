//
//  b2Cell.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/17.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b2Cell.h"

@implementation b2Cell

-(void)setModel:(b1Model *)model
{
    self.leftL.text = model.hostName;
    self.rightL.text = model.guestName;
    for (int i = 0; i<self.bigV.subviews.count; i++)
    {
        UIButton *btn = self.bigV.subviews[i];
        switch (btn.tag) {
            case 0:
            {
                
                [btn setTitle:[NSString stringWithFormat:@"%@",model.sp.sheng] forState:(UIControlStateNormal)];
            }
                break;
            case 1:
            {
                btn.enabled = NO;
                [btn setTitle:@"VS" forState:(UIControlStateNormal)];
            }
                break;
            case 2:
            {
                [btn setTitle:[NSString stringWithFormat:@"%@",model.sp.fu] forState:(UIControlStateNormal)];
            }
                break;
            default:
                break;
        }
    }
    for (int i = 0; i<self.bigV1.subviews.count; i++)
    {
        UILabel *label = self.bigV1.subviews[i];
        switch (label.tag) {
            case 0:
            {
                label.text = model.leagueName;
            }
                break;
            case 1:
            {
                label.text = model.teamId;
            }
                break;
            case 2:
            {
                NSArray *arr = [model.sellEndTime componentsSeparatedByString:@" "];
                label.text = [NSString stringWithFormat:@"%@截止",arr[1]];
                label.textColor = [UIColor grayColor];
                label.font = [UIFont systemFontOfSize:14];
            }
                break;
            default:
                break;
        }
    }
 
}

@end
