//
//  PictureFrameModel.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "PictureFrameModel.h"

@implementation PictureFrameModel

- (void)setPictureModel:(DynamicPictureModel *)pictureModel {
    _pictureModel = pictureModel;
    
    CGFloat titleX = 10;
    CGFloat titleW = kMainWidth - titleX * 2;
    CGSize titleSize = [pictureModel.title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
    _titleLabelFrame = (CGRect){{titleX, 10}, titleSize};
    
    
    CGFloat imgWidth = [pictureModel.pic_width floatValue];
    CGFloat imgHeight = [pictureModel.pic_height floatValue];
    CGFloat imageW = kMainWidth - 20.f;
    
    CGFloat imageH;
    if(imgWidth <= 0)
    {
        imageH = 250; //默认250的高度
    }else
    {
        imageH =  imageW * imgHeight / imgWidth;
        //计算后的高>原图高 取原图的高
//        if(imageH > imgHeight)
//        {
//           imageH = imgHeight;
//        }
    }
    CGFloat imageY = isnan(CGRectGetMaxY(_titleLabelFrame)) ? 0 : CGRectGetMaxY(_titleLabelFrame) + 10;
    _pictureFrame = CGRectMake(titleX, imageY, (kMainWidth-20.f), imageH);
    //NSLog(@"---_pictureFrame:%@",NSStringFromCGRect(_pictureFrame));
    
    CGFloat gifWH = 42;
    CGFloat gifX = titleW / 2 - gifWH / 2;
    CGFloat gifY = imageH / 2 - gifWH / 2;
    _gitFrame = CGRectMake(gifX, gifY, gifWH, gifWH);
    
    _topViewHeight = isnan(CGRectGetMaxY(_pictureFrame))? 0 : CGRectGetMaxY(_pictureFrame);
    
    CGFloat toolH = 40;
    CGFloat toolY = isnan(CGRectGetMaxY(_pictureFrame)) ? 0 : CGRectGetMaxY(_pictureFrame);
    _toolBarFrame = CGRectMake(0, toolY, kMainWidth, toolH);
    
    _cellHeight = isnan(CGRectGetMaxY(_toolBarFrame)) ? 0 : CGRectGetMaxY(_toolBarFrame) + 10;
    
}

@end
