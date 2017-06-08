//
//  HeaderBtn.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/23.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "HeaderBtn.h"

@implementation HeaderBtn

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGFloat titleW;
    titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = contentRect.size.width - titleW + 8;
    CGFloat titleY = 0;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
