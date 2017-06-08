//
//  ADTableViewCell.m
//  DynamicPicture
//
//  Created by TNP on 17/1/21.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "ADTableViewCell.h"
#import "MJExtension.h"
#import "ADModel.h"
@implementation ADTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ADTableViewCellID = @"ADTableViewCellID";
    ADTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADTableViewCellID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _ADImage = [[UIImageView alloc]init];
        _ADImage.contentMode = UIViewContentModeScaleAspectFit;
        //_ADImage.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_ADImage];
    }
    return  self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _ADImage.frame = self.bounds;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
