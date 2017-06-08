//
//  OrderCell.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/23.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = 0;
        _numberL = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, kMainWidth-80, 20)];
        _numberL.textAlignment = 0;
        //_numberL.textColor = [UIColor lightGrayColor];
        _numberL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_numberL];
        
        _typeL = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 100, 20)];
        _typeL.textAlignment = 0;
        _typeL.textColor = [UIColor lightGrayColor];
        _typeL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_typeL];
        
        _multipleL = [[UILabel alloc]initWithFrame:CGRectMake(120, 35, kMainWidth-180, 20)];
        _multipleL.textAlignment = 0;
        _multipleL.textColor = [UIColor lightGrayColor];
        _multipleL.font = [UIFont systemFontOfSize:15];
        _multipleL.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_multipleL];
        
        _witeL = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth-60, 0, 60, 60)];
        _witeL.textAlignment = 0;
        _witeL.textColor = [UIColor hexStringToColor:KNavBarHexColor];
        _witeL.text = @"待开奖";
        _witeL.font = [UIFont systemFontOfSize:15];
        _witeL.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_witeL];
        
    }
    return self;
}

-(void)setModel:(b2Model *)model
{
    if (!model) {
        return;
    }
    NSString *str = [model.drawNumber stringByReplacingOccurrencesOfString:@"," withString:@" "];
    NSString *str2 = @"";
    if ([str containsString:@"#"])
    {
        str2 = [str componentsSeparatedByString:@"#"][1];
    }
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"#" withString:@"  +"];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str1];
    if (str2.length>0)
    {
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor hexStringToColor:KNavBarHexColor]
                                 range:NSMakeRange(0,str1.length-str2.length)];
        
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor blueColor]
                                 range:NSMakeRange(str1.length-str2.length,str2.length)];
        
    }else
    {
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor hexStringToColor:KNavBarHexColor]
                                 range:NSMakeRange(0,model.drawNumber.length)];
    }
    _numberL.attributedText = attributedString;
    _typeL.text = model.types;
    _multipleL.text = [NSString stringWithFormat:@"共%@注%d元",model.number,[model.number intValue]*2];
    if (model.multiple) {
      _multipleL.text = [NSString stringWithFormat:@"%@倍  共%@注%d元",model.multiple,model.number,[model.number intValue]*2*[model.multiple intValue]];
    }
    
}
@end
