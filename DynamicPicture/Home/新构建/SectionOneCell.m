//
//  SectionOneCell.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/8.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "SectionOneCell.h"

@implementation SectionOneCell

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
        label1.text = @"热门彩种";
        label1.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label1];
        UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, 160)];
        [self.contentView addSubview:vv];
        
        
        NSArray *imaA = @[@"3",@"1",@"2",@"21"];//
        NSArray *imaA2 = @[@"6",@"17",@"9",@"4"];
        NSArray *titA = @[@"竞彩足球",@"双色球",@"大乐透",@"快3"];
        NSArray *titA2 = @[@"福彩3D",@"七星彩",@"北京单场",@"竞彩篮球"];//
        for (int i = 0; i<4; i++)
        {
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame = CGRectMake((kMainWidth/4)*i, 0, kMainWidth/4,80);
            [addBtn setImage:[UIImage imageNamed:imaA[i]] forState:(UIControlStateNormal)];
            [addBtn setTitle:titA[i] forState:(UIControlStateNormal)];
            [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
            addBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 10, 0, 0);
            addBtn.titleEdgeInsets = UIEdgeInsetsMake(50, -50, 0, 0);
            addBtn.tag = i;
            addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            addBtn.backgroundColor = [UIColor whiteColor];
            [vv addSubview:addBtn];
        }
        for (int i = 0; i<4; i++)
        {
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame = CGRectMake((kMainWidth/4)*i, 80, kMainWidth/4,80);
            [addBtn setImage:[UIImage imageNamed:imaA2[i]] forState:(UIControlStateNormal)];
            [addBtn setTitle:titA2[i] forState:(UIControlStateNormal)];
            [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
            addBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 10, 0, 0);
            addBtn.titleEdgeInsets = UIEdgeInsetsMake(50, -50, 0, 0);
            addBtn.tag = 4+i;
            addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            addBtn.backgroundColor = [UIColor whiteColor];
            if (i==0) {
               addBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 14, 0, 0);
            }
            [vv addSubview:addBtn];
        }

    }
    return self;
}

-(void)addClick:(UIButton *)sender
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(SectionOneCellClick:)])
    {
        [self.delegate SectionOneCellClick:sender];
    }
}
@end
