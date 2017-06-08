//
//  MyCollectionViewCell.m
//  DynamicPicture
//
//  Created by TNP on 2017/4/20.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@implementation MyCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //self.backgroundColor = [UIColor hexStringToColor:@"999999"];
        _imgaeV = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, self.width-50, self.width-50)];
        _imgaeV.clipsToBounds = YES;
        _imgaeV.layer.cornerRadius = (self.width-50)/2;
        [self.contentView addSubview:_imgaeV];
        
        _titles = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height-30, self.width, 20)];
        _titles.textAlignment = NSTextAlignmentCenter;
        _titles.font = [UIFont systemFontOfSize:17];
        _titles.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titles];
        
    }
    return self;
}
//-(void)setModel:(SearModel *)model
//{
//    [_imgaeV sd_setImageWithURL:[NSURL URLWithString:model.lottery_image_url]];
//    _titles.text = model.lottery_name;
//}
@end
