//
//  ToolBar.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "ToolBar.h"

@implementation ToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat bottomViewX = 0;
        CGFloat bottomViewH = 50;
        CGFloat bottomViewY = kMainHeight - (bottomViewH);
        CGFloat bottomViewW = kMainWidth;
        
        CGFloat commentH = 35;
        CGFloat commentY = 0;
        CGFloat commentW = 60;
        self.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, 1)];
        lineView.backgroundColor = [UIColor hexStringToColor:@"e3e3e3"];
        [self addSubview:lineView];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, commentY+7.5, bottomViewW - commentW - 20 - 10, commentH)];
        self.textField = textField;
        textField.backgroundColor = [UIColor whiteColor];;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        //    textField.layer.cornerRadius = 17.0;
        textField.placeholder = @"来一条高能评论";
        //[textField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
        textField.textColor = [UIColor hexStringToColor:@"#999999"];
        textField.font = [UIFont systemFontOfSize:13];
        textField.layer.borderColor = [UIColor hexStringToColor:@"F4F4F4"].CGColor;
        textField.layer.borderWidth = 1;
        [self addSubview:textField];
        
        CGFloat commentX = CGRectGetMaxX(textField.frame) + 10;
        UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentBtn = commentButton;
        commentButton.backgroundColor = [UIColor hexStringToColor:@"#D43D3D"];
        commentButton.clipsToBounds = YES;
        commentButton.layer.cornerRadius = 5;
        //[commentButton setBackgroundImage:[UIImage imageNamed:@"btn_pinglun"] forState:UIControlStateNormal];
        [commentButton setTitle:@"发送" forState:UIControlStateNormal];
        [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commentButton.frame = CGRectMake(commentX, commentY+7.5, commentW, commentH);
        [self addSubview:commentButton];
        
    }
    return  self;
}

@end
