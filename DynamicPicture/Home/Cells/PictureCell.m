//
//  PictureCell.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "PictureCell.h"
#import "DPToolBarButton.h"

@interface PictureCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) DPToolBarButton *supporBtn;
@property (strong, nonatomic) DPToolBarButton *oppsitionBtn;
@property (strong, nonatomic) DPToolBarButton *shareBtn;

@end

@implementation PictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSafeBackgroundColor:[UIColor hexStringToColor:@"#F3F3F3"]];
        
        UIView *topView = [[UIView alloc] init];
        self.topView = topView;
        topView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:topView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:18];
        [topView addSubview:titleLabel];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        self.picView = imageView;
        imageView.backgroundColor = [UIColor orangeColor];
        [topView addSubview:imageView];
        
        UIView *toolBar = [[UIView alloc] init];
        toolBar.backgroundColor = [UIColor whiteColor];
        self.toolBar = toolBar;
        toolBar.layer.cornerRadius = 5;
        toolBar.clipsToBounds = YES;
        toolBar.layer.borderWidth = 1;
        toolBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:toolBar];
        
        DPToolBarButton *supporBtn = [DPToolBarButton buttonWithType:UIButtonTypeCustom];
        self.supporBtn = supporBtn;
        [supporBtn setImage:[UIImage imageNamed:@"dianzan---no"] forState:UIControlStateNormal];
        [supporBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateSelected];
        supporBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [supporBtn setTitleColor:[UIColor hexStringToColor:@"999999"] forState:UIControlStateNormal];
        CGFloat supportW = 80;
        CGFloat supportH = 15;
        CGFloat supportY = 11.5;
        supporBtn.frame = CGRectMake(5, supportY, supportW, supportH);
        supporBtn.tag = 100;
        [supporBtn addTarget:self action:@selector(toolBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:supporBtn];
        
        DPToolBarButton *oppsitionBtn = [DPToolBarButton buttonWithType:UIButtonTypeCustom];
        self.oppsitionBtn = oppsitionBtn;
        [oppsitionBtn setImage:[UIImage imageNamed:@"cai--no"] forState:UIControlStateNormal];
        [oppsitionBtn setImage:[UIImage imageNamed:@"cai"] forState:UIControlStateSelected];
        oppsitionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [oppsitionBtn setTitleColor:[UIColor hexStringToColor:@"999999"] forState:UIControlStateNormal];
        CGFloat oppsitionX = CGRectGetMaxX(supporBtn.frame) + 20;
        oppsitionBtn.frame = CGRectMake(oppsitionX, supportY, supportW, supportH);
        oppsitionBtn.tag = 101;
        [oppsitionBtn addTarget:self action:@selector(toolBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:oppsitionBtn];
        
        DPToolBarButton *shareBtn = [DPToolBarButton buttonWithType:UIButtonTypeCustom];
        self.shareBtn = shareBtn;
        [shareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        shareBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [shareBtn setTitleColor:[UIColor hexStringToColor:@"999999"] forState:UIControlStateNormal];
        [shareBtn sizeToFit];
        CGFloat shareX = kMainWidth - 100 - shareBtn.width;
        shareBtn.frame = CGRectMake(shareX, supportY, supportW, supportH);
        shareBtn.tag = 102;
        [shareBtn addTarget:self action:@selector(toolBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:shareBtn];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setPicFrameModel:(PictureFrameModel *)picFrameModel {
//    _picFrameModel = picFrameModel;
//    DynamicPictureCellModel *model = picFrameModel.pictureModel;
//    self.titleLabel.text = model.title;
//    self.picView.image = [UIImage imageNamed:model.image];
//    [self.supporBtn setTitle:model.support forState:UIControlStateNormal];
//    [self.oppsitionBtn setTitle:model.opposition forState:UIControlStateNormal];
//    [self.shareBtn setTitle:model.share forState:UIControlStateNormal];
//    
//    self.topView.frame = CGRectMake(0, 0, kMainWidth, picFrameModel.topViewHeight);
//    self.titleLabel.frame = picFrameModel.titleLabelFrame;
//    self.picView.frame = picFrameModel.pictureFrame;
//    self.toolBar.frame = picFrameModel.toolBarFrame;
}

- (void)toolBarButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pictureCell:toolBarButtonDidClick:)]) {
        [self.delegate pictureCell:self toolBarButtonDidClick:sender];
    }
}

@end
