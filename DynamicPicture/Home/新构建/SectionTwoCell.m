//
//  SectionTwoTableViewCell.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "SectionTwoCell.h"

@implementation SectionTwoCell

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
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, kMainWidth, 20)];
        label1.text = @"数字彩";
        label1.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label1];
        UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, 160)];
        [self.contentView addSubview:vv];
        
        
        NSArray *imaA = @[@"10",@"14",@"16",@"21"];
        
        NSArray *titA = @[@"排列3",@"七乐彩",@"排列5",@"快3"];
        
        for (int i = 0; i<4; i++)
        {
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame = CGRectMake((kMainWidth/4)*i, 0, kMainWidth/4,80);
            [addBtn setImage:[UIImage imageNamed:imaA[i]] forState:(UIControlStateNormal)];
            [addBtn setTitle:titA[i] forState:(UIControlStateNormal)];
            [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
            
            addBtn.tag = i;
            addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            addBtn.backgroundColor = [UIColor whiteColor];
            if(i!=3)
            {
            [vv addSubview:addBtn];
            }
            addBtn.imageView.contentMode = UIViewContentModeCenter;
            addBtn.imageEdgeInsets = UIEdgeInsetsMake(-20,(IS_IPHONE_4 ||IS_IPHONE_5)?10:15, 0, 0);
            addBtn.titleEdgeInsets = UIEdgeInsetsMake(50, -50, 0, 0);
        }
    }
    return self;
}

-(void)addClick:(UIButton *)sender
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(SectionTwoCellCellClick:)])
    {
        [self.delegate SectionTwoCellCellClick:sender];
    }
}

@end
