//
//  CommentTableViewCell.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "DynamicPictureCell.h"
#import "DPToolBarButton.h"

#define leftMargin 15
#define contentFont [UIFont systemFontOfSize:16]

@interface CommentTableViewCell ()

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) DPToolBarButton *supporBtn;

@end

@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSafeBackgroundColor:[UIColor hexStringToColor:@"#FFFFFF"]];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLable = titleLabel;
        titleLabel.textColor = [UIColor hexStringToColor:@"#999999"];
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        self.contentLabel = contentLabel;
        contentLabel.numberOfLines = 0;
        contentLabel.font = contentFont;
        contentLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        [self.contentView addSubview:contentLabel];
        
        UILabel *timeLabel = [UILabel new];
        self.timeLabel = timeLabel;
        timeLabel.textColor = [UIColor hexStringToColor:@"#999999"];
        timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:timeLabel];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor hexStringToColor:@"E3E3E3"];
        self.lineView = lineView;
        [self.contentView addSubview:lineView];
        
        DPToolBarButton *supporBtn = [DPToolBarButton buttonWithType:UIButtonTypeCustom];
        self.supporBtn = supporBtn;
        [supporBtn setImage:[UIImage imageNamed:@"dianzan---no"] forState:UIControlStateNormal];
        [supporBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateSelected];
        supporBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [supporBtn setTitleColor:[UIColor hexStringToColor:@"999999"] forState:UIControlStateNormal];
        supporBtn.tag = 100;
        [supporBtn addTarget:self action:@selector(supportBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:supporBtn];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setCommentFrameModel:(CommentFrameModel *)commentFrameModel {
//    _commentFrameModel = commentFrameModel;
//    CommentModel *model = commentFrameModel.commentModel;
//    
//    self.titleLable.text = model.title;
//    self.contentLabel.text = model.content;
//    self.timeLabel.text = model.time;
//    [self.supporBtn setTitle:model.supportCount forState:UIControlStateNormal];
//    
//    self.titleLable.frame = commentFrameModel.titleLabelFrame;
//    self.supporBtn.frame = CGRectMake(kMainWidth - self.titleLable.left - 80, self.titleLable.top, 80, self.titleLable.height);
//    self.contentLabel.frame = commentFrameModel.contentLabelFrame;
//    self.timeLabel.frame = commentFrameModel.timeLabelFrame;
//    self.lineView.frame = CGRectMake(0, commentFrameModel.commentCellHeight - 1, kMainWidth, 1);
}

- (void)supportBtnClick:(DPToolBarButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentTableViewCell:supportButtonDidClick:)]) {
        [self.delegate commentTableViewCell:self supportButtonDidClick:sender];
    }
}

@end

