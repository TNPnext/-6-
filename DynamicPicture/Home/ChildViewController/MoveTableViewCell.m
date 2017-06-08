//
//  MoveTableViewCell.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/2.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "MoveTableViewCell.h"

@implementation MoveTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(20, 10, kMainWidth, 30);
        _title.textColor = [UIColor blackColor];
        _title.text = @"第1795858期";
        _title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_title];
        
        _datas = [[UILabel alloc] init];
        _datas.frame = CGRectMake(20, 40, kMainWidth, 30);
        _datas.text = @"2017-12-30";
        _datas.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_datas];
        
        _numberL = [[UILabel alloc] init];
        _numberL.frame = CGRectMake(kMainWidth-70, 20, 60, 20);
        _numberL.font = [UIFont systemFontOfSize:14];
        _numberL.textColor = [UIColor hexStringToColor:KNavBarHexColor];
        _numberL.textAlignment = NSTextAlignmentRight;
        _numberL.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_numberL];
        
        
    }
    return self;
}
-(void)setModel:(MoveModel *)model
{
    if (!model) {
        return;
    }
    NSString *str0 = [model.calc stringByReplacingOccurrencesOfString:@"," withString:@" "];
    NSString *str1 = [NSString stringWithFormat:@"<专家>  %@  %@",model.username,model.hitnum];
    NSString *str2 = [NSString stringWithFormat:@"预测号码  %@",str0];
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:str1];
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc] initWithString:str2];
    [str3 addAttribute:NSForegroundColorAttributeName
                value:[UIColor hexStringToColor:KNavBarHexColor]
                range:NSMakeRange(0,4)];
    [str3 addAttribute:NSForegroundColorAttributeName
                value:[UIColor greenColor]
                range:NSMakeRange(5,model.username.length+1)];
    [str3 addAttribute:NSForegroundColorAttributeName
                value:[UIColor blackColor]
                range:NSMakeRange(model.username.length+6,model.hitnum.length)];
    
    
    [str4 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor grayColor]
                 range:NSMakeRange(0,4)];
    [str4 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor hexStringToColor:KNavBarHexColor]
                 range:NSMakeRange(5,str0.length+1)];
    
    _title.attributedText = str3;
    _datas.attributedText = str4;
    _numberL.text = model.award;
}

@end
