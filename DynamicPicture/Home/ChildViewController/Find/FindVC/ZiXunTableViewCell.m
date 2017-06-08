//
//  ZiXunTableViewCell.m
//  DynamicPicture
//
//  Created by TNP on 2017/4/26.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "ZiXunTableViewCell.h"

@implementation ZiXunTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //[self setSafeBackgroundColor:RGB(242, 243, 244)];
        _headV = [[UIImageView alloc] init];
        _headV.frame = CGRectMake(5, 10, 60, 60);
        
        [self.contentView addSubview:_headV];
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(70, 10, kMainWidth-80, 20);
        _title.font = [UIFont systemFontOfSize:19];
        _title.textColor = [UIColor blackColor];
        _title.text = @"title";
        _title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_title];
        
        _smallTitle = [[UILabel alloc] init];
        _smallTitle.frame = CGRectMake(70, 30, kMainWidth-80, 45);
        _smallTitle.font = [UIFont systemFontOfSize:14];
        _smallTitle.textColor = [UIColor grayColor];
        _smallTitle.text = @"_smallTitle";
        _smallTitle.numberOfLines = 0;
        _smallTitle.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_smallTitle];
        
        
        _upDate = [[UILabel alloc] init];
        _upDate.backgroundColor = [UIColor clearColor];
        _upDate.frame = CGRectMake(kMainWidth-90, 55, 80, 20);
        _upDate.font = [UIFont systemFontOfSize:14];
        _upDate.textColor = [UIColor grayColor];
        _upDate.text = @"title";
        _upDate.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_upDate];
    }
    return self;
}
-(void)setModel:(ZiXunModel *)model
{
    _title.text = model.title;
    _smallTitle.text = model.subTitle;
    _upDate.text = model.pubTime;
    [_headV sd_setImageWithURL:[NSURL URLWithString:model.imgLink] placeholderImage:[UIImage imageNamed:@"ld_000000"]];
    
}

@end
