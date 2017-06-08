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
@property (strong, nonatomic) UIButton *reportBtn;

@end

@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSafeBackgroundColor:[UIColor hexStringToColor:@"#FFFFFF"]];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLable = titleLabel;
        titleLabel.textColor = [UIColor hexStringToColor:@"#999999"];
        titleLabel.font = [UIFont systemFontOfSize:13];
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
        timeLabel.font = [UIFont systemFontOfSize:13];
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
        
        UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.reportBtn = reportBtn;
        [reportBtn setTitle:@"举报" forState:UIControlStateNormal];
        reportBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [reportBtn setTitleColor:[UIColor hexStringToColor:@"999999"] forState:UIControlStateNormal];
        reportBtn.tag = 200;
        [reportBtn addTarget:self action:@selector(reportBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:reportBtn];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setCommentFrameModel:(CommentFrameModel *)commentFrameModel {
    _commentFrameModel = commentFrameModel;
    CommentModel *model = commentFrameModel.commentModel;
    
    self.titleLable.text = model.username;
    self.contentLabel.text = model.message;
    self.timeLabel.text = model.dateline;
    [self.supporBtn setTitle:model.goodnum forState:UIControlStateNormal];
    self.supporBtn.selected = model.supportSeleted;
    
    self.titleLable.frame = commentFrameModel.titleLabelFrame;
    self.reportBtn.frame = CGRectMake(kMainWidth - self.titleLable.left - 30, self.titleLable.top, 30, self.titleLable.height);
    self.supporBtn.frame = CGRectMake(kMainWidth - self.titleLable.left - 50 - 35, self.titleLable.top, 50, self.titleLable.height);
    self.contentLabel.frame = commentFrameModel.contentLabelFrame;
    self.timeLabel.frame = commentFrameModel.timeLabelFrame;
    self.lineView.frame = CGRectMake(0, commentFrameModel.commentCellHeight - 1, kMainWidth, 1);
}

- (void)supportBtnClick:(DPToolBarButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentTableViewCell:supportButtonDidClick:)]) {
        [self.delegate commentTableViewCell:self supportButtonDidClick:sender];
    }
}

- (void)reportBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentTableViewCell:reportButtonDidClick:)]) {
        [self.delegate commentTableViewCell:self reportButtonDidClick:sender];
    }
}

@end

