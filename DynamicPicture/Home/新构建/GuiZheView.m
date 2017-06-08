//
//  GuiZheView.m
//  CaiPiaoApp
//
//  Created by TNP on 2017/5/19.
//  Copyright © 2017年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "GuiZheView.h"
@interface GuiZheView()
{
    UIView *_bgV;
}
@end
@implementation GuiZheView

-(id)init
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, kMainWidth, kMainHeight);
        _bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
        
        _bgV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self addSubview:_bgV];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        [_bgV addGestureRecognizer:tap];
        
        
        UIImageView *_headImg = [[UIImageView alloc]initWithFrame:CGRectMake(kMainWidth-60, 46, 20, 20)];
        _headImg.contentMode = UIViewContentModeScaleAspectFit;
        _headImg.image = [UIImage imageNamed:@"select"];
        [self addSubview:_headImg];
        
        UIView *btnBg = [[UIView alloc]initWithFrame:CGRectMake(kMainWidth-160, 64, 140, 88)];
        btnBg.backgroundColor = [UIColor whiteColor];
        btnBg.clipsToBounds = YES;
        btnBg.layer.cornerRadius = 8;
        [self addSubview:btnBg];
        
        NSArray *titA = @[@"走势图",@"玩法介绍"];
        for (int i = 0; i<2; i++)
        {
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            addBtn.frame = CGRectMake(0, 44*i, 140, 44);
            [addBtn setTitle:titA[i] forState:(UIControlStateNormal)];
            [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            addBtn.tag = i;
            [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
            addBtn.backgroundColor = [UIColor whiteColor];
            [btnBg addSubview:addBtn];
            if (i==0)
            {
                [addBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:(UIControlStateNormal)];
                [addBtn addtionUnderlineWithSross:0.5 withColor:[UIColor grayColor]];
            }
        }
        
    }
    return self;
}

-(void)addClick:(UIButton *)sender
{
    if (self.btnBlock)
    {
        self.btnBlock(sender.tag);
        [self dismissView];
    }
}

-(void)showView
{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}

-(void)dismissView
{
    [self removeFromSuperview];
}
@end
