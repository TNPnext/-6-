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


@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) DPToolBarButton *supporBtn;
@property (strong, nonatomic) DPToolBarButton *oppsitionBtn;
@property (strong, nonatomic) DPToolBarButton *commentBtn;
@property (strong, nonatomic) DPToolBarButton *shareBtn;
@property (strong, nonatomic) DynamicPictureModel *currentModel;

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
        titleLabel.font = [UIFont systemFontOfSize:19];
        titleLabel.numberOfLines = 0;
        [topView addSubview:titleLabel];
        
        _backView = [[UIView alloc]init];
        _backView.userInteractionEnabled = YES;
        [self.contentView addSubview:_backView];
        
        _placeImage = [UIImageView new];
        
        _placeImage.contentMode = UIViewContentModeScaleAspectFit;
        _placeImage.userInteractionEnabled = YES;
        [_backView addSubview:_placeImage];
        
        _vipView = [UIImageView new];
        _vipView.userInteractionEnabled = YES;
        _vipView.image = [UIImage imageNamed:@"vip"];
        [_backView addSubview:_vipView];
        
        _pauseOrPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseOrPlayBtn setBackgroundImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
        _pauseOrPlayBtn.clipsToBounds = YES;
        _pauseOrPlayBtn.layer.cornerRadius = 30;
        //_pauseOrPlayBtn.backgroundColor = [UIColor redColor];
        [_backView addSubview:_pauseOrPlayBtn];
        
        UIView *toolBar = [[UIView alloc] init];
        toolBar.backgroundColor = [UIColor whiteColor];
        self.toolBar = toolBar;
        [self.contentView addSubview:toolBar];
        
        CGFloat leftMargin = 20;
        CGFloat btnWidth = 50;
        NSInteger btnCount = 4;
        CGFloat margin = (kMainWidth - leftMargin * 2 - btnWidth * btnCount) / (btnCount - 1);
        
        DPToolBarButton *supporBtn = [DPToolBarButton buttonWithType:UIButtonTypeCustom];
        self.supporBtn = supporBtn;
        [supporBtn setImage:[UIImage imageNamed:@"dianzan---no"] forState:UIControlStateNormal];
        [supporBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateSelected];
        supporBtn.titleLabel.font = [UIFont systemFontOfSize:kPicToolBarFontSize];
        [supporBtn setTitleColor:[UIColor hexStringToColor:@"999999"] forState:UIControlStateNormal];
        CGFloat supportH = 15;
        CGFloat supportY = 12.5;
        supporBtn.frame = CGRectMake(leftMargin, supportY, btnWidth, supportH);
        supporBtn.tag = 100;
        [supporBtn addTarget:self action:@selector(toolBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:supporBtn];
        
        DPToolBarButton *oppsitionBtn = [DPToolBarButton buttonWithType:UIButtonTypeCustom];
        self.oppsitionBtn = oppsitionBtn;
        [oppsitionBtn setImage:[UIImage imageNamed:@"comment-gray-"] forState:UIControlStateNormal];
        [oppsitionBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateSelected];
        oppsitionBtn.titleLabel.font = [UIFont systemFontOfSize:kPicToolBarFontSize];
        [oppsitionBtn setTitleColor:[UIColor hexStringToColor:@"999999"] forState:UIControlStateNormal];
        CGFloat oppsitionX = supporBtn.right + margin;
        oppsitionBtn.frame = CGRectMake(oppsitionX, supportY, btnWidth, supportH);
        oppsitionBtn.tag = 101;
        [oppsitionBtn addTarget:self action:@selector(toolBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:oppsitionBtn];
        
        UIView *centerLineView = [[UIView alloc] initWithFrame:CGRectMake(kMainWidth / 2, supportY, 1, supportH)];
        centerLineView.backgroundColor = [UIColor hexStringToColor:@"#F3F3F3"];
        [toolBar addSubview:centerLineView];
        
        UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(centerLineView.left - margin - btnWidth, supportY, 1, supportH)];
        leftLineView.backgroundColor = [UIColor hexStringToColor:@"#F3F3F3"];
        [toolBar addSubview:leftLineView];
        
        UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectMake(centerLineView.right + margin + btnWidth, supportY, 1, supportH)];
        rightLineView.backgroundColor = [UIColor hexStringToColor:@"#F3F3F3"];
        [toolBar addSubview:rightLineView];
        
        DPToolBarButton *commentBtn = [DPToolBarButton buttonWithType:UIButtonTypeCustom];
        self.commentBtn = commentBtn;
        [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [commentBtn setImage:[UIImage imageNamed:@"shoucang_hui"] forState:UIControlStateNormal];
        [commentBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateSelected];
        commentBtn.titleLabel.font = [UIFont systemFontOfSize:kPicToolBarFontSize];
        [commentBtn sizeToFit];
        CGFloat commentX = oppsitionBtn.right + margin;
        commentBtn.frame = CGRectMake(commentX, supportY, btnWidth, supportH);
        commentBtn.tag = 102;
        [commentBtn addTarget:self action:@selector(toolBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:commentBtn];
        
        DPToolBarButton *shareBtn = [DPToolBarButton buttonWithType:UIButtonTypeCustom];
        self.shareBtn = shareBtn;
        [shareBtn setImage:[UIImage imageNamed:@"share---no"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateSelected];
        shareBtn.titleLabel.font = [UIFont systemFontOfSize:kPicToolBarFontSize];
        [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CGFloat shareX = commentBtn.right + margin;
        shareBtn.frame = CGRectMake(shareX, supportY, btnWidth, supportH);
        shareBtn.tag = 103;
        [shareBtn addTarget:self action:@selector(toolBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:shareBtn];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
}

- (void)setPicFrameModel:(PictureFrameModel *)picFrameModel {
    _picFrameModel = picFrameModel;
    DynamicPictureModel *model = picFrameModel.pictureModel;
    self.currentModel = model;
    
    self.titleLabel.text = model.title;
    
    [_placeImage sd_setImageWithURL:[NSURL URLWithString:self.currentModel.pic_url] placeholderImage:nil];
    _vipView.alpha = [model.price boolValue];
    [self.supporBtn setTitle:model.goodnum forState:UIControlStateNormal];
    [self.oppsitionBtn setTitle:model.commentnum forState:UIControlStateNormal];
    [self.shareBtn setTitle:model.favnum forState:UIControlStateNormal];
    self.supporBtn.selected = model.supported;
    //self.oppsitionBtn.enabled = !model.supported;
    self.oppsitionBtn.selected = model.oppositioned;
    self.supporBtn.enabled = !model.oppositioned;
    [self.commentBtn setTitle:model.commentnum forState:UIControlStateNormal];
    self.commentBtn.selected = model.commented;
    self.shareBtn.selected = model.shared;
    
    self.topView.frame = CGRectMake(0, 0, kMainWidth, picFrameModel.topViewHeight);
    self.titleLabel.frame = picFrameModel.titleLabelFrame;
    self.backView.frame = picFrameModel.pictureFrame;
    self.placeImage.frame = self.backView.bounds;
    _vipView.frame = CGRectMake(_backView.bounds.size.width-50, 10, 50, 23);
    self.pauseOrPlayBtn.frame = CGRectMake((self.backView.bounds.size.width-60)/2, (_backView.bounds.size.height-60)/2, 60, 60);
    self.toolBar.frame = picFrameModel.toolBarFrame;
}

- (void)gifLoaded:(DynamicPictureModel *)model imageSize:(CGSize)imageSize
{
    if ([self.delegate respondsToSelector:@selector(pictureCell:GIFLoaded:imageSize:)])
    {
        [self.delegate pictureCell:self GIFLoaded:model imageSize:imageSize];
    }
}

- (void)toolBarButtonClick:(UIButton *)sender
{

    if ([self.delegate respondsToSelector:@selector(pictureCell:toolBarButtonDidClick:)])
    {
        [self.delegate pictureCell:self toolBarButtonDidClick:sender];
    }
}

@end
