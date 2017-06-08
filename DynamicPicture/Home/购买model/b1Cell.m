//
//  b1Cell.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/9.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "b1Cell.h"

@implementation b1Cell

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
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        int width = (kMainWidth-50)/4;
        UIView *bg = [[UIView alloc] init];
        bg.frame = CGRectMake(0, 80, kMainWidth, 10);
        bg.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
        [self.contentView addSubview:bg];
        
        
       _bigV1 = [[UIView alloc] init];
        _bigV1.frame = CGRectMake(20, 10, width*3+10, 60);
        [self.contentView addSubview:_bigV1];
        
        for (int i = 0; i<3; i++)
        {
        UILabel *_titles = [[UILabel alloc] init];
        _titles.tag = i;
        _titles.frame = CGRectMake(0, (20)*i, width, 20);
        _titles.font = [UIFont systemFontOfSize:17];
        _titles.textColor = [UIColor blackColor];
        _titles.textAlignment = NSTextAlignmentCenter;
        _titles.adjustsFontSizeToFitWidth = YES;
        [_bigV1 addSubview:_titles];
        }
        
       _leftL = [[UILabel alloc] init];
        _leftL.frame = CGRectMake(width+20, 10, width, 30);
        _leftL.font = [UIFont systemFontOfSize:14];
        _leftL.textColor = [UIColor blackColor];
        _leftL.adjustsFontSizeToFitWidth = YES;
        _leftL.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_leftL];
        
        _rightL = [[UILabel alloc] init];
        _rightL.frame = CGRectMake(kMainWidth-20-width, 10, width, 30);
        _rightL.font = [UIFont systemFontOfSize:14];
        _rightL.textColor = [UIColor blackColor];
        _rightL.adjustsFontSizeToFitWidth = YES;
        _rightL.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_rightL];
        
        UIImageView *_headImg = [[UIImageView alloc]initWithFrame:CGRectMake(kMainWidth-20-2*width+(width-25)/2-5, 13, 30, 25)];
        _headImg.image = [UIImage imageNamed:@"矩形-3-副本-2"];
        [self.contentView addSubview:_headImg];
        
        
        
        _bigV = [[UIView alloc] init];
        _bigV.tag = 120;
        _bigV.frame = CGRectMake(20+width, 40, width*3+10, 30);
        [self.contentView addSubview:_bigV];
        
        for (int i = 0; i<3; i++)
        {
            UIButton *numberL = [[UIButton alloc] init];
            numberL.frame = CGRectMake((width+5)*i, 0, width, 30);
            
            numberL.titleLabel.font = [UIFont systemFontOfSize:12];
            [numberL setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            numberL.titleLabel.textAlignment = NSTextAlignmentCenter;
            numberL.tag = i;
            numberL.backgroundColor = [UIColor whiteColor];
            numberL.clipsToBounds = YES;
            numberL.layer.cornerRadius = 3;
            [numberL.layer setBorderWidth:0.5];
            [numberL.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
            
            [_bigV addSubview:numberL];
        }
        
    }
    return self;
}




-(void)setModel:(b1Model *)model
{
    _leftL.text = model.hostName;
    _rightL.text = model.guestName;
    for (int i = 0; i<_bigV.subviews.count; i++)
    {
        UIButton *btn = _bigV.subviews[i];
        switch (btn.tag) {
            case 0:
            {
                
                [btn setTitle:[NSString stringWithFormat:@"%@",model.sheng==nil?[NSString stringWithFormat:@"%0.2f",model.sp.rqSheng]:model.sheng] forState:(UIControlStateNormal)];
            }
                break;
            case 1:
            {
              [btn setTitle:[NSString stringWithFormat:@"%@",model.ping==nil?[NSString stringWithFormat:@"%0.2f",model.sp.rqPing]:model.ping] forState:(UIControlStateNormal)];
            }
                break;
            case 2:
            {
              [btn setTitle:[NSString stringWithFormat:@"%@",model.fu==nil?[NSString stringWithFormat:@"%0.2f",model.sp.rqFu]:model.fu] forState:(UIControlStateNormal)];
            }
                break;
            default:
                break;
        }
    }
    for (int i = 0; i<_bigV1.subviews.count; i++)
    {
        UILabel *label = _bigV1.subviews[i];
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
                NSArray *arr = [(model.sellEndTime==nil)?model.matchTime:model.sellEndTime componentsSeparatedByString:@" "];
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
