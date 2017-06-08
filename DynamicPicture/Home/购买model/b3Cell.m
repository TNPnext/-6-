//
//  b3Cell.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/18.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b3Cell.h"

@implementation b3Cell

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
                
                [btn setTitle:@"主胜" forState:(UIControlStateNormal)];
            }
                break;
            case 1:
            {
                
                [btn setTitle:@"平" forState:(UIControlStateNormal)];
            }
                break;
            case 2:
            {
                [btn setTitle:@"主负" forState:(UIControlStateNormal)];
            }
                break;
            default:
                break;
        }
    }
    for (int i = 0; i<self.bigV1.subviews.count; i++)
    {
        UILabel *label = self.bigV1.subviews[i];
        NSArray *arr = [model.matchTime componentsSeparatedByString:@" "];
        switch (label.tag) {
            case 0:
            {
                label.text = [NSString stringWithFormat:@"%ld",self.indexPath.row+1];
                label.font = [UIFont systemFontOfSize:17];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor blackColor];
            }
                break;
            case 1:
            {
                label.text = arr[0];
                label.textColor = [UIColor grayColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:10];
            }
                break;
            case 2:
            {
                
                label.text = [NSString stringWithFormat:@"%@开赛",arr[1]];
                label.textColor = [UIColor grayColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:10];
            }
                break;
            default:
                break;
        }
    }
    
}


@end
