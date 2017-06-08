//
//  UIAlertView+Show.m
//  FindJob
//
//  Created by Chengfj on 14-10-22.
//  Copyright (c) 2014年 RIMI. All rights reserved.
//

#import "UIAlertView+Show.h"

@implementation UIAlertView (Show)

+ (void)showMsg:(NSString *)msg
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end
